<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/webresources/common/header.jspf"%>

<div id="wrapper">
    <%@ include file="/webresources/common/navigationbar.jspf"%>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-lg-6"><h5><i class="fa fa-database fa-fw"></i> <b> Discountrule List</b></h5></div>
                            <div class="col-lg-6">
                                <div align="right">
                                    <a class="btn btn-primary btn-sm" href="new"><i class="fa fa-plus"></i> Add</a>
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
                                    <th>DRId</th>
                                    <th>Discount Value</th>
                                    <th>Discount Procent</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${DISCOUNTRULE_LIST}" var="DISCOUNTRULE">
                                    <tr>
                                        <td>${(DISCOUNTRULE.dRId)}</td>

                                        <td>${(DISCOUNTRULE.discountValue)}</td>

                                        <td>${(DISCOUNTRULE.discountProcent)}</td>

                                        <td>
                                            <div class="pull-right">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-primary btn-xs dropdown-toggle" data-toggle="dropdown">
                                                        <i class="fa fa-gear"></i>  <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu pull-right" role="menu">
                                                        <li><a href="${DISCOUNTRULE.dRId}"><i class="fa fa-level-up fa-fw"></i>  View</a></li>
                                                        <li><a href="${contextPath}/admin/discountrule/update/${DISCOUNTRULE.dRId}"><i class="fa fa-edit fa-fw"></i>  Edit</a></li>
                                                        <li class="divider"></li>
                                                        <li><a data-toggle="modal" data-target="#confirm_delete_${DISCOUNTRULE.dRId}" href="#"  ><i class="fa fa-trash-o fa-fw"></i> Delete</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- Modal -->
                                            <div class="modal fade" id="confirm_delete_${DISCOUNTRULE.dRId}" tabindex="-1" role="dialog" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            <h4 class="modal-title">Confirmation</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Are you sure to delete Discountrule?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <form action="${contextPath}/admin/discountrule/remove/${DISCOUNTRULE.dRId}" method="DELETE">
                                                                <a href="#" class="btn" data-dismiss="modal">Cancel</a> <button type="submit" class="btn btn-primary">Confirm</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <!-- /.modal-content -->
                                                </div>
                                                <!-- /.modal-dialog -->
                                            </div>
                                            <!-- /.modal -->
                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>


                        <c:if test="${empty requestScope.DISCOUNTRULE_LIST}">
                            <div class="alert alert-info">
                                <div align="center">No Discountrule found</div>
                            </div>
                        </c:if>



                    </div>
                    <a href="${contextPath}/adm" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
</div>
<script>
    $(document).ready(function () {
        $('DISCOUNTRULE_TABLE').DataTable({
            responsive: true
        });
    });
</script>

<%--end content--%>
<%@ include file="/webresources/common/footer.jspf"%>
