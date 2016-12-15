<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-edit fa-fw"></i> <b> Update Address</b></h5> 
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/admin/address/update" method="POST">
                                    <div class="form-group">
                                        <label for="addressId">Address Id</label>
                                        <input class="form-control" type="number" name="addressId" readonly value="${ADDRESS.addressId}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="addressLine">Address Line</label>
                                        <input class="form-control" type="text" name="addressLine"  value="${ADDRESS.addressLine}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="city">City</label>
                                        <input class="form-control" type="text" name="city"  value="${ADDRESS.city}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="country">Country</label>
                                        <input class="form-control" type="text" name="country"  value="${ADDRESS.country}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="postalCode">Postal Code</label>
                                        <input class="form-control" type="text" name="postalCode"  value="${ADDRESS.postalCode}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="modifiedDate">Modified Date</label>
                                        <input class="form-control" type="text" name="modifiedDate"  value="${ADDRESS.modifiedDate}" />
                                    </div>     
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Update</button>
                                    <a href="${contextPath}/admin/address/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
