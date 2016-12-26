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
                                <form role="form" action="${contextPath}/cabinet/customer/update" method="POST">
                                    <div class="form-group">
                                        <label for="firstName">First Name</label>
                                        <input class="form-control" type="text" name="firstName" path="firstName"  value="${CUSTOMER.firstName}"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName">Last Name</label>
                                        <input class="form-control" type="text" name="lastName" path="lastName"  value="${CUSTOMER.lastName}"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="contact">Contact</label>
                                        <input class="form-control" type="text" name="contact" path="contact" value="${CUSTOMER.contact}" />
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input class="form-control" type="text" name="email" path="email" value="${CUSTOMER.email} "/>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input class="form-control" type="text" name="phone" path="phone" value="${CUSTOMER.phone} "/>
                                    </div>
                                    <div class="form-group">
                                        <label for="passNumber">Pass Number</label>
                                        <input class="form-control" type="text" name="passNumber" path="passNumber"  value="${CUSTOMER.passNumber} "/>
                                    </div>
                                    <div class="form-group">
                                        <label for="countNumber">Count Number</label>
                                        <input class="form-control" type="text" name="countNumber" path="countNumber" value="${CUSTOMER.countNumber} " />
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" class="form-control" type="text" name="location" path="location" value="${CUSTOMER.location} " />
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" class="form-control" type="text" name="customerId" path="customerId" value="${CUSTOMER.customerId} " />
                                    </div>
                                    <h2>Customer address</h2>
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label for="addressLine">Address Line</label>
                                            <input class="form-control" type="text" name="addressLine" path="addressLine" value="${ADDRESS.addressLine} " />
                                        </div>
                                        <div class="form-group">
                                            <label for="city">City</label>
                                            <input class="form-control" type="text" name="city" path="city" value="${ADDRESS.city} " />
                                        </div>
                                        <div class="form-group">
                                            <label for="country">Country</label>
                                            <input class="form-control" type="text" name="country" path="country"  value="${ADDRESS.country} "/>
                                        </div>
                                        <div class="form-group">
                                            <label for="postalCode">Postal Code</label>
                                            <input class="form-control" type="text" name="postalCode" path="postalCode" value="${ADDRESS.postalCode} " />
                                        </div>
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
