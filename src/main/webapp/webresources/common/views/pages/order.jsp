<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div id="wrapper">
    <%--<%@ include file="/webresources/common/navigationbar.jspf"%>--%>
    <div id="page-wrapper" style="min-height: 476px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Payment list</b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="container">
                            <ul class="nav nav-pills">
                                <li><a href="${contextPath}/adm/orderentry/basket/${CUSTOMERID}/${SOID}">Card<span id="total-cart-count" class="badge"></span></a></li>
                                <li><a href="${contextPath}/adm/orderentry/catalog/${CUSTOMERID}/${SOID}">Catalog</a></li>
                                <li class="active"><a href="${contextPath}/adm/orderentry/order/${CUSTOMERID}/${SOID}">Checkout</a></li>
                            </ul>
                            <br />
                        </div>
                        <br />
                        <br/>
                        <form action="${contextPath}/application/PayPage" method="GET">
                            <c:if test="${SO_FINAL.status != 'Canceled'}">
                                <div>Result:
                                    <label>Final One-time price with taxes and discounts: <span id="total-cart-summa">${(FOTP.toString())}</span> USD</label><br>
                                    <label>Final Recurrent price with taxes and discounts: <span>${(FCMP.toString())}</span>  USD</label>
                                </div>
                                <input type="hidden" name="SOID" value="${SO_FINAL.SOId}">
                                <c:if test="${FOTP.toString() != '0.00'}">
                                    <input type="hidden" name="paymentsum" value="${FOTP}">
                                    <label>Summary pay: ${FOTP.toString()}</label>
                                    <br>
                                    <input type="submit" class="btn btn-default" value="Pay Card">
                                </c:if>
                                <c:if test="${FOTP.toString() == '0.00' and FCMP.toString() != '0.00' and SO_FINAL.attentionFlag != '' and SO_FINAL.attentionFlag != null}">
                                    <input type="hidden" name="paymentsum" value="${FCMP}">
                                    <label>Summary pay: ${FCMP.toString()}</label>
                                    <br>
                                    <input type="submit" class="btn btn-default" value="Pay Card">
                                </c:if>
                            </c:if>
                              </form>

                                    <br />

                                <form action="${contextPath}/application/PayNumb" method="GET">
                                    <c:if test="${SO_FINAL.status != 'Canceled'}">

                                    <input type="hidden" name="SOID" value="${SO_FINAL.SOId}">
                                    <c:if test="${FOTP.toString() != '0.00'}">
                                    <input type="hidden" name="paymentsum" value="${FOTP}">

                                    <br>

                                    <input type="submit"  class="btn btn-default" value="Pay Bill Number">
                                    </c:if>
                                    <c:if test="${FOTP.toString() == '0.00' and FCMP.toString() != '0.00' and SO_FINAL.attentionFlag != '' and SO_FINAL.attentionFlag != null}">
                                    <input type="hidden" name="paymentsum" value="${FCMP}">

                                    <br>

                                    <input type="submit"  class="btn btn-default" value="Pay Bill Number">


                                    </c:if>
                                    </c:if>

                        </form>

                        <a href="${contextPath}/adm/orderentry/${CUSTOMERID}" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>


                    <%--<form action="${contextPath}/application/stripe/${SOID}" method="POST">--%>
                        <%--<script th:inline="javascript"--%>
                        <%--src="https://checkout.stripe.com/checkout.js" class="stripe-button"--%>
                        <%--data-key="pk_test_6pRNASCoBOKtIshFeQd4XMUh"--%>
                        <%--data-currency="BYN"--%>
                        <%--data-amount="${SO_FINAL.finalOTPwithTaxAndDiscount}"--%>
                        <%--data-name="Stripe Checkout Demo"--%>
                        <%--data-description="Demo"--%>
                        <%--data-locale="auto"--%>
                        <%--data-bitcoin="true"--%>
                        <%--data-alipay="true">--%>

                        <%--</script>--%>
                        <%--</form>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
