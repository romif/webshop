<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>
<%@ page import="java.util.Collections"%>


<%
String mainParameter="";
List<Phone> phones=null;
if (request.getParameter("phone")!=null){
	phones=SqlManager.GetPhones(request.getParameter("phone"));
	mainParameter="phone="+request.getParameter("phone");
}
else if (request.getParameter("findtext")!=null){
	mainParameter="findtext="+new String(request.getParameter("findtext").getBytes("iso-8859-1"), "UTF-8");
	if (request.getParameter("price_before_new")!=null)mainParameter+="&price_before_new="+request.getParameter("price_before_new");
	if (request.getParameter("price_after_new")!=null)mainParameter+="&price_after_new="+request.getParameter("price_after_new");
	phones=SqlManager.SearchPhones(new String(request.getParameter("findtext").getBytes("iso-8859-1"), "UTF-8"),
			request.getParameter("price_before_new"),request.getParameter("price_after_new"));
};
%>
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
int maxPage=(int)Math.ceil((double)phones.size()/page_size);
if (request.getParameter("page_id")!=null) {
	try {
		page_id=Math.min(Integer.parseInt(request.getParameter("page_id")),maxPage);
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
							<option value=""
							<%if (sort.equals("")){%>selected=""<%}%> >
								Без сортировки
							</option>
							<option value="price" 
							<%if (sort.equals("price")){%>selected=""<%}%> >
								Начать с дешевых
							</option>
							<option value="price_desc"
							<%if (sort.equals("price_desc")){%>selected=""<%}%> >
								Начать с дорогих
							</option>
							<option value="name"
							<%if (sort.equals("name")){%>selected=""<%}%> >
								Название А-Я
							</option>
							<option value="name_desc"
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
								<option value="10" <%if (page_size==10){%>selected=""<%}%> >10</option>
								<option value="20" <%if (page_size==20){%>selected=""<%}%> >20</option>
								<option value="50" <%if (page_size==50){%>selected=""<%}%> >50</option>
							</select>
						</span>
					</td>
					<td>
						<ul class="sortingBlockRight">
     <%if (page_id==4) {%>
    <li id="first">
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id-3%>&sort=<%=sort%>"><%=page_id-3%></a>
    </li>
    <%} %>
    
     <%if (page_id-4>0) {%>
    <li id="first">
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=1&sort=<%=sort%>">1</a>
    </li>
    <%} %>

    <%if ((page_id-3>0)&&(page_id-3!=1)) {%>
    <li>
      <a href="?<%=mainParameter%>>&page_size=<%=page_size%>&page_id=<%=page_id-3%>&sort=<%=sort%>">...</a>
    </li>
    <%} %>

    <%if (page_id-2>0) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id-2%>&sort=<%=sort%>"><%=page_id-2%></a>
    </li>
    <%} %>

    <%if (page_id-1>0) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id-1%>&sort=<%=sort%>"><%=page_id-1%></a>
    </li>
    <%} %>

    <li class="razbAct"><span class="razbActText"><%=page_id%></span></li>

    <%if (page_id+1<maxPage) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id+1%>&sort=<%=sort%>"><%=page_id+1%></a>
    </li>
    <%} %>

    <%if (page_id+2<maxPage) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id+2%>&sort=<%=sort%>"><%=page_id+2%></a>
    </li>
    <%} %>

    <%if (page_id+3<maxPage) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=page_id+3%>&sort=<%=sort%>">...</a>
    </li>
    <%} %>

    <%if (page_id<maxPage) {%>
    <li>
      <a href="?<%=mainParameter%>&page_size=<%=page_size%>&page_id=<%=maxPage%>&sort=<%=sort%>"><%=maxPage%></a>
    </li>
    <%} %>
  </ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


<%for (int i=begin;i<end;i+=2){%>

<div class="itemRows">

	<div class="leftItem">
		<div class="itemBlockSmall">
			<h3><a href="/index?phoneID=<%=((Phone)phones.get(i)).getId()%>" title="<%=((Phone)phones.get(i)).getTitle()%>"><%=((Phone)phones.get(i)).getTitle()%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i)).getTitle()%>" href="/index?phoneID=<%=((Phone)phones.get(i)).getId()%>">
						<img alt="<%=((Phone)phones.get(i)).getTitle()%>" src="http://tomcat7-romif.rhcloud.com/picture?pic=<%=((Phone)phones.get(i)).getId()%>">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i)).getPriceUSD()%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i)).getPriceBY()%>&nbsp;руб.</span>
								</td>
								<td>
									<div class="buttons">
										<a class="buyButton" title="Купить" href="javascript:add_item(<%=((Phone)phones.get(i)).getId()%>)"><img src="/pics/blank.gif" alt=""></a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
	</div>
	
	<%
	if (i<phones.size()-1) {%>
	<div class="rightItem">
		<div class="itemBlockSmall">
			<h3><a href="/index?phoneID=<%=((Phone)phones.get(i+1)).getId()%>" 
			title="<%=((Phone)phones.get(i+1)).getTitle()%>"><%=((Phone)phones.get(i+1)).getTitle()%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i+1)).getTitle()%>" href="/index?phoneID=<%=((Phone)phones.get(i+1)).getId()%>">
						<img alt="<%=((Phone)phones.get(i+1)).getTitle()%>" src="http://tomcat7-romif.rhcloud.com/picture?pic=<%=((Phone)phones.get(i+1)).getId()%>">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i+1)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i+1)).getPriceUSD()%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i+1)).getPriceBY()%>&nbsp;руб.</span>
								</td>
								<td>
									<div class="buttons">
										<a class="buyButton" title="Купить" href="javascript:add_item(<%=((Phone)phones.get(i+1)).getId()%>)"><img src="/pics/blank.gif" alt=""></a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
<%} %>
</div>

<%}%>