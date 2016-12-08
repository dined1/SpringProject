<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container">


    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>
        <a href="${contextPath}/customer/cabinet" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
        <a href="${contextPath}/customer/list" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Cancel</a>
        <a href="${contextPath}/application/finalpay" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Pay</a>
        <a href="${contextPath}/application/new" class="btn btn-default"><i class="fa fa-close fa-fw"></i>Basket</a>
        <!--form action="handler.php">
            <p><b>Как по вашему мнению расшифровывается аббревиатура &quot;ОС&quot;?</b></p>
            <p><input type="radio" name="answer" value="a1">Офицерский состав<Br>
                <input type="radio" name="answer" value="a2">Операционная система<Br>
                <input type="radio" name="answer" value="a3">Большой полосатый мух</p>
            <p><input type="submit"></p>
        </form-->

    </c:if>

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
