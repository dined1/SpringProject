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
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Create a new Itemdiscount </b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${contextPath}/application/new" method="POST">
                                    <!--div class="form-group">
                                        <label for="IDid">iDid</label>
                                        <input class="form-control" type="number" name="iDid" path="iDid"  required="required" autofocus="autofocus"  />
                                    </div>
                                    <div class="form-group">
                                        <label>Item</label>
                                        <select path="item1" name="item1" onchange=" ">
                                            <option value="ord_null">Нет</option>
                                            <c:forEach items="${ITEM_LIST}" var="ITEM">
                                                <option value="${ITEM.itemId}">${ITEM.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Discountrule</label>
                                        <select path="discountrule1" name="discountrule1" onchange=" ">
                                            <option value="ord_null">Нет</option>
                                            <c:forEach items="${DISCOUNTRULE_LIST}" var="DISCOUNTRULE">
                                                <option value="${DISCOUNTRULE.dRId}">${DISCOUNTRULE.discountValue}</option>
                                            </c:forEach>
                                        </select>
                                    </div-->
                                    <!--input type="text" name="qw"/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button-- type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button-->
                                    <!--a href="${contextPath}/itemdiscount/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a-->

                                    <div class="dataTable_wrapper">
                                        <table class="table table-striped table-bordered table-hover" id="ITEM_TABLE">
                                            <thead>
                                            <tr>
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
                                            <c:forEach items="${ITEM_LIST}" var="ITEM">
                                                <tr>
                                                    <td>${(ITEM.name)}</td>

                                                    <td>${(ITEM.type)}</td>

                                                    <td>${(ITEM.description)}</td>

                                                    <td>${(ITEM.defMP)}</td>

                                                    <td>${(ITEM.defOTP)}</td>

                                                    <td>${(ITEM.modifiedDate)}</td>

                                                    <td>
                                                        <a href="${ITEM.itemId}"><i class="fa fa-level-up fa-fw"></i>  View</a>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
