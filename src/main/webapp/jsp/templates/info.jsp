<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8 "%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="util.sql.*"%>

<%
String user_id=(String)request.getSession().getId();
User user = SqlManager.GetUser(user_id);
%>
<h2>Личные данные</h2>
<div class="centerBlock">
	<form name="profile_form" id="profile_form" action="${pageContext.request.contextPath}/index" method="post">
		<input name="mode" type="hidden" value="userinfo">
		<input name="action" type="hidden" value="update">
		<table cellspacing="0" align="left" class="registerinfo">
			<tbody>
				<tr>
					<td class="tc">Имя</td>
					<td><input name="attr_name_3279" value="<%=user.getName()%>"></td>
				</tr>
				<tr>
					<td class="tc">Фамилия</td>
					<td><input name="attr_surname_3278" value="<%=user.getSurName()%>"></td>
				</tr>
				<tr>
					<td class="tc">Отчество</td>
					<td><input name="attr_patronym_3280" value="<%=user.getPatronymic()%>"></td>
				</tr>
				<tr>
					<td class="tc">Телефон</td>
					<td><input name="attr_phone_925" value="<%=user.getTel()%>"></td>
				</tr>
				<!-- <tr>
					<td class="tc">Пароль</td>
					<td><input name="attr_password" value="qqqq" type="password"></td>
				</tr>-->
				<tr>
					<td class="tc">Контактный e-mail</td>
					<td><input name="attr_email_930" value="<%=user.getE_mail()%>"></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" name="savebut" id="savebut" class="hiddenc" style="display:none;"><a href="#" onclick="document.getElementById('savebut').click(); return false" class="saveLink" title="Сохранить изменения">Сохранить</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
