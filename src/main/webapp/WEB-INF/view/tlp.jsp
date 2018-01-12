<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%--
  Created by IntelliJ IDEA.
  User: hunan
  Date: 2018/1/8
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="tab-pane fade in active" id="link">
    <div class="modal fade" id="tlp-add-modal" tabindex="-1" role="dialog" aria-labelledby="tlp-ModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        Add data set
                    </h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="form-group">
                            name<input class="form-control" id="tlp-ds-name" type="text"/>
                            train<input class="form-control" id="tlp-ds-train" type="text"/>
                            test<input class="form-control" id="tlp-ds-test" type="text"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close
                    </button>
                    <button type="button" class="btn btn-primary" onclick="addDataSet('tlp',0)">
                        Add
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <div class="container" style="width: auto">
        <br>
        <div class="row">
            <div class="col-md-2">
                <form role="form">
                    <div class="form-group">
                        <div class="dropdown" style="float: left">
                            <button type="button" class="btn dropdown-toggle" id="dropdownMenu1"
                                    data-toggle="dropdown">
                                <span id="dataset-tlp">DataSet</span>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <c:forEach var="datasetName" items="${tlpDatasetList}">
                                    <li role="presentation">
                                        <a role="menuitem" onclick="setDataSet('dataset-tlp',this)">${datasetName}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <button type="button" class="btn btn-info " data-toggle="modal" data-target="#tlp-add-modal">
                            <span class="glyphicon glyphicon-plus"></span>
                            add
                        </button>
                    </div>

                    <div class="form-group">
                        <div>Historical factor<br><input class="form-control" id="narrowIndex" type="number" value="0.8" min="0.1" max="1" step="0.1"></div>
                        <div>Windows<br><input class="form-control" id="numberOfWindows" type="number" value="5" min="1" max="100" step="1"></div>
                        <button type="button" class="btn btn-primary btn-block glyphicon glyphicon-refresh" onclick="callLink()">Perform calculation</button>
                        <img src="<%=basePath%>resources/img/wait.gif" id="wait-1">

                <br>
                <div id="draw-1">
                    <div style="float:left">0</div><div style="float:right" id="range-max">50</div>
                    <input class="form-control" step="0.01" type="range" min="0" max="50" value="0" id="range-1" onchange="showCurrentRangeValue()">
                    <div><div style="float:left">Threshold: </div><div style="float:left" id = "range-value">0</div></div><br>
                    <label for="force-1"><input type="radio" name="graph-layout-1" id="force-1" value="force" checked="checked" >Force</label>
                    <label for="circle-1"><input type="radio" name="graph-layout-1" id="circle-1" value="circular">Circle</label>
                    <button type="button" id="draw-button-1" class="btn btn-primary btn-block glyphicon glyphicon-fire" onclick="drawPanel1('chart-TL')">Render view</button>
                </div>
                    </div>
                </form>
            </div>

            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Result
                            <span style="float: right;">Precision: <span id="tlp-precision">0.0</span></span>
                            <span style="float: right;">AUC: <span id="tlp-auc">0.0</span>&nbsp;&nbsp;</span>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="chart-TL" style="width: auto;height:80%;"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Testing
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="chart-TL-test" style="width: auto;height:80%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function callLink() {
        if($("#dataset-tlp").attr("selected")) {
            $('#wait-1').show();
            var name = $('#dataset-tlp').text();
            var narrowIndex = $("#narrowIndex").val();
            var numberOfWindows = $("#numberOfWindows").val();
            var data = {
                name: name,
                narrowIndex: narrowIndex,
                numberOfWindows: numberOfWindows
            };
            $.ajax({
                'type':'POST',
                    'url': "<%=basePath%>spark/tlp",
                    'contentType' : 'application/json',
                    'data':JSON.stringify(data),
                'success': function (data) {
                    $('#wait-1').hide();
                    alert(data);
                    //设置阈值控制组件
                    var range = document.getElementById("range-1");
                    var rangeMax = document.getElementById("range-max");
                    $.get("<%=basePath%>file/tlp/maxWeight", function (data) {
                        range.setAttribute("max", data);
                        rangeMax.innerText = data;
                    });
                }
        });
        }else{
            alert("No dataset selected!")
        }
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


        var rangeValue = document.getElementById("range-1").value;
        var dataset = $("#dataset-tlp").text()
        $.getJSON("<%=basePath%>file/tlp/data", {threshold: rangeValue}, function (data) {
            drawGraph(data.graph,panelId,layout);
            drawGraph(data.testGraph,panelId+"-test",layout);
            $("#tlp-precision").text(data.metrics.precision);
            $("#tlp-auc").text(data.metrics.auc);
        });

    }
</script>
