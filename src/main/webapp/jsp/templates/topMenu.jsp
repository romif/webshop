<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="Windows-1251"%>

<table><tbody><tr>
<td><a href="${pageContext.request.contextPath}/index" class=main alt="�������">�������</a></td>
<td><a href="http://topmobail.shop.by/shcart/?step=2&nstep=2&url=/" alt="�������">�������</a></td>
<td><a href="http://topmobail.shop.by/info.xhtml" alt="� ��������">� ��������</a></td>
<td><a href="http://topmobail.shop.by/feedback.xhtml" alt="�������� �����">�������� �����</a></td>
<td><a href="http://topmobail.shop.by/compare/" alt="��������">��������</a></td>
<td><a href="http://topmobail.shop.by/find/" alt="����������� �����">����������� �����</a></td>
<td><a href="${pageContext.request.contextPath}/index?mode=delivery" class=delivery alt="�������� � ������">�������� � ������</a></td>
</tr></tbody></table>

<script type="text/javascript">
	document.getElementById('topMenu').getElementsByClassName(getQueryParameter('mode'))[0].setAttribute('id', 'active');	
</script>