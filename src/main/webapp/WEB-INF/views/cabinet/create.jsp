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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Create a new Customer </b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/cabinet/new" method="POST">
                                    <h2>Customer information</h2>
                                    <div class="form-group">
                                        <label for="customerId">Customer Id</label>
                                        <input class="form-control" type="number" name="customerId" path="customerId"  required="required" autofocus="autofocus"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="firstName">First Name</label>
                                        <input class="form-control" type="text" name="firstName" path="firstName"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName">Last Name</label>
                                        <input class="form-control" type="text" name="lastName" path="lastName"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="contact">Contact</label>
                                        <input class="form-control" type="text" name="contact" path="contact"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input class="form-control" type="text" name="email" path="email"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input class="form-control" type="text" name="phone" path="phone"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Pass Number</label>
                                        <input class="form-control" type="text" name="PassNumber" path="PassNumber"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Count Number</label>
                                        <input class="form-control" type="text" name="CountNumber" path="CountNumber"  />
                                    </div>
                                    <h2>Customer address</h2>
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label for="addressLine">Address Line</label>
                                            <input class="form-control" type="text" name="addressLine" path="addressLine"  />
                                        </div>
                                        <div class="form-group">
                                            <label for="city">City</label>
                                            <input class="form-control" type="text" name="city" path="city"  />
                                        </div>
                                        <div class="form-group">
                                            <label for="country">Country</label>
                                            <input class="form-control" type="text" name="country" path="country"  />
                                        </div>
                                        <div class="form-group">
                                            <label for="postalCode">Postal Code</label>
                                            <input class="form-control" type="text" name="postalCode" path="postalCode"  />
                                        </div>
                                        <div class="form-group">
                                            <label for="modifiedDate">Modified Date</label>
                                            <input class="form-control" type="text" name="modifiedDate" path="modifiedDate"  />
                                        </div>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
                                    <a href="${contextPath}/admin/customer/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
