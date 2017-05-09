<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper" class="">
    <div class="modal-content">
        <form id="dynForm" role="form" action="${contextPath}/adm/orderentry/customerlocations" method="POST">
            <div class="form-group">
                <label>: </label>
                <select class="selectpicker" path="addresslist" data-live-search="true" name="addresslist" onchange=" ">
                    <c:forEach items="${LOCATIONSLIST}" var="LOCATION">
                        <option value="${LOCATION.locationId}">${LOCATION.name}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="customer" value="${CUSTOMER}"/>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button href="" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Create related</button>
            <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Create new anyway</button>
            <a href="${contextPath}/adm/orderentry/customerlocations/${CUSTOMER}" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
