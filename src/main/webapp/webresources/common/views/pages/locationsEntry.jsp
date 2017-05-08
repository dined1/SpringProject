<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%--<%@ include file="/webresources/common/navigationbar.jspf"%>--%>
    <div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-lg-6"><h5><i class="fa fa-database fa-fw"></i> <b> Location List</b></h5></div>
                            <div class="col-lg-6">
                                <div align="right">
                                    <a class="btn btn-primary btn-sm" onclick="return locpopup()"><i class="fa fa-plus"></i> Create location</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="dataTable_wrapper">
                            <table class="table table-striped table-bordered table-hover" id="DISCOUNTRULE_TABLE">
                                <thead>
                                <tr>
                                    <th>Location id</th>
                                    <th>Location</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${LOCATIONSLIST}" var="LOCATION">
                                    <tr>
                                        <td>${(LOCATION.locationId)}</td>

                                        <td>${(LOCATION.name)}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <%--<a href="${contextPath}/adm" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>--%>
                    </div>

                    <div class="panel-body">
                        <div class="dataTable_wrapper">
                            <table class="table table-striped table-bordered table-hover" id="DISCOUNTRULE_TABLE">
                                <thead>
                                <tr>
                                    <th>Location id</th>
                                    <th>Location</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${RELATEDLOCATIONSLIST}" var="LOCATION">
                                    <tr>
                                        <td>${(LOCATION.locationId)}</td>

                                        <td>${(LOCATION.name)}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
</div>



<div id="popuploc" class="popover">
    <div class="modal-content">
        <form id="dynForm" role="form" action="${contextPath}/adm/orderentry/customerlocations" method="POST">
            <div class="form-group">
                <label>Location name: </label>
                <input class="form-control" type="text" pattern="[a-zA-Z0-9- ]+" title="Only numbers and english letters" name="name" path="name" required = "required"/>
            </div>
            <div class="form-group">
                <label>Address: </label>
                <select class="selectpicker" path="addresslist" data-live-search="true" name="addresslist" onchange=" ">
                    <c:forEach items="${ADDRESS_LIST}" var="ADDRESS">
                        <option value="${ADDRESS.addressId}">${ADDRESS.country}, ${ADDRESS.city}, ${ADDRESS.addressLine}, ${ADDRESS.postalCode}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="customer" value="${CUSTOMER.customerId}"/>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
            <a href="${contextPath}/adm/orderentry/customerlocations/${CUSTOMER.customerId}" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
        </form>
    </div>
</div>


<script>
    var popuploc = document.getElementById('popuploc');

    var subm = document.getElementById('subm');

    subm.onclick = function() {
        document.getElementById("dynForm").submit();
        location.reload()
        popuploc.style.display = "none";
    };

    function locpopup() {
        popuploc.style.display = "block";
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
        $('#DISCOUNTRULE_TABLE').DataTable({
            responsive: true
        });
    });
</script>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
