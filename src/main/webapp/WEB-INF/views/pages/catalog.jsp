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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Item catalog </b></h5>
                    </div>
                    <div class="panel-body">

                        <div class="container">
                            <ul class="nav nav-pills">
                                <li><a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li class="active"><a href="${contextPath}/application/catalog/${CUSTOMERID}/${SOID}">Каталог</a></li>
                                <li><a href="${contextPath}/application/order/${CUSTOMERID}/${SOID}">Оформление заказа</a></li>
                            </ul>
                            <br />
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Product type</th>
                                <th>Description</th>
                                <th>Default One-time price, BYN</th>
                                <th>Default Mounth price, BYN</th>
                                <th>Modified Date</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${ITEM_LIST}" var="ITEM">
                                <tr>
                                    <td><a href="${contextPath}/application/itemdescription/${ITEM.item.itemId}/${CUSTOMERID}/${SOID}">${(ITEM.item.name)}</a></td>

                                    <td class="bg-info">${(ITEM.item.type)}</td>

                                    <td>${(ITEM.item.description)}</td>

                                    <td>${(ITEM.item.defOTP)}</td>

                                    <td>${(ITEM.item.defMP)}</td>

                                    <td>${(ITEM.item.modifiedDate)}</td>

                                    <td>
                                        <a href="${contextPath}/application/add/${ITEM.item.itemId}/${CUSTOMERID}/${SOID}"><i class="fa fa-level-up fa-fw"></i>  Добавить</a>
                                    </td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <script src="${contextPath}/webresources/common/js/vendor/jquery.min.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/vendor/underscore.min.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/catalog.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/cart.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/main.js" type="text/javascript"></script>
                    </div>

                    <a href="${contextPath}/application/orderinfo" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Назад</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
