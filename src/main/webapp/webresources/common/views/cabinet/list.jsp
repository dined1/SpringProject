<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper" style="min-height: 476px;">
        <div class="center-block">
            <div class="center-block">
                <div class="panel panel-default">
                    <div>
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

                            <%--<div class="col-lg-3 col-md-6">--%>
                                <%--<div style="height: 73px" class="panel panel-primary">--%>
                                    <%--<a href="${contextPath}/cabinet/password">--%>
                                        <%--<div class="panel-heading">--%>
                                            <%--<div class="row">--%>
                                                <%--<div class="col-xs-3">--%>
                                                    <%--<font size="6"><i class="fa fa-arrow-circle-right"></i></font>--%>
                                                <%--</div>--%>
                                                <%--<div class="col-xs-9 text-right entity">--%>
                                                    <%--<div class="title"><font size="5">Change password</font></div>--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                            <%--</div>--%>
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
