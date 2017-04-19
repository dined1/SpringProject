<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%--<%@ include file="/webresources/common/navigationbar.jspf"%>--%>
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <!-- /.navbar-header -->

        <ul class="nav navbar-top-links navbar-right">
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-alerts">
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-comment fa-fw"></i> New Comment
                                <span class="pull-right text-muted small">4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <%--<li class="divider"></li>--%>
                </ul>
                <!-- /.dropdown-alerts -->
            </li>
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li class="divider"></li>
                    <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                </ul>
                <!-- /.dropdown-user -->
            </li>
            <!-- /.dropdown -->
        </ul>
        <!-- /.navbar-top-links -->

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav in" id="side-menu">
                    <li class="sidebar-search">
                        <div class="input-group custom-search-form">
                            <input type="text" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                        <!-- /input-group -->
                    </li>
                    <li>
                        <a href="index.html" class="active"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="${contextPath}/adm/orderentry/${CUSTOMER.customerId}">Order entry</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/item/list">Offering catalog</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/discountrule/list">Offering discounts catalog</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/group/list">Offering groups</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/locations/list">Offering locations</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/characteristics/list">Offering characteristics</a>
                    </li>
                    <li>
                        <a href="${contextPath}/superadmin/customer/list">Customer information</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-sitemap fa-fw"></i> Multi-Level Dropdown<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li>
                                <a href="#">Second Level Item</a>
                            </li>
                            <li>
                                <a href="#">Second Level Item</a>
                            </li>
                            <li>
                                <a href="#">Third Level <span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level collapse">
                                    <li>
                                        <a href="#">Third Level Item</a>
                                    </li>
                                    <li>
                                        <a href="#">Third Level Item</a>
                                    </li>
                                    <li>
                                        <a href="#">Third Level Item</a>
                                    </li>
                                    <li>
                                        <a href="#">Third Level Item</a>
                                    </li>
                                </ul>
                                <!-- /.nav-third-level -->
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-files-o fa-fw"></i> Sample Pages<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li>
                                <a href="blank.html">Blank Page</a>
                            </li>
                            <li>
                                <a href="login.html">Login Page</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>
    <div id="page-wrapper" style="min-height: 476px;">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">${CUSTOMER.firstName} ${CUSTOMER.lastName}</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>



        <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'], '/orderentry')}">
            <%@ include file="/webresources/common/orderentry.jsp"%>
        </c:if>
        <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'], '/catalog')}">
            <%@ include file="/webresources/common/orderentry.jsp"%>
        </c:if>
        <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'], '/discounts')}">
            <%@ include file="/webresources/common/orderentry.jsp"%>
        </c:if>
        <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'], '/locations')}">
            <%@ include file="/webresources/common/orderentry.jsp"%>
        </c:if>
        <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'], '/characteristics')}">
            <%@ include file="/webresources/common/orderentry.jsp"%>
        </c:if>

        <%--<div>--%>
            <%--<div class="row">--%>
                <%--<div class="col-lg-12">--%>
                    <%--<div class="panel panel-default">--%>
                        <%--<br>--%>
                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Item</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/admin/item/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Discountrule</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/admin/discountrule/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Group</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/admin/group/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Locations</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/admin/locations/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Characteristics</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/admin/characteristics/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Customer</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/superadmin/customer/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">Role</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/superadmin/role/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="col-lg-3 col-md-6">--%>
                            <%--<div class="panel panel-primary">--%>
                                <%--<div class="panel-heading">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-xs-3">--%>
                                            <%--<i class="fa fa-list-alt fa-5x"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-9 text-right entity">--%>
                                            <%--<div class="title">So</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a href="${contextPath}/superadmin/so/list">--%>
                                    <%--<div class="panel-footer">--%>
                                        <%--<span class="pull-left">View Details</span>--%>
                                        <%--<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>--%>
                                        <%--<div class="clearfix"></div>--%>
                                    <%--</div>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<a style="margin-left: 15px; margin-bottom: 15px;" href="${contextPath}/" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>





    </div>

</div>
<script>
    $(document).ready(function () {
        $('#ITEMDISCOUNT_TABLE').DataTable({
            responsive: true
        });
    });
</script>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
