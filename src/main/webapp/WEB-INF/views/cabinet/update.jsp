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
                        <h5><i class="fa fa-edit fa-fw"></i> <b> Update Customer</b></h5> 
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/cabinet/update" method="POST">
                                    <div class="form-group">
                                        <label for="customerId">Customer Id</label>
                                        <input class="form-control" type="number" name="customerId" readonly value="${CUSTOMER.customerId}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="firstName">First Name</label>
                                        <input class="form-control" type="text" name="firstName"  value="${CUSTOMER.firstName}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="lastName">Last Name</label>
                                        <input class="form-control" type="text" name="lastName"  value="${CUSTOMER.lastName}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="contact">Contact</label>
                                        <input class="form-control" type="text" name="contact"  value="${CUSTOMER.contact}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input class="form-control" type="text" name="email"  value="${CUSTOMER.email}" />
                                    </div>     
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input class="form-control" type="text" name="phone"  value="${CUSTOMER.phone}" />
                                    </div>
                                    <div class="form-group">
                                        <label for="address1">Address</label>
                                        <select path="address1" name="address1" onchange=" ">
                                            <option value="ord_null">Нет</option>
                                            <c:forEach items="${ADDRESS_LIST}" var="ADDRESS">
                                                <option value="${CUSTOMER.address1}">${ADDRESS.addressLine}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Update</button>
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
