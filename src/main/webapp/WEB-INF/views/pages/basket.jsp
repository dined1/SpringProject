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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Basket </b></h5>
                    </div>
                    <div class="panel-body">

                        <div class="container">

                            <ul class="nav nav-pills">
                                <li class="active"><a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li><a href="${contextPath}/application/catalog/${CUSTOMERID}/${SOID}">Каталог</a></li>
                                <li><a href="${contextPath}/application/order/${CUSTOMERID}/${SOID}">Оформление заказа</a></li>
                            </ul>
                        </div>
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
                                        <td><a href="${contextPath}/application/itembasket/${PRODUCTITEMS.ordItem.orditemId}/${CUSTOMERID}/${SOID}">${(PRODUCTITEMS.ordItem.name)}</a></td>

                                        <td>${(PRODUCTITEMS.otp)}</td>

                                        <td>${(PRODUCTITEMS.mp)}</td>

                                        <td><a href="${contextPath}/application/remove/${PRODUCTITEMS.ordItem.orditemId}/${CUSTOMERID}/${SOID}">Убрать товар</a></td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div>Result:
                            <label>One-time: <span id="total-cart-summa">${(OTP.toString())}</span> BYN</label><br>
                            <label>Mounth price: <span>${(CMP.toString())}</span>  BYN</label>
                        </div>
                        <br />
                        <a class="btn btn-info" href="${contextPath}/application/order/${ID}">Оформить заказ</a>
                        <a href="${contextPath}/application/orderinfo" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Назад</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
