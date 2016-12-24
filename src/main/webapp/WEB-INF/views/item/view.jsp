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
                        <h5><i class="fa fa-info-circle fa-fw"></i> <b> Item info</b></h5> 
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                            <thead>
                            <tr>
                                <th>Group Id</th>
                                <th>Name</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${ITEMGROUP_LIST}" var="ITEMGROUP">
                                <c:if test="${ITEMGROUP.item1.itemId == ITEM.itemId}">
                                    <tr>
                                        <td>${ITEMGROUP.groups1.groupId}</td>

                                        <td>${ITEMGROUP.groups1.name}</td>

                                        <td><a href="${contextPath}/admin/item/removegroup/${ITEMGROUP.iGId}">Delete</a></td>

                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                            <thead>
                            <tr>
                                <th>Group Id</th>
                                <th>Name</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${ITEMGROUP_LIST}" var="ITEMGROUP">
                                <c:if test="${ITEMGROUP.item1.itemId != ITEM.itemId}">
                                    <tr>
                                        <td>${ITEMGROUP.groups1.groupId}</td>

                                        <td>${ITEMGROUP.groups1.name}</td>

                                        <td><a href="${contextPath}/admin/item/add/${ITEM.itemId}/${ITEMGROUP.groups1.groupId}">Add</a></td>

                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>


                        <!--div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">

                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Item Id :</span></div>
                                            <div class="col-lg-8">${(ITEM.itemId)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Name :</span></div>
                                            <div class="col-lg-8">${(ITEM.name)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Type :</span></div>
                                            <div class="col-lg-8">${(ITEM.type)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Description :</span></div>
                                            <div class="col-lg-8">${(ITEM.description)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Def MP :</span></div>
                                            <div class="col-lg-8">${(ITEM.defMP)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Def OTP :</span></div>
                                            <div class="col-lg-8">${(ITEM.defOTP)}</div>
                                        </div>
                                    </a>             
                                    <a href="#" class="list-group-item">
                                        <div class="row">
                                            <div class="col-lg-4"><span class="small">Modified Date :</span></div>
                                            <div class="col-lg-8">${(ITEM.modifiedDate)}</div>
                                        </div>
                                    </a>             

                                </div>
                                <a href="${contextPath}/admin/item/list" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                            </div>
                        </div-->
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
