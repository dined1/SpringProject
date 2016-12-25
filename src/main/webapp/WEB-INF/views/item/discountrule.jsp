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
                        <h5><i class="fa fa-info-circle fa-fw"></i> <b> Discountrule info</b></h5>
                    </div>
                    <div class="panel-body">

                        <table class="table table-striped table-bordered table-hover" id="DISCOUNTRULE_TABLE">
                            <thead>
                            <tr>
                                <th>Discountrule Id</th>
                                <th>Procent</th>
                                <th>Value</th>
                                <th>Description</th>
                                <th>Type</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${DISCOUNTRULE_LIST}" var="D">
                                <tr>
                                    <td>${D.dRId}</td>
                                    <td>${D.discountProcent}</td>
                                    <td>${D.discountValue}</td>
                                    <td>${D.description}</td>
                                    <td>${D.type}</td>
                                    <td><a href="${contextPath}/admin/item/removediscountrule/${ITEM.itemId}/${D.dRId}">Delete</a></td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <table class="table table-striped table-bordered table-hover" id="DISCOUNTRULE_TABLE">
                            <thead>
                            <tr>
                                <th>Discountrule Id</th>
                                <th>Procent</th>
                                <th>Value</th>
                                <th>Description</th>
                                <th>Type</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${NDISCOUNTRULE_LIST}" var="D">
                                <tr>
                                    <td>${D.dRId}</td>
                                    <td>${D.discountProcent}</td>
                                    <td>${D.discountValue}</td>
                                    <td>${D.description}</td>
                                    <td>${D.type}</td>

                                    <td><a href="${contextPath}/admin/item/adddiscountrule/${ITEM.itemId}/${D.dRId}">Add</a></td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <a href="${contextPath}/admin/item/list" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
