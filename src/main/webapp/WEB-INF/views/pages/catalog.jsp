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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Create a new Itemdiscount </b></h5>
                    </div>
                    <div class="panel-body">

                        <div class="container">
                            <ul class="nav nav-pills">
                                <li><a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li class="active"><a href="${contextPath}/application/catalog/${CUSTOMERID}/${SOID}">Каталог</a></li>
                                <li><a href="${contextPath}/application/order/${ID}">Оформление заказа</a></li>
                            </ul>
                            <br />
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Def MP</th>
                                <th>Def OTP</th>
                                <th>Modified Date</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${ITEM_LIST}" var="ITEM">
                                <tr>
                                <td><a href="${contextPath}/application/itemdescription/${ITEM.itemId}/${CUSTOMERID}/${SOID}">${(ITEM.name)}</a></td>

                                <td>${(ITEM.type)}</td>

                                <td>${(ITEM.description)}</td>

                                <td>${(ITEM.defMP)}</td>

                                <td>${(ITEM.defOTP)}</td>

                                <td>${(ITEM.modifiedDate)}</td>

                                <td>
                                    <a href="${contextPath}/application/add/${ITEM.itemId}/${CUSTOMERID}/${SOID}"><i class="fa fa-level-up fa-fw"></i>  Добавить</a>
                                </td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <script src="js/vendor/jquery.min.js" type="text/javascript"></script>
                        <script src="js/vendor/underscore.min.js" type="text/javascript"></script>
                        <script src="js/modules/catalog.js" type="text/javascript"></script>
                        <script src="js/modules/cart.js" type="text/javascript"></script>
                        <script src="js/modules/main.js" type="text/javascript"></script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
