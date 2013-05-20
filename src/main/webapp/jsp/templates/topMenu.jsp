<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<table><tbody><tr id="topMenuRow">

<%String mode="";
if (request.getParameter("mode")!=null) mode=request.getParameter("mode");
%>

<td><a href="/index" class=main alt="Главная"
<%if (!request.getParameterNames().hasMoreElements()){%>id="active"<%}%> >Главная</a></td>

<td><a href="/index?basket" alt="Корзина" 
<%if (request.getParameter("basket")!=null){%>id="active"<%}%> >Корзина</a></td>

<td><a href="/index" alt="О магазине">О магазине</a></td>

<!-- <td><a href="${pageContext.request.contextPath}/index" alt="Обратная связь">Обратная связь</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="Сравнить">Сравнить</a></td>  -->

<td><a href="/index?findtext" alt="Расширенный поиск"
<%if (request.getParameter("findtext")!=null){%>id="active"<%}%> >Расширенный поиск</a></td>

<td><a href="/index?mode=delivery" class=delivery alt="Доставка и оплата"
<%if (mode.equals("delivery")){%>id="active"<%}%> >
Доставка и оплата</a></td>

<%if ((MainServlet.loggedUsers.containsKey(request.getSession().getId()))&&
	(MainServlet.loggedUsers.get(request.getSession().getId())).getAccess().equals("admin"))
{%>
<td><a href="/index?mode=edit" alt="Редактор товаров"
<%if (mode.equals("edit")){%>id="active"<%}%>>Редактор</a></td>
<%}%>
</tr></tbody></table>

<!--  <script type="text/javascript">
	document.getElementById('topMenu').getElementsByClassName(getQueryParameter('mode'))[0].setAttribute('id', 'active');	
</script>-->