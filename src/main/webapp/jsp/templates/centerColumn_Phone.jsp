<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>
<%@ page import="java.util.Collections"%>


<ul id="sectionsTree">
	<li class="firstSectionTree"><a href="/index" alt="Главная">Главная</a>&nbsp;»&nbsp;</li>
	<li><%=request.getParameter("phone")%></li>
</ul>
<div style="clear:both;"></div>
<div style="clear:both;"> </div>

<jsp:include page='/jsp/templates/centerColumn_ShowPhones.jsp'/>