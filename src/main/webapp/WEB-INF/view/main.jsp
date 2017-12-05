<%--
  Created by IntelliJ IDEA.
  User: hunan
  Date: 2017/11/30
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
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
                        <form id="uploadForm" class="form-group">
                            <label for="file1">请选择文件</label>
                            <input type="file" id="file1" class="btn btn-primary form-control"/>
                            <button type="button" class="btn btn-primary glyphicon glyphicon-open" onclick="doUpload()">上传</button>
                        </form>
                        <div>
                            <button type="button" class="btn btn-primary btn-block glyphicon glyphicon-refresh" onclick="callLink()">执行计算</button>
                        </div>
                    <br>
                        <div id="draw-1">
                            <input type="range" min="0" max="50" value="0" id="range-1">
                            <button type="button" id="draw-button-1" class="btn btn-primary btn-block glyphicon glyphicon-fire" onclick="drawPanel1('chart-TL')">视图渲染</button>
                            <output />
                        </div>
                </div>
                <div class="col-md-10">
                    <h2>视图面板</h2>
                    <hr/>
                    <div id="chart-TL" style="width: 800px;height:700px;"></div>
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
                    <form id="uploadForm2" class="form-group">
                        <label for="file1">请选择文件</label>
                        <input type="file" name="file1" id="file2" class="btn btn-primary form-control"/>
                        <button type="button" class="btn btn-primary glyphicon glyphicon-open" onclick="doUpload()">上传</button>
                    </form>
                    <button type="button" class="btn btn-primary btn-block" onclick="callLink()">执行计算</button>
                    <button type="button" class="btn btn-primary btn-block" onclick="drawGraph('chart-LC')">视图渲染</button>
                </div>
                <div class="col-md-10">
                    <h2>视图面板</h2>
                    <hr/>
                    <div id="chart-LC" style="width: 600px;height:400px;"></div>
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
        function doUpload() {
            var formData = new FormData($("#uploadForm")[0]);
            $.ajax({
                url: 'http://localhost:8080/file/upload',
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata){
                    alert(returndata);
                },
                error: function(returndata) {
                    alert(returndata);
                }
            })
        }

        function callLink() {

            alert("执行完毕！");

            //添加阈值控制组件
            var range = document.getElementById("range-1");
            range.setAttribute("min", "0");
            range.setAttribute("max", "30");
        }

        function drawPanel1(panelId) {
            var rangeValue = document.getElementById("range-1").value;
            var c = document.getElementById(panelId);
            drawGraph("http://localhost:8080/file/json/tl",{threshold:rangeValue,graphType:"force"},panelId)
        }

        function drawPanel2() {

        }

        function drawGraph(url,attr,panelId){
            var myChart = echarts.init(document.getElementById(panelId));
            myChart.showLoading();
            $.getJSON(url,attr,function (data) {
                var webkitDep = data;
                myChart.hideLoading();

                option = {
                    legend: {
                        data: ['类别1']//此处的数据必须和关系网类别中name相对应
                    },
                    series: [{
                        type: 'graph',
                        layout: 'force',
                        animation: false,
                        label: {
                            normal: {
                                show:true,
                                position: 'center'
                            }
                        },
                        draggable: true,
                        data: webkitDep.nodes.map(function (node, idx) {
                            node.id = idx;
                            return node;
                        }),
                        categories: webkitDep.categories,
                        force: {
                            edgeLength: 105,//连线的长度
                            repulsion: 100  //子节点之间的间距
                        },
                        edges: webkitDep.links
                    }]
                };
                myChart.clear();
                myChart.setOption(option);
            })

        }
    </script>
</body>
</html>
