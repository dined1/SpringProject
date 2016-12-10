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
                                <li class="active"><a href="../basket/${ID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li><a href="../catalog/${ID}">Каталог</a></li>
                                <li><a href="../order/${ID}">Оформление заказа</a></li>
                            </ul>
                            <br />
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="PRODUCTITEMS_TABLE">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Item</th>
                                        <th>SOProduct</th>
                                        <th>Удаление</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${PRODUCTITEMS_LIST}" var="PRODUCTITEMS">
                                        <c:if test="${PRODUCTITEMS.soproduct1.so1.SOId == ID}">
                                            <tr>
                                                <td>${(PRODUCTITEMS.id)}</td>

                                                <td>${(PRODUCTITEMS.item1.name)}</td>

                                                <td>${(PRODUCTITEMS.soproduct1.mp)}</td>

                                                <td><a href="../remove/${PRODUCTITEMS.id}">Убрать товар</a></td>

                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div>Итого: <span id="total-cart-summa">65000</span> руб.</div>
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
