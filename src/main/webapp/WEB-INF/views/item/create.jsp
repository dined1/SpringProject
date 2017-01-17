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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Create a new Item </b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/admin/item/new" method="POST">
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input class="form-control" type="text" name="name" path="name"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="type">Type</label>
                                        <input class="form-control" type="text" name="type" path="type"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <input class="form-control" type="text" name="description" path="description"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="defMP">Discount Value</label>
                                        <input class="form-control" type="number" name="defMP" path="defMP"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="defOTP">Discount Procent</label>
                                        <input class="form-control" type="number" name="defOTP" path="defOTP"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="quantity">Amount</label>
                                        <input class="form-control" type="number" name="quantity" path="quantity"  />
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
                                    <a href="${contextPath}/admin/item/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
