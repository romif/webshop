<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<h2>�����������</h2>
				<div class="textcont ubp">��� ����������� ��������� ���� ����� ����. <strong>��� ���� ����������� ��� ����������</strong></div>
				<div id="regContainer">
					<form action="${pageContext.request.contextPath}/index" method="post" id="regForm" onsubmit="regSubmit(0); return false;">
						<input name="mode" type="hidden" value="reg">
						<table><tbody>
							<tr>
								<td><label for="reg_email">e-mail:</label></td>
								<td id="emailContainer">
									<input class="regParam" name="reg_email" id="reg_email" value="">
									<div class="error" id="reg_email_error"></div>
								</td>
							</tr>
							<tr>
								<td><label for="reg_password">������:</label></td>
								<td>
									<input class="regParam" name="reg_password" id="reg_password" type="password">
									<div class="error" id="reg_password_error"></div>
									<b>����� ������ �� ����� 4 ��������</b>
								</td>
							</tr>
							<tr>
								<td><label for="reg_password2">������������� ������:</label></td>
								<td>
									<input class="regParam" name="reg_password2" id="reg_password2" type="password">
									<div class="error" id="reg_password2_error"></div>
								</td>
							</tr>
							<tr id="messageArea" style="display:none;"><td colspan="2"></td></tr>
							<tr>
								<td>
									<input type="submit" class="hiddenc" id="regBut" value="�����������">
									<a href="${pageContext.request.contextPath}/index?mode=reg#" onclick="document.getElementById('regBut').click();return false" title="������������������ �� �����">������������������</a>
								</td>
							</tr>
						</tbody></table>
					</form>
				</div>
				<div class="textcont ubp"> ����� ������ �� ����������� � �����������? ����������, ������� <a target="_blank" href="http://shop.by/instruct.html#ireg" title="������ �� �����������">�����</a>. </div>