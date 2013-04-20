<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>
<%@ page import="servlet.*"%>
<table><tbody><tr>
<td><a href="${pageContext.request.contextPath}/index" class=main alt="Главная">Главная</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="Корзина">Корзина</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="О магазине">О магазине</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="Обратная связь">Обратная связь</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="Сравнить">Сравнить</a></td>
<td><a href="${pageContext.request.contextPath}/index" alt="Расширенный поиск">Расширенный поиск</a></td>
<td><a href="${pageContext.request.contextPath}/index?mode=delivery" class=delivery alt="Доставка и оплата">Доставка и оплата</a></td>
<%if ((MainServlet.loggedUsers.containsKey(request.getSession().getId()))&&
	(MainServlet.loggedUsers.get(request.getSession().getId())).getAccess().equals("admin"))
{%>
<td><a href="${pageContext.request.contextPath}/index?mode=edit" alt="Редактор товаров">Редактор</a></td>
<%}%>
</tr></tbody></table>

<script type="text/javascript">
	document.getElementById('topMenu').getElementsByClassName(getQueryParameter('mode'))[0].setAttribute('id', 'active');	
</script>