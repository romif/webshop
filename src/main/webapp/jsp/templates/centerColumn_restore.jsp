<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<h2>�������������� ������</h2>
<div class="textcont ubp">��� �������������� ������ ������� ���� e-mail</div>
<div id="regContainer">
	<form action="${pageContext.request.contextPath}/index?mode=restore" method="post" onsubmit="return restorePass()">
		<input name="mode" type="hidden" value="restore">
		<p id="emailContainer">
			<label for="res_email">e-mail:</label>
			<input name="res_email" id="res_email">
			<br>
			<span class="error" id="res_email_error"></span>
			<br>
			<input type="submit" id="restBut" class="hiddenc" value="������������">
			<a href="#" onclick="document.getElementById('restBut').click();return false" title="��������� ������ �� ��������� e-mail">������������ ������</a>
		</p>
	</form>
</div>
