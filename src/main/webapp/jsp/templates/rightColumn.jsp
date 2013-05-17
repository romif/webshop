<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>

<div class="content">
	
	<div id="shcart">
		<h3>Корзина</h3>
		<div class="shcartFrame">
			<iframe id="win_basket" name="win_basket" src="/index?shcart" class="shcart" scrolling="no" frameborder="0"></iframe>
		</div>
	</div>
	
	<div id="auth">
		<div id="loginPlace" style="background-image: none; background-position: initial initial; background-repeat: initial initial;">
		
		<%if (MainServlet.loggedUsers.containsKey(request.getSession().getId())) {%>
		<jsp:include page="/jsp/templates/loginPlace_logged.jsp" /><%}else{%>
		<jsp:include page="/jsp/templates/loginPlace_login.jsp" /><%}%>
		
	</div>
</div>

	<div id="rightBannerPanel">
		<span style="color: #ffff00">
			<span style="font-size: medium">
				<span style="font-family: Verdana">
					<strong><br></strong>
				</span>
			</span>
		</span>
<!--right admin banner-->
	</div>
</div>