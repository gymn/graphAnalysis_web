<%--
  Created by IntelliJ IDEA.
  User: hunan
  Date: 2017/11/30
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Complex Network Analytics</title>
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css">
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/echarts.min.js"></script>

</head>
<body style="padding-top: 5px;">
<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#link" data-toggle="tab" class="glyphicon glyphicon-link">DTLPLP</a></li>
    <li><a href="#community" data-toggle="tab" class="glyphicon glyphicon-th">DLCD-CCE</a></li>
    <li class="dropdown">
        <a href="#" id="myTabDrop1" class="dropdown-toggle glyphicon glyphicon-search"
           data-toggle="dropdown">
            RelatedWorks <b class="caret"></b></a>
        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
            <li><a href="#paper" tabindex="-1" data-toggle="tab">Papers</a></li>
            <li><a href="#patent" tabindex="-1" data-toggle="tab">Patents</a></li>
        </ul>
    </li>
</ul>

<div id="myTabContent" class="tab-content">
    <!-- 时序链路预测界面 -->
    <jsp:include page="tlp.jsp"/>

    <!-- 社团挖掘界面 -->
    <jsp:include page="lcd.jsp"/>

    <div class="tab-pane fade" id="paper">
        <p>《Distributed Temporal Link Prediction Algorithm based on Label Propagation》</p>
    </div>
    <div class="tab-pane fade" id="patent">
        <p>《一种基于标签传播算法的分布式时序链路预测算法》</p>
    </div>
</div>

    <script>
        window.onload = function () {
            $('#wait-1').hide();
            $('#wait-2').hide();
            var range = document.getElementById("range-1");
            var rangeMax = document.getElementById("range-max");
            $.get("<%=basePath%>file/maxWeight",function (data) {
                range.setAttribute("max", data);
                rangeMax.innerText=data;
            });
        };

        function setDataSet(dsId,obj){
            $("#"+dsId).text(obj.innerText);
            $("#"+dsId).attr("selected",true);
        }

        function callLink() {
            $('#wait-1').show();
            var graphFilePath = $('#file-1').val();
            var narrowIndex = document.getElementById("narrowIndex").value;
            var numberOfWindows = document.getElementById("numberOfWindows").value;
            $.get("<%=basePath%>spark/tl",{graphFilePath:graphFilePath,narrowIndex:narrowIndex,numberOfWindows:numberOfWindows},function (data) {
                $('#wait-1').hide();
                alert(data);
                //设置阈值控制组件
                var range = document.getElementById("range-1");
                var rangeMax = document.getElementById("range-max");
                $.get("<%=basePath%>file/maxWeight",function (data) {
                    range.setAttribute("max", data);
                    rangeMax.innerText=data;
                });
            });
        }

        function callCommunity() {
            $('#wait-2').show();
            var graphFilePath = $('#file-2').val();
            var seeds = $('#seeds').val();
            var maxSteps = $('#maxSteps').val();
            var attractThreshold = $('#attractThreshold').val();

            $.get("<%=basePath%>spark/lc",{graphFilePath:graphFilePath,seeds:seeds,maxSteps:maxSteps,attractThreshold:attractThreshold},function (data) {
                $('#wait-2').hide();
                alert(data);
            })
        }

        function showCurrentRangeValue(){
            document.getElementById("range-value").innerText=document.getElementById("range-1").value;
        }

        function drawPanel1(panelId) {
            var layout = '';
            var radio = document.getElementsByName("graph-layout-1");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked === true) {
                    layout = radio[i].value;
                    break;
                }
            }

            if($("#dataset-tlp").attr("selected")) {
                var rangeValue = document.getElementById("range-1").value;
                var dataset = $("#dataset-tlp").text()
                $.getJSON("<%=basePath%>file/tlp/data", {threshold: rangeValue, dataset: dataset}, function (data) {
                    drawGraph(data.graph,panelId,layout);
                    drawGraph(data.testGraph,panelId+"-test",layout);
                    $("#tlp-precision").text(data.metrics.precision);
                    $("#tlp-auc").text(data.metrics.auc);
                });
            }else{
                alert("No dataset selected!")
            }
        }

        function drawPanel2(panelId) {
            if($("#dataset-lcd").attr("selected")) {
                var layout = '';
                var radio = document.getElementsByName("graph-layout-2");
                for (var i = 0; i < radio.length; i++) {
                    if (radio[i].checked === true) {
                        layout = radio[i].value;
                        break;
                    }
                }

                var type = '';
                var nodeTypeRadio = document.getElementsByName("node-type-2");
                for (var j = 0; j < nodeTypeRadio.length; j++) {
                    if (nodeTypeRadio[j].checked === true) {
                        type = nodeTypeRadio[j].value;
                        break;
                    }
                }

                var dataset = $("#dataset-lcd").text()
                $.getJSON("<%=basePath%>file/lcd/data",{nodeType: type, dataset: dataset},function (data) {
                    drawGraph(data.graph,panelId,layout);
                    drawGraph(data.testGraph,panelId+'-test',layout);
                    $("#lcd-precision").text(data.metrics.precision);
                    $("#lcd-recall").text(data.metrics.recall);
                    $("#lcd-f").text(data.metrics.f);
                });
            }else{
                alert("No dataset selected!")
            }
        }

        function drawGraph(graphData ,panelId, layout){
            var text = "";
            if(panelId==="chart-TL"|| panelId==="chart-TL-test")
                text='temporal link prediction';
            else
                text = 'local community detection';
            var myChart = echarts.init(document.getElementById(panelId));
            myChart.showLoading();

            var graph = graphData;
            var categories = [{name:"nodes"}];
            if(panelId==="chart-LC" || panelId==="chart-LC-test")
                categories = [{name:"Non LC nodes"},{name:"LC nodes"}];
            myChart.hideLoading();

            var option = {
                title: {
                    text: text,
                    subtext: layout,
                    top: 'bottom',
                    left: 'right'
                },
                legend: [{
                    // selectedMode: 'single',
                    data: categories.map(function (a) {
                        return a.name;
                    })
                }],
                tooltip: {},
                animationDuration: 1500,
                animationEasingUpdate: 'quinticInOut',
                series : [
                    {
                        name: 'temporal link prediction',
                        type: 'graph',
                        layout: layout,
                        categories:categories,
                        data: graph.nodes,
                        links: graph.links,
                        roam: true,
                        draggable:true,
                        focusNodeAdjacency:true,
                        label: {
                            normal: {
                                fontSize:10,
                                position: 'right',
                                show:true
                            }
                        },
                        force: {
                            repulsion: 100
                        },
                        lineStyle: {
                            normal: {
                                color: 'blue',
                                curveness: 0.3
                            }
                        }
                    }
                ]
            };
            myChart.clear();
            myChart.setOption(option);
        }
    </script>
</body>
</html>
