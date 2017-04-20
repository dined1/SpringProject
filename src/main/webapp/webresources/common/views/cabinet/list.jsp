<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="center-panel-grid">
        <div class="center-block">
            <div class="center-block">
                <div class="panel panel-default">

                    <!-- /.panel-heading -->
                    <div>
                        <!--div class="dataTable_wrapper">
                            <table class="table table-striped table-bordered table-hover" id="CUSTOMER_TABLE">
                                <thead>
                                    <tr>
                                        <th>Customer Id</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Contact</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${CUSTOMER_LIST}" var="CUSTOMER">
                                    <tr>
                                        <td>${(CUSTOMER.customerId)}</td>

                                        <td>${(CUSTOMER.firstName)}</td>

                                        <td>${(CUSTOMER.lastName)}</td>

                                        <td>${(CUSTOMER.contact)}</td>

                                        <td>${(CUSTOMER.email)}</td>

                                        <td>${(CUSTOMER.phone)}</td>

                                        <td>${(CUSTOMER.address1.addressLine)}</td>

                                        <td><a href="${contextPath}/cabinet/update/${CUSTOMER.customerId}"><i class="fa fa-edit fa-fw"></i>  Edit</a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="dataTable_wrapper">
                            <table class="table table-striped table-bordered table-hover" id="SO_TABLE">
                                <thead>
                                <tr>
                                    <th>SOId</th>
                                    <th>Date Created</th>
                                    <th>Order Date</th>
                                    <th>Status</th>
                                    <th>SONumber</th>
                                    <th>Purchase Order Number</th>
                                    <th>Date Modified</th>
                                    <th>Customer</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${SO_LIST}" var="SO">
                                    <tr>
                                        <td>${(SO.SOId)}</td>

                                        <td>${(SO.dateCreated)}</td>

                                        <td>${(SO.orderDate)}</td>

                                        <td>${(SO.status)}</td>

                                        <td>${(SO.SONumber)}</td>

                                        <td>${(SO.purchaseOrderNumber)}</td>

                                        <td>${(SO.dateModified)}</td>

                                        <td>${(SO.customer1.lastName)}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div-->

                        <!--p>
                        <c:if test="${empty requestScope.CUSTOMER_LIST}">
                            <div class="alert alert-info">
                                <div align="center">No Customer found</div>
                            </div>
                        </c:if>
                        <p-->

                        <div style="margin-bottom: 15px;">
                            <div class="col-lg-3 col-md-6">
                                <div class="panel panel-primary">
                                    <a href="${contextPath}/application/orderinfo">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <i class="fa fa-list-alt fa-5x"></i>
                                                </div>
                                                <div class="col-xs-9 text-right entity">
                                                    <div class="title"><font size="5">Orders</font></div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-6">
                                <div class="panel panel-primary">
                                    <a href="${contextPath}/cabinet/customerinfo">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <i class="fa fa-list-alt fa-5x"></i>
                                                </div>
                                                <div class="col-xs-9 text-right entity">
                                                    <div class="title"><font size="5">Customers</font></div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-6">
                                <div class="panel panel-primary">
                                    <a href="${contextPath}/cabinet/payments">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <i class="fa fa-list-alt fa-5x"></i>
                                                </div>
                                                <div class="col-xs-9 text-right entity">
                                                    <div class="title"><font size="5">Payments</font></div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-6">
                                <div style="height: 73px" class="panel panel-primary">
                                    <a href="${contextPath}/cabinet/password">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <font size="6"><i class="fa fa-arrow-circle-right"></i></font>
                                                </div>
                                                <div class="col-xs-9 text-right entity">
                                                    <div class="title"><font size="5">Change password</font></div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>


                        <p style="margin-left: 15px; margin-bottom: 15px;"><a href="${contextPath}/welcome" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a></p>

                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#CUSTOMER_TABLE').DataTable({
            responsive: true
        });
    });
</script>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
