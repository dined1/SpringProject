<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Name: </span></div>
        <div class="col-lg-8">${(ITEM.name)}</div>
    </div>
</a>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Type: </span></div>
        <div class="col-lg-8">${(ITEM.type)}</div>
    </div>
</a>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Description: </span></div>
        <div class="col-lg-8">${(ITEM.description)}</div>
    </div>
</a>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Def MP: </span></div>
        <div class="col-lg-8">${(ITEM.defMP)}</div>
    </div>
</a>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Def OTP: </span></div>
        <div class="col-lg-8">${(ITEM.defOTP)}</div>
    </div>
</a>
<a href="#" class="list-group-item">
    <div class="row">
        <div class="col-lg-4"><span class="small">Modified Date: </span></div>
        <div class="col-lg-8">${(ITEM.modifiedDate)}</div>
    </div>
</a>
<div class="row">
    <c:forEach items="${ITEM.ordItems}" var="ITEM">
        <c:set var="ITEM" value="${ITEM}" scope="request"/>
        <jsp:include page="clild.jsp"/>
    </c:forEach>
</div>
<c:if test="${not empty ITEMCHARACTERISTICS}">
    <div class="row">
        <label>Charactiristics: </label><br>
        <c:forEach items="${ITEMCHARACTERISTICS}" var="Characteristic">
            <tr>
                <c:if test="${Characteristic.ordItem.orditemId==ITEM.orditemId}">
                    <td><label>${Characteristic.itemCharacteristic.characteristic}:
                            ${Characteristic.itemCharacteristic.characteristicValue}</label></td>
                </c:if>
            </tr>
        </c:forEach>
    </div>
</c:if>
<c:if test="${not empty ITEMDISCOUNTS}">
    <Br/>
    <div>
        <label>Active discounts and taxes: </label><br>
        <c:forEach items="${ITEMDISCOUNTS}" var="DISCOUNT">
            <tr>
                <c:if test="${DISCOUNT.ordItem.orditemId==ITEM.orditemId && DISCOUNT.discountrule1.type=='disc'}">
                    <td><label>${DISCOUNT.discountrule1.description} :
                        value - ${DISCOUNT.discountrule1.discountValue}$, percentage - ${DISCOUNT.discountrule1.discountProcent}%</label></td>
                </c:if>
                <c:if test="${DISCOUNT.ordItem.orditemId==ITEM.orditemId && DISCOUNT.discountrule1.type=='tax'}">
                    <span style="color:darkred">Tax</span>
                    <td><label>${DISCOUNT.discountrule1.description} :
                        value - ${DISCOUNT.discountrule1.discountValue}$, percentage - ${DISCOUNT.discountrule1.discountProcent}%</label></td>
                </c:if>
            </tr>
        </c:forEach>
    </div>
</c:if>