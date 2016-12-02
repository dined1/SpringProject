<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-edit fa-fw"></i> <b> Update Discountrule</b></h5> 
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${appPath}/discountrule/update" method="POST">
                                    <div class="form-group">
                                        <label for="DRId">DRId</label>
                                        <input class="form-control" type="number" name="DRId" readonly value="${DISCOUNTRULE.DRId}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="discountValue">Discount Value</label>
                                        <input class="form-control" type="number" name="discountValue"  value="${DISCOUNTRULE.discountValue}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="discountProcent">Discount Procent</label>
                                        <input class="form-control" type="number" name="discountProcent"  value="${DISCOUNTRULE.discountProcent}" />
                                    </div>     
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Update</button>
                                    <a href="${appPath}/discountrule/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
