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
                        <h5><i class="fa fa-info-circle fa-fw"></i> <b> Item info</b></h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <form role="form" action="${contextPath}/application/add/${ITEMID}/${CUSTOMERID}/${SOID}" method="GET">
                                        <jsp:include page="clild.jsp"/>

                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    </form>
                                </div>
                                <a href="${contextPath}/application/basket/${CUSTOMERID}/${SOID}" class="btn btn-default"><i class="fa fa-arrow-circle-left fa-fw"></i>Back</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/webresources/common/footer.jspf"%>
