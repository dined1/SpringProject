
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

    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/creditcard.js"></script>
    <script type="text/javascript" src="${contextPath}/webresources/static/need/js/cc.js"></script>

</head>
<body>
<form action="#" id="cc-form" novalidate>
    <div class="error hidden"></div>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-5 center-block">
            <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table" >
                    <div class="row display-tr" >
                        <h3 class="panel-title display-td" >Payment Details</h3>

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
                                    <label for="cardNumber">Bill Number</label>
                                    <div class="input-group">
                                        <input  type="tel"  pattern="[0-9]*"  name="cardNumber" id="cardNumber" placeholder="Valid Bill Number" class="form-control" required autofocus  />

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                        <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <label for="cvv2">Bank Code</label>
                                    <input placeholder="Bank Code" pattern="[0-9]*" type="tel" name="cvv2" id="cvv2" maxlength="3" class="form-control" required>
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
    </form>
</body>
</html>
