<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/i18n/defaults-*.min.js"></script>
<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div  id="page-wrapper" style="min-height: 476px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Basket </b></h5>
                    </div>
                    <div class="panel-body">

                        <div class="container">
                            <ul class="nav nav-pills">
                                <c:if test="${STATUS != 'Canceled'}">
                                    <li class="active"><a href="${contextPath}/adm/orderentry/basket/${CUSTOMERID}/${SOID}">Card<span id="total-cart-count" class="badge"></span></a></li>
                                    <li><a href="${contextPath}/adm/orderentry/catalog/${CUSTOMERID}/${SOID}">Catalog</a></li>
                                    <li><a href="${contextPath}/adm/orderentry/order/${CUSTOMERID}/${SOID}">Checkout</a></li>
                                </c:if>
                            </ul>
                        </div>
                        <br />
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="PRODUCTITEMS_TABLE">
                                <thead>
                                <tr>
                                    <th>Item name</th>
                                    <th>One-time price</th>
                                    <th>Recurrent price</th>
                                    <c:if test="${STATUS == 'Wait'}">
                                        <th></th>
                                    </c:if>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${PRODUCTITEMS_LIST}" var="PRODUCTITEMS">
                                        <tr>
                                            <td><a href="${contextPath}/adm/orderentry/itembasket/${PRODUCTITEMS.ordItem.orditemId}/${CUSTOMERID}/${SOID}">${(PRODUCTITEMS.ordItem.name)}</a></td>

                                            <td>${(PRODUCTITEMS.otp)}</td>

                                            <td>${(PRODUCTITEMS.mp)}</td>

                                            <c:if test="${STATUS == 'Wait'}">
                                                <c:if test="${PRODUCTITEMS.ordItem.status == 'Wait'}">
                                                    <td><a href="${contextPath}/adm/orderentry/remove/${PRODUCTITEMS.ordItem.orditemId}/${CUSTOMERID}/${SOID}">Delete</a></td>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${PRODUCTITEMS.ordItem.status == 'Ordered'}">
                                                <td><a class="btn btn-default" href="${contextPath}/adm/orderentry/disconnect/${PRODUCTITEMS.ordItem.orditemId}/${CUSTOMERID}/${SOID}">Disconnect</a></td>
                                                <td><a class="btn btn-default" onclick="popup(<c:set var="item" value="${PRODUCTITEMS.ordItem.orditemId}"/> popup())">Change Ownership</a></td>
                                                <td><a class="btn btn-default" onclick="relocatePopup(<c:set var="item" value="${PRODUCTITEMS.ordItem.orditemId}"/> popup())">Relocate</a></td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <c:if test="${STATUS != 'Canceled'}">
                            <div>Result:
                                <label>One-time price: <span id="total-cart-summa">${(OTP.toString())}</span> USD</label><br>
                                <label>Recurrent price: <span>${(CMP.toString())}</span>  USD</label><br>
                                <label>Final One-time price with taxes and discounts: <span id="total-cart-summa">${(FOTP.toString())}</span> USD</label><br>
                                <label>Final Recurrent price with taxes and discounts: <span>${(FCMP.toString())}</span>  USD</label><br>

                                <label>Final One-time price for all order: <span id="total-cart-summa">${(SO.finalOTPwithTaxAndDiscount)}</span> USD</label><br>
                            </div>
                        </c:if>
                        <%--<c:if test="${STATUS == 'Canceled'}">--%>
                        <%--<div>Result:--%>
                        <%--<label>One-time price: <span id="total-cart-summa">${(Pr.toString())}</span> BYN</label><br>--%>
                        <%--<label>Recurrent price: <span>${(CMP.toString())}</span>  BYN</label><br>--%>
                        <%--<label>Final One-time price with taxes and discounts: <span id="total-cart-summa">${(FOTP.toString())}</span> BYN</label><br>--%>
                        <%--<label>Final Recurrent price with taxes and discounts: <span>${(FCMP.toString())}</span>  BYN</label>--%>
                        <%--</div>--%>
                        <%--</c:if>--%>
                        <br />
                        <c:if test="${STATUS == 'Wait' and STATUS != 'Canceled'}">
                            <a class="btn btn-info" href="${contextPath}/adm/orderentry/order/${CUSTOMERID}/${SOID}">Checkout</a>
                        </c:if>
                        <c:if test="${CMP != 0 and FCMP !=0 and STATUS == 'Ordered' and STATUS != 'Canceled'}">
                            <a class="btn btn-info" href="${contextPath}/adm/orderentry/cancel/${CUSTOMERID}/${SOID}/">Cancel order</a>
                        </c:if>
                        <a href="${contextPath}/adm/orderentry/orderinfo" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                        <!--a href="${contextPath}/application/print" class="btn btn-default btn-sm" onclick="javascript:window.print()">
                            <i class="fa fa-print fa-fw"></i> Print
                        </a-->
                        <a href="${contextPath}/adm/orderentry/print/${CUSTOMERID}/${SOID}" class="btn btn-default btn-sm">
                            <i class="fa fa-print fa-fw"></i> Print
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="changeOS" class="popover">
    <div class="modal-content">
        <form id="dynForm" role="form" action="${contextPath}/adm/orderentry/changeownership/${item}/${CUSTOMERID}/${SOID}" method="POST">
            <c:if test="${empty ALLCUSTOMERLIST}">
                <h4>Please, create customer</h4><Br/>
            </c:if>
            <c:if test="${!empty ALLCUSTOMERLIST}">
                <div class="form-group">
                    <label>Customer: </label>
                    <select class="selectpicker" path="targetcustomer" data-live-search="true" name="targetcustomer" onchange=" ">
                        <c:forEach items="${ALLCUSTOMERLIST}" var="CUSTOMER">
                            <option value="${CUSTOMER.customerId}">${CUSTOMER.firstName}, ${CUSTOMER.lastName}</option>
                        </c:forEach>
                    </select>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
            </c:if>
            <a href="${contextPath}/adm/orderentry/${CUSTOMER.customerId}" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
        </form>
    </div>
</div>


<script>
    $(document).ready(function(){
        $('#PRODUCTITEMS_TABLE').dataTable();
    });
</script>
<script>
    var subm = document.getElementById('subm');

    subm.onclick = function() {
        document.getElementById("dynForm").submit();
        location.reload();
        changeOS.style.display = "none";
    };

    var changeOS = document.getElementById('changeOS');

    function popup() {
        position = $(this).position;
        changeOS.css('top', position.top+17);
        changeOS.style.display = "block";
    }

    var relocate = document.getElementById('relocate');

    function relocatePopup() {
        position = $(this).position;
        changeOS.css('top', position.top+17);
        changeOS.style.display = "block";
    }

</script>
<script>
    $(document).ready(function () {
        $('.selectpicker').selectpicker({
            style: 'btn-info',
            size: 4
        });
    });
</script>
<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
