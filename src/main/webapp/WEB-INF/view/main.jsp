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
    <title>复杂网络分析系统</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/echarts/3.8.5/echarts.min.js"></script>

</head>
<body>
<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#link" data-toggle="tab" class="glyphicon glyphicon-link">时序链路预测</a></li>
    <li><a href="#community" data-toggle="tab" class="glyphicon glyphicon-th">局部社团挖掘</a></li>
    <li class="dropdown">
        <a href="#" id="myTabDrop1" class="dropdown-toggle glyphicon glyphicon-search"
           data-toggle="dropdown">
            相关学术成果 <b class="caret"></b></a>
        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
            <li><a href="#paper" tabindex="-1" data-toggle="tab">论文</a></li>
            <li><a href="#patent" tabindex="-1" data-toggle="tab">专利</a></li>
        </ul>
    </li>
</ul>

<div id="myTabContent" class="tab-content">
    <!-- 时序链路预测界面 -->
    <div class="tab-pane fade in active" id="link">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <h2>操作面板</h2>
                    <hr/>
                        <form>
                            <div>文件路径：<br><input id="file-1" type="text" value="/home/hunan/file/tl/tl_test_01.csv"></div>
                            <div>历史影响因子：<br><input id="narrowIndex" type="number" value="0.8" min="0.1" max="1" step="0.1"></div>
                            <div>窗口数量：<br><input id="numberOfWindows" type="number" value="5" min="1" max="100" step="1"></div>
                            <button type="button" class="btn btn-primary btn-block glyphicon glyphicon-refresh" onclick="callLink()">执行计算</button>
                            <img src="<%=request.getContextPath()%>/img/wait.gif" id="wait-1">
                        </form>
                    <br>
                        <div id="draw-1">
                            <div style="float:left">0</div><div style="float:right" id="range-max">50</div>
                            <input type="range" min="0" max="50" value="0" id="range-1" onchange="showCurrentRangeValue()">
                            <div><div style="float:left">当前阈值：</div><div style="float:left" id = "range-value">0</div></div><br>
                            <label for="force-1"><input type="radio" name="graph-layout-1" id="force-1" value="force" checked="checked" > 力引导布局</label>
                            <label for="circle-1"><input type="radio" name="graph-layout-1" id="circle-1" value="circular"> 环形布局</label>
                            <button type="button" id="draw-button-1" class="btn btn-primary btn-block glyphicon glyphicon-fire" onclick="drawPanel1('chart-TL')">视图渲染</button>
                            <output />
                        </div>
                </div>
                <div class="col-md-10">
                    <h2 align="center">视图面板</h2>
                    <hr/>
                    <div id="chart-TL" style="width: 1000px;height:800px;"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- 社团挖掘界面 -->
    <div class="tab-pane fade" id="community">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <h2>操作面板</h2>
                    <hr/>
                    <div>
                        <div>文件路径：<br><input type="text" id="file-2" value="/home/hunan/file/lc/karateEdges.csv"></div>
                        <div>种子节点：<br><input type="text" id="seeds" value="30,17" ></div>
                        <div>寻找社团中心最大步数：<br><input type="number" id="maxSteps" value="1" step="1"></div>
                        <div>社团吸引度阈值：<br><input type="number" id="attractThreshold" min="0.1" max="1.0" step="0.1" value="0.8"></div>
                        <button type="button" class="btn btn-primary btn-block" onclick="callCommunity()">执行计算</button>
                        <img src="../img/wait.gif" id="wait-2">
                    </div>
                        <span class="label label-info">节点类型选择</span><br>
                        <input type="radio" name="node-type-2" value="all" checked="checked" > 所有节点
                        <input type="radio" name="node-type-2"  value="in"> 特征节点
                        <input type="radio" name="node-type-2"  value="out"> 非特征节点
                    <br>
                        <span class="label label-info">布局方式选择</span><br/>
                        <label for="force-2"><input type="radio" name="graph-layout-2" id="force-2" value="force" checked="checked" > 力引导布局</label>
                        <label for="circle-2"><input type="radio" name="graph-layout-2" id="circle-2" value="circular"> 环形布局</label>
                    <button type="button" class="btn btn-primary btn-block" onclick="drawPanel2('chart-LC')">视图渲染</button>
                </div>
                <div class="col-md-10">
                    <h2 align="center">视图面板</h2>
                    <hr/>
                    <div id="chart-LC" style="width: 1000px;height:800px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane fade" id="paper">
        <p>论文：《一种基于标签传播算法的分布式时序链路预测算法》--胡楠</p>
    </div>
    <div class="tab-pane fade" id="patent">
        <p>专利：《一种基于标签传播算法的分布式时序链路预测算法》</p>
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
            var rangeValue = document.getElementById("range-1").value;
            var layout='';
            var radio = document.getElementsByName("graph-layout-1");
            for(var i=0;i<radio.length;i++){
                if(radio[i].checked===true){
                    layout = radio[i].value;
                    break;
                }
            }
            drawGraph("<%=basePath%>file/json/tl",{threshold:rangeValue,graphType:layout},panelId);
        }

        function drawPanel2(panelId) {
            var layout='';
            var radio = document.getElementsByName("graph-layout-2");
            for(var i=0;i<radio.length;i++){
                if(radio[i].checked===true){
                    layout = radio[i].value;
                    break;
                }
            }

            var type='';
            var nodeTypeRadio = document.getElementsByName("node-type-2");
            for(var j=0;j<nodeTypeRadio.length;j++){
                if(nodeTypeRadio[j].checked===true){
                    type = nodeTypeRadio[j].value;
                    break;
                }
            }

            drawGraph("<%=basePath%>file/json/lc",{nodeType:type,graphType:layout},panelId);
        }

        function drawGraph(url,attr,panelId){
            var text = "";
            if(panelId==="chart-TL")
                text='temporal link prediction';
            else
                text = 'feature node detection';
            var myChart = echarts.init(document.getElementById(panelId));
            myChart.showLoading();
            $.getJSON(url,attr,function (data) {
                var graph = data;
                var categories = [{name:"类别1"}];
                if(panelId==="chart-LC")
                    categories = [{name:"非特征节点"},{name:"特征节点"}];
                myChart.hideLoading();

                var option = {
                    title: {
                        text: text,
                        subtext: attr.graphType,
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
                            layout: attr.graphType,
                            categories:categories,
                            data: graph.nodes.map(function (node) {
                                node.symbolSize = node.symbolSize*10;
                                return node;
                            }),
                            links: graph.links,
                            roam: true,
                            draggable:true,
                            focusNodeAdjacency:true,
                            label: {
                                normal: {
                                    position: 'right',
                                    formatter: '{b}'
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
            })

        }
    </script>
</body>
</html>
