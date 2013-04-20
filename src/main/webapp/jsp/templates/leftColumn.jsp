<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>


<div id="search">
	<span>Поиск</span>
	<form action="http://topmobail.shop.by/find/" method="get" onsubmit="return CheckFind();">
		<input name="findtext" maxlength="20" alt="Поиск" type="text" class="find_txt">
		<button id="button_search" class="png"></button>
	</form>
	<a href="http://topmobail.shop.by/find/">Расширенный поиск</a>
</div>

<div id="leftColCont">
	<div id="leftCatalog">
		<%if ((request.getParameter("mode")!=null)&&(request.getParameter("mode").equals("userinfo"))){%>
		<jsp:include page="/jsp/templates/leftCatalog_UserManageForm.jsp" /><%}else{ %>
		<jsp:include page="/jsp/templates/leftCatalog_Catalog.jsp" /> <%} %>
		
	</div>
	<div id="leftBannerPanel"><br><!--left admin banner--></div>
</div>
