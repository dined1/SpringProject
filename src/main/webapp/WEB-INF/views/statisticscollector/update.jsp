<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-edit fa-fw"></i> <b> Update Statisticscollector</b></h5> 
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${appPath}/statisticscollector/update" method="POST">
                                    <div class="form-group">
                                        <label for="SCId">SCId</label>
                                        <input class="form-control" type="number" name="SCId" readonly value="${STATISTICSCOLLECTOR.SCId}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="statisticType">Statistic Type</label>
                                        <input class="form-control" type="text" name="statisticType"  value="${STATISTICSCOLLECTOR.statisticType}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="statisticsInfo">Statistics Info</label>
                                        <input class="form-control" type="text" name="statisticsInfo"  value="${STATISTICSCOLLECTOR.statisticsInfo}" />
                                    </div>     
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Update</button>
                                    <a href="${appPath}/statisticscollector/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
