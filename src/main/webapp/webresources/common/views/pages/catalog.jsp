<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper" style="min-height: 476px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Item catalog </b></h5>
                    </div>
                    <div class="panel-body">

                        <div class="container">
                            <ul class="nav nav-pills">
                                <li><a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}">Card<span id="total-cart-count" class="badge"></span></a></li>
                                <li class="active"><a href="${contextPath}/application/catalog/${CUSTOMERID}/${SOID}">Catalog</a></li>
                                <li><a href="${contextPath}/application/order/${CUSTOMERID}/${SOID}">Checkout</a></li>
                            </ul>
                            <br />
                        </div>

                        <div class="rTable">
                            <div class="rTableHeading">
                                <div class="rTableRow">
                                    <div class="rTableHead">
                                        Name
                                    </div>
                                    <div class="rTableHead">
                                        Product type
                                    </div>
                                    <div class="rTableHead">
                                        Description
                                    </div>
                                    <div class="rTableHead">
                                        Default One-time price, USD
                                    </div>
                                    <div class="rTableHead">
                                        Default Mounth price, USD
                                    </div>
                                    <div class="rTableHead">
                                        Modified Date
                                    </div>
                                    <div class="rTableHead">
                                        Available amount
                                    </div>
                                    <div class="rTableHead">
                                         
                                    </div>
                                </div>
                            </div>
                            <div class="rTableBody">
                                <div class="rTableRow">
                                    <div class="rTableCell">
                                        <a href="${contextPath}/application/itemdescription/${ITEM.item.itemId}/${CUSTOMERID}/${SOID}">
                                            ${(ITEM.item.name)}
                                        </a>
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.type)}
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.description)}
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.defOTP)}
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.defMP)}
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.modifiedDate)}
                                    </div>
                                    <div class="rTableCell">
                                        ${(ITEM.item.quantity)}
                                    </div>
                                    <div class="rTableCell">
                                        <a href="${contextPath}/application/add/${ITEM.item.itemId}/${CUSTOMERID}/${SOID}">
                                            Add
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <script src="${contextPath}/webresources/common/js/vendor/jquery.min.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/vendor/underscore.min.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/catalog.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/cart.js" type="text/javascript"></script>
                        <script src="${contextPath}/webresources/common/js/modules/main.js" type="text/javascript"></script>
                        <a href="${contextPath}/application/orderinfo" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                    </div>

                </div>
                <div id='gcw_mainFDKzQnAYv' class='gcw_mainFDKzQnAYv'></div>
                <a id='gcw_siteFDKzQnAYv' href='http://freecurrencyrates.com/ru/'>FreeCurrencyRates.com</a>
                <script>function reloadFDKzQnAYv(){ var sc = document.getElementById('scFDKzQnAYv');if (sc) sc.parentNode.removeChild(sc);sc = document.createElement('script');sc.type = 'text/javascript';sc.charset = 'UTF-8';sc.async = true;sc.id='scFDKzQnAYv';sc.src = 'http://freecurrencyrates.com/ru/widget-horizontal-editable?iso=USDEURBYNRUBCNY&df=1&p=FDKzQnAYv&v=fi&source=fcr&width=900&width_title=184&firstrowvalue=1&thm=A6C9E2,FCFDFD,4297D7,5C9CCC,FFFFFF,C5DBEC,FCFDFD,2E6E9E,000000&title=%D0%9A%D0%BE%D0%BD%D0%B2%D0%B5%D1%80%D1%82%D0%B5%D1%80%20%D0%B2%D0%B0%D0%BB%D1%8E%D1%82&tzo=-180';var div = document.getElementById('gcw_mainFDKzQnAYv');div.parentNode.insertBefore(sc, div);} reloadFDKzQnAYv(); </script>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $('#ITEM_TABLE').dataTable();
    });
</script>
<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
