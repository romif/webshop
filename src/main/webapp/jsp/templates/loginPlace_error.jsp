<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<h3>�����������</h3>
<form name="login" id="loginF" onSubmit="shopLogin(); return false">
	<input type="hidden" name="mode" id="log_mode" value="login">
	<input type="hidden" name="type" id="log_type" value="email_password">
	<p class="posRelative">
		<label for="log_email" onclick="hideTitle(this)">e-mail</label>
		<input type="text" onfocus="clean(this)" onblur="showTitle(this)" name="email" id="log_email" value="">
	</p>
	<p class="posRelative">
		<label for="log_password" onclick="hideTitle(this)">������</label>
		<input type="password" onfocus="clean(this)" onblur="showTitle(this)" id="log_password" name="password" value="">
	</p>
	<p class="errors" style="display:block;">������ ������������ �� ����������</p>
	<div class="newLine">
		<input type="image" src="/pics/login_but.gif" class="formButton" id="signup" value="�����" style="display:none;">
		<a href="#" title="�����" class="formButton" onClick="javascript:document.getElementById('signup').click();return false">�����</a>
		<p class="links">
			<a href="/user/?mode=reg" title="������� �� �������� �����������" class="margLink">�����������</a>
			<a href="/user/?mode=restore" title="������� �� �������� ������������� ������">������ ������?</a>
		</p>
	</div>
</form>