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
                        <h5><i class="fa fa-info-circle fa-fw"></i> <b> So info</b></h5> 
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                            <thead>
                            <tr>
                                <th>Item Id</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Def MP</th>
                                <th>Def OTP</th>
                                <th>Modified Date</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${PROD}" var="P">
                                    <tr>
                                        <td>${P.ordItem.orditemId}</td>
                                        <td>${P.ordItem.name}</td>
                                        <td>${P.ordItem.type}</td>
                                        <td>${P.ordItem.description}</td>
                                        <td>${P.ordItem.defMP}</td>
                                        <td>${P.ordItem.defOTP}</td>
                                        <td>${P.ordItem.modifiedDate}</td>

                                    </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!-- /.row (nested) -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
