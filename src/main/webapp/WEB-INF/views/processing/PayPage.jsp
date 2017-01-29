
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pretty Credit Card Checkout</title>
    <link rel="stylesheet" href="${contextPath}/webresources/static/need/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${contextPath}/webresources/static/need/css/font-awesome.min.css">
    <link rel="stylesheet" href="${contextPath}/webresources/static/need/css/checkout.css">
    <link rel="stylesheet" href="${contextPath}/webresources/static/need/css/inconsolata.css">
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/jquery.payment.min.js"></script>
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/checkout.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-5 center-block">
            <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table" >
                    <div class="row display-tr" >
                        <h3 class="panel-title display-td" >Payment Details</h3>
                        <div class="display-td" >
                            <img class="img-responsive" src="${contextPath}/webresources/static/need/img/visa-curved-32px.png">
                        </div>
                        <div class="display-td" >
                            <img class="img-responsive" src="${contextPath}/webresources/static/need/img/mastercard-curved-32px.png">
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <form role="form" id="payment-form" method="POST" action="${contextPath}/cabinet/apply/${SOID}"  >
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label for="cardNumber">Subscription Value</label>
                                    <input type="hidden" name="OrderReference" value="123" />
                                    <p class="subscription-value" > ${PAYMENTSUM} <span class="subscription-recurrency"></span></p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label for="cardNumber">Card Holder</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" path="cardholder" name="cardHolder" id="cardHolder" placeholder="exactly as on the card" autocomplete="cc-name" required="required" autofocus="autofocus" />
                                        <span class="input-group-addon">&nbsp;<i class="fa fa-user"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label for="cardNumber">Card Number</label>
                                    <div class="input-group">
                                        <input type="tel" class="form-control" path="cardnumber" name="cardNumber" id="cardNumber" placeholder="Valid Card Number" autocomplete="cc-number" required="required"  />
                                        <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <label for="cardExpiry">Expiration Date</label>
                                    <input type="tel" class="form-control" name="cardExpiry" path="expiration_date" id="cardExpiry" placeholder="MM / YYYY" autocomplete="cc-exp" required="required" />
                                </div>
                            </div>
                            <div class="col-xs-5 col-md-5 pull-right">
                                <div class="form-group">
                                    <label for="cardCVC">Val Code</label>
                                    <input type="tel" class="form-control" name="cardCVC" path="cvc" id="cardCVC" placeholder="CVC" autocomplete="cc-csc" required="required" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-5 col-md-5 center-block">
                            <div class="credit-card-box-mini">
                                <div class="flip-mini">
                                    <div class="front-mini">
                                        <div class="chip-mini"></div>
                                        <div class="logo-mini">
                                            <img src="${contextPath}/webresources/static/need/img/visa-curved-32px.png" class='cc-flag'>
                                            <img src="${contextPath}/webresources/static/need/img/mastercard-curved-32px.png" class='cc-flag'>
                                        </div>
                                        <div class="number-mini" id="cc-number"></div>
                                        <div class="card-holder-mini">
                                            <label>Card holder</label>
                                            <div id="cc-holder"></div>
                                        </div>
                                        <div class="card-expiration-date-mini">
                                            <label>Expires</label>
                                            <div id="cc-expires"></div>
                                        </div>
                                    </div>
                                    <div class="back-mini">
                                        <div class="strip-mini"></div>
                                        <div class="logo-mini">
                                            <img src="${contextPath}/webresources/static/need/img/visa-curved-32px.png" class='cc-flag'>
                                            <img src="${contextPath}/webresources/static/need/img/mastercard-curved-32px.png" class='cc-flag'>
                                        </div>
                                        <div class="ccv-mini">
                                            <label>CCV</label>
                                            <div id="cc-ccv"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <a href="${contextPath}/cabinet/apply/${SOID}" class="subscribe btn btn-success btn-lg btn-block" type="button">Pay</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
