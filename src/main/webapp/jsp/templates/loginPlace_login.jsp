<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<h3>�����������</h3>
		<form name="login" id="loginF" onsubmit="shopLogin(); return false">
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
			<p class="errors" style="display:none;"></p>
			<div class="newLine">
				<input type="image" src="./TopmoBail_files/login_but.gif" class="formButton" id="signup" value="�����" style="display:none;">
				<a href="${pageContext.request.contextPath}/index?mode=login#" title="�����" class="formButton" onclick="javascript:document.getElementById(&#39;signup&#39;).click();return false">�����</a>
				<p class="links">
					<a href="${pageContext.request.contextPath}/index?mode=reg" title="������� �� �������� �����������" class="margLink">�����������</a>
					<a href="${pageContext.request.contextPath}/index?mode=restore" title="������� �� �������� ������������� ������">������ ������?</a>
				</p>
			</div>
		</form>