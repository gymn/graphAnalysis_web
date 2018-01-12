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
    <link rel="stylesheet" href="<%=basePath%>resources/css/bootstrap.min.css">
    <script src="<%=basePath%>resources/js/jquery-3.1.1.min.js"></script>
    <script src="<%=basePath%>resources/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>resources/js/echarts.min.js"></script>

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
            $.get("<%=basePath%>file/tlp/maxWeight",function (data) {
                range.setAttribute("max", data);
                rangeMax.innerText=data;
            });

            $.get()
        };

        function addDataSet(typeName,code) {
            var name = $("#"+typeName+"-ds-name").val();
            if(name==='')
                alert("Unspecified name!");
            var trainPath = $("#"+typeName+"-ds-train").val();
            if(trainPath==='')
                alert("Unspecified train data path!");
            var testPath = $("#"+typeName+"-ds-test").val();
            if(testPath==='')
                alert("Unspecified test data path!");

            var data = {
                name:name,
                trainPath:trainPath,
                testPath:testPath,
                type:code
            };

            $.ajax({
                    'type':'POST',
                    'url': "<%=basePath%>file/dataset/add",
                'contentType' : 'application/json',
                'data':JSON.stringify(data),
                'success':function (data) {
                    if(data==='no'){
                        alert("Failed to add existed data set name!");
                    }else{
                        if(code===0){
                            var ps = document.createElement("li");
                            ps.setAttribute("role","presentation");
                            ps.innerHTML = '<a role="menuitem" onclick="setDataSet(\'dataset-tlp\',this)">'+name+'</a>';
                            $("#link ul").append(ps);
                        }else if(code===1){
                            var ps = document.createElement("li");
                            ps.setAttribute("role","presentation");
                            $("#community ul").append(ps);
                            ps.innerHTML = '<a role="menuitem" onclick="setDataSet(\'dataset-lcd\',this)">'+name+'</a>';
                        }
                        $("#"+typeName+"-add-modal").modal('hide');
                    }
                }});
        }
        function setDataSet(dsId,obj){
            $("#"+dsId).text(obj.innerText);
            $("#"+dsId).attr("selected",true);
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
