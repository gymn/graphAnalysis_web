<%--
  Created by IntelliJ IDEA.
  User: hunan
  Date: 2018/1/8
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
                            name<input class="form-control" type="text"/>
                            train<input class="form-control" type="text"/>
                            test<input class="form-control" type="text"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close
                    </button>
                    <button type="button" class="btn btn-primary">
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
                                <li role="presentation">
                                    <a role="menuitem" onclick="setDataSet('dataset-tlp',this)">Enron_email</a>
                                </li>
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
                        <img src="../resources/img/wait.gif" id="wait-1">

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
