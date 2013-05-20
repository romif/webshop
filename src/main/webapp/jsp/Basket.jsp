<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://www.eckelobjects.com/tagtut/tags1.0" prefix='template' %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<template:insert template='/jsp/templates/template.jsp'>
	<template:put name='head' content='/jsp/templates/head.jsp' />
	<template:put name='header' content='/jsp/templates/header.jsp' />
	<template:put name='topMenu' content='/jsp/templates/topMenu.jsp' />
	<template:put name='leftColumn' content='/jsp/templates/leftColumn.jsp' />
	<template:put name='rightColumn' content='/jsp/templates/rightColumn.jsp' />
	
	<%
	String basket_page="/jsp/templates/centerColumn_Basket_1.jsp";
	if (request.getParameter("step")!=null)
		if (request.getParameter("step").equals("2"))
			basket_page="/jsp/templates/centerColumn_Basket_2.jsp";
		else if (request.getParameter("step").equals("3"))
			basket_page="/jsp/templates/centerColumn_Basket_3.jsp";
	%>
	
	<template:put name='centerColumn' content='<%=basket_page%>' />
	<template:put name='footer' content='/jsp/templates/footer.jsp' />
 </template:insert>