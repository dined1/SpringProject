
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
<div id="wrapper">

    <div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-default fa-fw"></i> <b> Payment Details</b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/cabinet/apply/${SOID}" >
                                    <h4>Subscription Value</h4>
                                    <div class="form-group">
                                        <p class="subscription-value" > ${PAYMENTSUM} USD. <span class="subscription-recurrency"></span></p>
                                    </div>


                                    <div class="form-group">
                                        <label for="billNumber">Bill Number</label>
                                        <input class="form-control" type="billNumber" pattern = "[0-9]{16}" placeholder="Valid Bill Number" title="incorrect bill number: length 16 digit" name="billNumber"  required="required" />
                                    </div>

                                    <div class="form-group">
                                        <label for="bankCode">Bank Code</label>
                                        <input class="form-control" type="text"  pattern = "[0-9]{3}" placeholder="Valid Bank Code" title="incorrect bank code: length 3 digit" name="bankCode"  required="required" />
                                    </div>



                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button href="${contextPath}/cabinet/apply/${SOID}" type="submit" class="btn btn-success btn-lg btn-block">Pay</button>
                                    <a href="${contextPath}/application/orderinfo" class="btn btn-success btn-lg btn-block"></i>Cancel</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
