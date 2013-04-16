<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<h2>НОВЫЙ ПАРОЛЬ</h2>
				<div class="textcont ubp">Введите новый пароль.<strong>Все поля обязательны для заполнения</strong></div>
				<div id="regContainer">
					<form action="${pageContext.request.contextPath}/index" method="post" id="regForm" onsubmit="newPassSubmit(); return false;">
						<input name="mode" type="hidden" value="newPass">
						<input name="login" id="login" type="hidden" value="<%= request.getAttribute("login")%>">
						<table><tbody>
							<tr>
								<td><label for="reg_password">пароль:</label></td>
								<td>
									<input class="regParam" name="reg_password" id="reg_password" type="password">
									<div class="error" id="reg_password_error"></div>
									<b>длина пароля не менее 4 символов</b>
								</td>
							</tr>
							<tr>
								<td><label for="reg_password2">подтверждение пароля:</label></td>
								<td>
									<input class="regParam" name="reg_password2" id="reg_password2" type="password">
									<div class="error" id="reg_password2_error"></div>
								</td>
							</tr>
							<tr id="messageArea" style="display:none;"><td colspan="2"></td></tr>
							<tr>
								<td>
									<input type="submit" class="hiddenc" id="regBut" value="Изменить пароль">
									<a href="${pageContext.request.contextPath}/index?mode=reg#" onclick="document.getElementById('regBut').click();return false" title="Изменить пароль">Изменить пароль</a>
								</td>
							</tr>
						</tbody></table>
					</form>
				</div>
				<div class="textcont ubp"> Нужна помощь по регистрации и авторизации? Пожалуйста, нажмите <a target="_blank" href="http://shop.by/instruct.html#ireg" title="Помощь по регистрации">здесь</a>. </div>