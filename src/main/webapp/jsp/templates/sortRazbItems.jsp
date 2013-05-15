<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>
<%@ page import="java.util.Collections"%>

<div class="sortRazbItems">
<%

String sort="";
if (request.getParameter("sort")!=null) {
	sort=request.getParameter("sort");
}

if (sort.equals("price"))
	Collections.sort(phones, 
			Phone.PhoneComparator.getComparator(Phone.PhoneComparator.PRICE_SORT));
else if (sort.equals("price_desc"))
	Collections.sort(phones, 
			Phone.PhoneComparator.descending(
					Phone.PhoneComparator.getComparator(Phone.PhoneComparator.PRICE_SORT)));
else if (sort.equals("name"))
	Collections.sort(phones, 
			Phone.PhoneComparator.getComparator(Phone.PhoneComparator.NAME_SORT));
else if (sort.equals("name_desc"))
	Collections.sort(phones, 
			Phone.PhoneComparator.descending(
					Phone.PhoneComparator.getComparator(Phone.PhoneComparator.NAME_SORT)));

int page_size=20;
if (request.getParameter("page_size")!=null) {
	if (request.getParameter("page_size").equals("10"))page_size=10;
	if (request.getParameter("page_size").equals("20"))page_size=20;
	if (request.getParameter("page_size").equals("50"))page_size=50;
}
int page_id=1;
if (request.getParameter("page_id")!=null) {
	try {
		page_id=Integer.parseInt(request.getParameter("page_id"));
	}
	catch (NumberFormatException e){
		page_id=1;
	}
}
int itemsNumber=Math.min(phones.size(),page_size);
int begin=0;
int end=itemsNumber;
if ((page_id-1)*page_size<phones.size()){
	begin=(page_id-1)*page_size;
	end=Math.min(page_id*page_size,phones.size());
}
int maxPage=(int)Math.ceil((double)phones.size()/page_size);
%>
	<div class="findButton"> 
		<table cellspacing="0" cellpadding="0" width="100%" id="navig_line">
			<tbody>
				<tr>
					<td width="50%">Товаров:&nbsp;
						<span class="bold"><%=phones.size()%></span>
					</td>
					<td>
						<div class="sort">
							<span>Сортировка:&nbsp;</span>
							<select name="sort" class="sortsel" id="optd" onchange="_chaction()">
							<option value="&page_id=<%=page_id%>&page_size=<%=page_size%>"
							<%if (sort.equals("")){%>selected=""<%}%> >
								Без сортировки
							</option>
							<option value="&sort=price&page_id=<%=page_id%>&page_size=<%=page_size%>" 
							<%if (sort.equals("price")){%>selected=""<%}%> >
								Начать с дешевых
							</option>
							<option value="&sort=price_desc&page_id=<%=page_id%>&page_size=<%=page_size%>"
							<%if (sort.equals("price_desc")){%>selected=""<%}%> >
								Начать с дорогих
							</option>
							<option value="&sort=name&page_id=<%=page_id%>&page_size=<%=page_size%>"
							<%if (sort.equals("name")){%>selected=""<%}%> >
								Название А-Я
							</option>
							<option value="&sort=name_desc&page_id=<%=page_id%>&page_size=<%=page_size%>"
							<%if (sort.equals("name_desc")){%>selected=""<%}%> >
								Название Я-А
							</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>Показано:&nbsp; с 
						<span class="bold"><%=begin+1%></span> &nbsp;по&nbsp; 
						<span class="bold"><%=end%></span>
						<span class="num_pag">отображать по:&nbsp;
							<select name="page" id="oppg" onchange="_chactionpg()">
								<option value="&page_size=10&amp;page_id=1&sort=<%=sort%>" <%if (page_size==10){%>selected=""<%}%> >10</option>
								<option value="&page_size=20&amp;page_id=1&sort=<%=sort%>" <%if (page_size==20){%>selected=""<%}%> >20</option>
								<option value="&page_size=50&amp;page_id=1&sort=<%=sort%>" <%if (page_size==50){%>selected=""<%}%> >50</option>
							</select>
						</span>
					</td>
					<td>
						<ul class="sortingBlockRight">
     <%if (page_id==4) {%>
    <li id="first">
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id-3%>&sort=<%=sort%>"><%=page_id-3%></a>
    </li>
    <%} %>
    
     <%if (page_id-4>0) {%>
    <li id="first">
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=1&sort=<%=sort%>">1</a>
    </li>
    <%} %>

    <%if ((page_id-3>0)&&(page_id-3!=1)) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id-3%>&sort=<%=sort%>">...</a>
    </li>
    <%} %>

    <%if (page_id-2>0) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id-2%>&sort=<%=sort%>"><%=page_id-2%></a>
    </li>
    <%} %>

    <%if (page_id-1>0) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id-1%>&sort=<%=sort%>"><%=page_id-1%></a>
    </li>
    <%} %>

    <li class="razbAct"><span class="razbActText"><%=page_id%></span></li>

    <%if (page_id+1<maxPage) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id+1%>&sort=<%=sort%>"><%=page_id+1%></a>
    </li>
    <%} %>

    <%if (page_id+2<maxPage) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id+2%>&sort=<%=sort%>"><%=page_id+2%></a>
    </li>
    <%} %>

    <%if (page_id+3<maxPage) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=page_id+3%>&sort=<%=sort%>">...</a>
    </li>
    <%} %>

    <%if (page_id<maxPage) {%>
    <li>
      <a href="?phone=<%=request.getParameter("phone")%>&page_size=<%=page_size%>&page_id=<%=maxPage%>&sort=<%=sort%>"><%=maxPage%></a>
    </li>
    <%} %>
  </ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
