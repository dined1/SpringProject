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

                            <br />
                            <br />
                            <br />
                            <ul class="nav nav-pills">
                                <li class="active"><a href="${contextPath}/application/basket/${ID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li><a href="${contextPath}/application/catalog">Каталог</a></li>
                                <li><a href="${contextPath}/application/order/${ID}">Оформление заказа</a></li>
                            </ul>
                            <br />
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="PRODUCTITEMS_TABLE">
                                    <thead>
                                    <tr>
                                        <th>Наименование</th>
                                        <th>Единоразовая оплата</th>
                                        <th>Ежемесячная оплата</th>
                                        <th>Удаление</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${PRODUCTITEMS_LIST}" var="PRODUCTITEMS">
                                        <tr>
                                            <td>${(PRODUCTITEMS.item1.name)}</td>

                                            <td>${(PRODUCTITEMS.mp)}</td>

                                            <td>${(PRODUCTITEMS.otp)}</td>

                                            <td><a href="${contextPath}/application/remove/${PRODUCTITEMS.id}">Убрать товар</a></td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div>Итого оплатить: <span id="total-cart-summa">${(OTP.toString())}</span> руб.    Итого за месяц: ${(CMP.toString())}</div>
                            <br />
                            <a class="btn btn-info" href="order.html">Оформить заказ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
