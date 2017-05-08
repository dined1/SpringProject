<%--
  Created by IntelliJ IDEA.
  User: dzni0816
  Date: 19.04.2017
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/i18n/defaults-*.min.js"></script>

<div id="popupoe" class="popover">
    <div class="modal-content">
        <form id="dynForm" role="form" action="${contextPath}/adm/orderentry/new" method="POST">
            <c:if test="${empty CUSTOMER_LIST}">
                <h4>Please, create customer</h4><Br/>
            </c:if>
            <c:if test="${!empty CUSTOMER_LIST}">
                <div class="form-group">
                    <label>Distribution channel: </label>
                    <div class="form-group">
                        <input class="form-control" type="text" pattern="[a-zA-Z]+" name="country" path="country" title="Only letters" list="country_list" required />
                        <datalist id="country_list">
                            <option>Belarus</option>
                            <option>Russia</option>
                            <option>Ukraine</option>
                            <option>Poland</option>
                            <option>Czech</option>
                            <option>Slovakia</option>
                            <option>Serbia</option>
                        </datalist>
                    </div>
                </div>
                <div class="form-group">
                    <label>Address: </label>
                    <select class="selectpicker" path="addresslist" data-live-search="true" name="addresslist" onchange=" ">
                        <c:forEach items="${ADDRESS_LIST}" var="ADDRESS">
                            <option value="${ADDRESS.locationId}">${ADDRESS.name}</option>
                        </c:forEach>
                        <c:forEach items="${RELATED_ADDRESS_LIST}" var="ADDRESS">
                            <option value="${ADDRESS.parentLocation.locationId}">${ADDRESS.name}</option>
                        </c:forEach>
                    </select>
                    <input type="hidden" name="customer" value="${CUSTOMER.customerId}"/>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
            </c:if>
            <a href="${contextPath}/adm/orderentry/${CUSTOMER.customerId}" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
        </form>
    </div>
</div>

<div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-6"><h5><i class="fa fa-database fa-fw"></i> <b> So List</b></h5></div>
                        <div class="col-lg-6">
                            <div align="right">
                                <a class="btn btn-primary btn-sm" onclick="return popup()"><i class="fa fa-plus"></i> Add</a>
                                <c:if test="${not empty requestScope.SO_LIST}">
                                    <!--a href="${contextPath}/cabinet/print/${USER_ID}" class="btn btn-default btn-sm">
                                    <i class="fa fa-print fa-fw"></i> Print
                                    </a-->
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="dataTable_wrapper">
                        <c:forEach items="${SO_LIST}" var="SO">
                            <c:if test="${fn:contains(SO.attentionFlag, 'Waiting for payment')}">
                                <label>Please, pay the order ${SO.SONumber}</label>
                                <br>
                                <c:if test="${fn:contains(SO.attentionFlag, 'Waiting for payment')}">
                                    <label><a href="order/${SO.customer1.customerId}/${SO.SOId}"><i class="fa fa-level-up fa-fw"></i>  Pay</a></label>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <table class="table table-striped table-bordered table-hover" id="SO_TABLE">
                            <thead>
                            <tr>
                                <th>SONumber</th>
                                <th>Customer</th>
                                <th>Customer e-mail</th>
                                <th>Status</th>
                                <th>Location</th>
                                <th>Purchase Order Number</th>
                                <th>Date Created</th>
                                <th>Date Modified</th>
                                <th>Order Date</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${SO_LIST}" var="SO">
                                <tr>
                                    <c:if test="${fn:contains(SO.attentionFlag, 'Waiting for payment')}">
                                        <td style="color: red"><h3>${(SO.SONumber)}</h3></td>
                                    </c:if>
                                    <c:if test="${not fn:contains(SO.attentionFlag, 'Waiting for payment')}">
                                        <td>${(SO.SONumber)}</td>
                                    </c:if>
                                    <td>${(SO.customer1.firstName)}, ${SO.customer1.lastName}</td>
                                    <td>${(SO.customer1.email)}</td>
                                    <td>${(SO.status)}</td>
                                    <td>${(SO.distributionChannel)}</td>
                                    <td>${(SO.purchaseOrderNumber)}</td>
                                    <td>${(SO.dateCreated)}</td>
                                    <td>${(SO.dateModified)}</td>
                                    <td>${(SO.orderDate)}</td>
                                    <td>
                                        <a href="basket/${SO.customer1.customerId}/${SO.SOId}"><i class="fa fa-level-up fa-fw"></i>  Details</a>
                                    </td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <a href="${contextPath}/cabinet/cabinet" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</div>
<script>
    var popupoe = document.getElementById('popupoe');

    var subm = document.getElementById('subm');

    subm.onclick = function() {
        document.getElementById("dynForm").submit();
        location.reload()
        popupoe.style.display = "none";
    };

    function popup() {
        popupoe.style.display = "block";
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
<script>
    $(document).ready(function () {
        $('#SO_TABLE').DataTable({
            responsive: true
        });
    });
</script>