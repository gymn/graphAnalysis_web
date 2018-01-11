<%--
  Created by IntelliJ IDEA.
  User: hunan
  Date: 2018/1/8
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="tab-pane fade" id="community">
    <div class="modal fade" id="lcd-add-modal" tabindex="-1" role="dialog" aria-labelledby="lcd-ModalLabel" aria-hidden="true">
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
                                <span id="dataset-lcd">DataSet</span>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation">
                                    <a role="menuitem" onclick="setDataSet('dataset-lcd',this)">Karate</a>
                                </li>
                                <li role="presentation">
                                    <a role="menuitem" onclick="setDataSet('dataset-lcd',this)">Jazz</a>
                                </li>
                            </ul>
                        </div>
                        <button type="button" class="btn btn-info " data-toggle="modal" data-target="#lcd-add-modal">
                            <span class="glyphicon glyphicon-plus"></span>
                            add
                        </button>
                    </div>
                    <div class="form-group">
                        <div>Seeds: <br><input class="form-control" type="text" id="seeds" value="30,17" ></div>
                        <div>Max steps for community center search<br><input class="form-control" type="number" id="maxSteps" value="1" step="1"></div>
                        <div>Gravitation threshold<br><input class="form-control" type="number" id="attractThreshold" min="0.1" max="1.0" step="0.1" value="0.8"></div>
                        <button type="button" class="btn btn-primary btn-block glyphicon glyphicon-refresh" onclick="callCommunity()">Perform calculation</button>
                        <img src="../resources/img/wait.gif" id="wait-2">
                    </div>
                </form><br>
                <div>
                    <span class="label label-info">Type</span><br>
                    <input type="radio" name="node-type-2" value="all" checked="checked" > All<br>
                    <input type="radio" name="node-type-2"  value="in"> Local community<br>
                    <input type="radio" name="node-type-2"  value="out"> Non local community
                    <br>
                    <span class="label label-info">Layout</span><br>
                    <label for="force-2"><input type="radio" name="graph-layout-2" id="force-2" value="force" checked="checked" > Force</label>
                    <label for="circle-2"><input type="radio" name="graph-layout-2" id="circle-2" value="circular"> Circle</label>
                    <button type="button" class="btn btn-primary btn-block glyphicon glyphicon-fire" onclick="drawPanel2('chart-LC')">Render view</button>
                </div>
            </div>

            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Result
                            <span style="float: right;">F: <span id="lcd-f">0.0</span></span>
                            <span style="float: right;">Precision: <span id="lcd-precision">0.0</span>&nbsp;&nbsp;</span>
                            <span style="float: right;">Recall: <span id="lcd-recall">0.0</span>&nbsp;&nbsp;</span>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="chart-LC" style="width: auto;height:80%;"></div>
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
                        <div id="chart-LC-test" style="width: auto;height:80%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
