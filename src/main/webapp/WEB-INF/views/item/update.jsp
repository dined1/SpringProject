<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-edit fa-fw"></i> <b> Update Item</b></h5> 
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${appPath}/item/update" method="POST">
                                    <div class="form-group">
                                        <label for="itemId">Item Id</label>
                                        <input class="form-control" type="number" name="itemId" readonly value="${ITEM.itemId}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input class="form-control" type="text" name="name"  value="${ITEM.name}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="type">Type</label>
                                        <input class="form-control" type="text" name="type"  value="${ITEM.type}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <input class="form-control" type="text" name="description"  value="${ITEM.description}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="defMP">Def MP</label>
                                        <input class="form-control" type="number" name="defMP"  value="${ITEM.defMP}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="defOTP">Def OTP</label>
                                        <input class="form-control" type="number" name="defOTP"  value="${ITEM.defOTP}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="modifiedDate">Modified Date</label>
                                        <input class="form-control" type="text" name="modifiedDate"  value="${ITEM.modifiedDate}" />
                                    </div>     
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Update</button>
                                    <a href="${appPath}/item/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
