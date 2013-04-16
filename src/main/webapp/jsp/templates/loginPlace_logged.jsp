<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>
<%@ page import="servlet.*"%>
<h3>Добро пожаловать</h3>
<p class="welcomeLine">
	<strong><%=MainServlet.loggedUsers.get(request.getSession().getId()).getLogin()%></strong>
</p>
<p>
	<a href="${pageContext.request.contextPath}/index?mode=userinfo" title="Личный кабинет">Личный кабинет</a>
	&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath}/index?mode=exit" title="Выйти">Выйти</a>
</p>