<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5><i class="fa fa-plus-square fa-fw"></i> <b> Create a new So </b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${appPath}/so/new" method="POST">
                                    <div class="form-group">
                                        <label for="SOId">SOId</label>
                                        <input class="form-control" type="number" name="SOId" path="SOId"  required="required" autofocus="autofocus"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="dateCreated">Date Created</label>
                                        <input class="form-control" type="text" name="dateCreated" path="dateCreated"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="orderDate">Order Date</label>
                                        <input class="form-control" type="text" name="orderDate" path="orderDate"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <input class="form-control" type="text" name="status" path="status"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="SONumber">SONumber</label>
                                        <input class="form-control" type="text" name="SONumber" path="SONumber"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="purchaseOrderNumber">Purchase Order Number</label>
                                        <input class="form-control" type="text" name="purchaseOrderNumber" path="purchaseOrderNumber"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="dateModified">Date Modified</label>
                                        <input class="form-control" type="text" name="dateModified" path="dateModified"  />
                                    </div>
                                    <div class="form-group">
                                        <label>Costumer</label>
                                        <select path="customer1" name="customer1" onchange=" ">
                                            <option value="ord_null">Нет</option>
                                            <c:forEach items="${CUSTOMER_LIST}" var="CUSTOMER">
                                                <option value="${CUSTOMER.customerId}">${CUSTOMER.lastName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>User</label>
                                        <select path="user1" name="user1" onchange=" ">
                                            <option value="ord_null">Нет</option>
                                            <c:forEach items="${USER_LIST}" var="USER">
                                                <option value="${USER.userId}">${USER.login}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-check fa-fw"></i>Submit</button>
                                    <a href="${appPath}/so/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
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
