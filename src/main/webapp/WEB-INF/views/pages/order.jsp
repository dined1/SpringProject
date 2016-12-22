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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Payment list</b></h5>
                    </div>
                    <div class="panel-body">

                        <!--div class="container">
                            <ul class="nav nav-pills">
                                <li><a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}">Корзина<span id="total-cart-count" class="badge"></span></a></li>
                                <li><a href="${contextPath}/application/catalog/${CUSTOMERID}/${SOID}">Каталог</a></li>
                                <li class="active"><a href="${contextPath}/application/order/${CUSTOMERID}/${SOID}">Оформление заказа</a></li>
                            </ul>
                            <br />
                            <br />
                            <div id="order-message" class="alert alert-info">
                                <label>One-time: <span id="total-cart-summa">${(SO_FINAL.finalOTPwithTaxAndDiscount)}</span> BYN</label><br>
                                <label>Mounth price: <span>${(SO_FINAL.finalMPwithTaxAndDiscount)}</span>  BYN</label>
                            </div>
                            <br />
                            <form id="order-form" class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label for="input-name" class="col-sm-2 control-label">Ваше имя *</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" id="input-name" name="name" placeholder="Ваше имя">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="input-email" class="col-sm-2 control-label">Email *</label>
                                    <div class="col-sm-6">
                                        <input type="email" class="form-control" id="input-email" name="email" placeholder="Email">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="input-phone" class="col-sm-2 control-label">Телефон</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" id="input-phone" name="phone" placeholder="Телефон">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Способ доставки</label>
                                    <div class="col-sm-6">
                                        <input type="hidden" name="delivery_type" id="delivery-type" value="" />
                                        <input type="hidden" name="delivery_summa" id="delivery-summa" value="0" />
                                        <input type="hidden" name="full_summa" id="full-summa" value="0" />
                                        <div class="radio">
                                            <label><input type="radio" name="delivery" class="js-delivery-type" data-type="Самовывоз" data-summa="0" checked>Самовывоз (бесплатно)</label>
                                        </div>
                                        <div class="radio">
                                            <label><input type="radio" name="delivery" class="js-delivery-type" data-type="В пределах КАД" data-summa="20">В пределах МКАД (20 рублей)</label>
                                        </div>
                                        <div class="radio">
                                            <label><input type="radio" name="delivery" class="js-delivery-type" data-type="Белпочта" data-summa="30">Доставка почтой Беларуси (30 рублей)</label>
                                        </div>
                                        <br />
                                        <div id="alert-delivery" class="alert alert-info"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="input-address" class="col-sm-2 control-label">Адрес доставки</label>
                                    <div class="col-sm-6">
                                        <textarea class="form-control" id="input-address" name="address" placeholder="Адрес доставки" row="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="input-message" class="col-sm-2 control-label">Сообщение</label>
                                    <div class="col-sm-6">
                                        <textarea class="form-control" id="input-message" name="message" placeholder="Дополнительная информация" row="3"></textarea>
                                        <br />
                                        <div id="alert-validation" class="alert alert-danger hidden">
                                            <button type="button" class="close js-close-alert">&times;</button>
                                            <strong>Ошибка!</strong> Заполните обязательные поля, отмеченные *
                                        </div>
                                        <div id="alert-order-done" class="alert alert-success hidden">
                                            <button type="button" class="close js-close-alert">&times;</button>
                                            <strong>Спасибо за заказ!</strong> Скоро мы с Вами свяжемся
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-6">
                                        <button id="order-btn" type="submit" class="btn btn-primary">Отправить заказ</button>
                                    </div>
                                </div>
                            </form>
                        </div-->




                        <a href="${contextPath}/cabinet/apply/${SO_FINAL.SOId}" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Отправить</a>
                        <a href="${contextPath}/application/orderinfo" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Назад</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
