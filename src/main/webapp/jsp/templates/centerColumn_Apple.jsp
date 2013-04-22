<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>
<%
List<Phone> phones=SqlManager.GetPhones("Apple");
%>

<ul id="sectionsTree">
	<li class="firstSectionTree"><a href="/" alt="Главная">Главная</a>&nbsp;»&nbsp;</li>
	<li>Apple</li>
</ul>
<div style="clear:both;"></div>
<div style="clear:both;"></div>
<div class="sortRazbItems">
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
							<option value="?no&amp;page_id=1&amp;page_size=20">
								Без сортировки
							</option>
							<option value="?sort=price--number&amp;page_id=1&amp;page_size=20">
								Начать с дешевых
							</option>
							<option value="?sort=price--number--desc&amp;page_id=1&amp;page_size=20">
								Начать с дорогих
							</option>
							<option value="?sort=name--text&amp;page_id=1&amp;page_size=20">
								Название А-Я
							</option>
							<option value="?sort=name--text--desc&amp;page_id=1&amp;page_size=20">
								Название Я-А
							</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>Показано:&nbsp; с 
						<span class="bold">1</span> &nbsp;по&nbsp; 
						<span class="bold">8</span>
						<span class="num_pag">отображать по:&nbsp;
							<select name="page" id="oppg" onchange="_chactionpg()">
								<option value="?page_size=10&amp;page_id=1">10</option>
								<option value="?page_size=20&amp;page_id=1" selected="">20</option>
								<option value="?page_size=50&amp;page_id=1">50</option>
							</select>
						</span>
					</td>
					<td>
						<ul class="sortingBlockRight"></ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<%for (int i=0;i<Math.ceil((double)phones.size()/2);i++){%>

<div class="itemRows">

	<div class="leftItem">
		<div class="itemBlockSmall">
			<h3><a href="/24/1001/" title="<%=((Phone)phones.get(i*2)).getTextProperties()[1]%>"><%=((Phone)phones.get(i*2)).getTextProperties()[1]%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i*2)).getTextProperties()[1]%>" href="/24/1001/">
						<img alt="<%=((Phone)phones.get(i*2)).getTextProperties()[1]%>" src="http://tomcat7-romif.rhcloud.com/picture">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i*2)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i*2)).getTextProperties()[2]%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i*2)).getTextProperties()[3]%>&nbsp;руб.</span>
								</td>
								<td>
									<div class="buttons">
										<a class="buyButton" title="Купить" href="javascript:add_item(2254)"><img src="/pics/blank.gif" alt=""></a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
	</div>
	
	<%if (i*2<phones.size()-1) {%>
	<div class="rightItem">
		<div class="itemBlockSmall">
			<h3><a href="/24/1001/" title="<%=((Phone)phones.get(i*2+1)).getTextProperties()[1]%>"><%=((Phone)phones.get(i*2+1)).getTextProperties()[1]%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i*2+1)).getTextProperties()[1]%>" href="/24/1001/">
						<img alt="<%=((Phone)phones.get(i*2+1)).getTextProperties()[1]%>" src="/pics/items/Apple%20iPhone%204%208Gb_icon.jpg">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i*2+1)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i*2+1)).getTextProperties()[2]%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i*2+1)).getTextProperties()[3]%>&nbsp;руб.</span>
								</td>
								<td>
									<div class="buttons">
										<a class="buyButton" title="Купить" href="javascript:add_item(2254)"><img src="/pics/blank.gif" alt=""></a>
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

<%} %>
<!-- <div class="itemRows">
<div class="leftItem"><div class="itemBlockSmall">
<h3><a href="/24/1000/" title="Apple iPhone 4S 32Gb">Apple iPhone 4S 32Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 4S 32Gb" href="/24/1000/"><img alt="Apple iPhone 4S 32Gb" src="/pics/items/Apple%20iPhone%204S%2016Gb_icon.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки . Трубка, 115 x 58.5 x 9.5 мм, 140 г, ios 5.0, емкостной экран ips 16 млн. цветов, 640x960, 3.5 дюйм, 326 ppi, камера 8 мп, видео 1920 x 1080 30fps, встроенная память 32768 мб, 3g, wi-fi, стерео bluetooth, gps, 1420 мач li-ion, белый, черный, <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">690&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">5 968 500&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2253)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
<div class="rightItem"><div class="itemBlockSmall">
<h3><a href="/24/999/" title="Apple iPhone 4S 64Gb">Apple iPhone 4S 64Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 4S 64Gb" href="/24/999/"><img alt="Apple iPhone 4S 64Gb" src="/pics/items/Apple%20iPhone%204S%2016Gb_icon.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки . Трубка, 115 x 58.5 x 9.5 мм, 140 г, ios 5.0, емкостной экран ips 16 млн. цветов, 640x960, 3.5 дюйм, 326 ppi, камера 8 мп, видео 1920 x 1080 30fps, встроенная память 61440 мб, 3g, wi-fi, стерео bluetooth, gps, 1420 мач li-ion, белый, черный <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">715&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">6 184 750&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2252)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
</div>
<div class="itemRows">
<div class="leftItem"><div class="itemBlockSmall">
<h3><a href="/24/1269/" title="Apple iPhone 5 16Gb">Apple iPhone 5 16Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 5 16Gb" href="/24/1269/"><img alt="Apple iPhone 5 16Gb" src="/pics/items/ico_apple_iphone_5.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки. apple ios, экран 4" ips (640x1136), процессор 1000 мгц (2 ядр.), память 16 гб, аккумулятор 1440 мач <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">750&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">6 487 500&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2513)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
<div class="rightItem"><div class="itemBlockSmall">
<h3><a href="/24/1270/" title="Apple iPhone 5 32Gb">Apple iPhone 5 32Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 5 32Gb" href="/24/1270/"><img alt="Apple iPhone 5 32Gb" src="/pics/items/ico_apple_iphone_51.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки. apple ios, экран 4" ips (640x1136), процессор 1000 мгц (2 ядр.), память 32 гб, аккумулятор 1440 мач <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">885&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">7 655 250&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2514)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
</div>
<div class="itemRows">
<div class="leftItem"><div class="itemBlockSmall">
<h3><a href="/24/1271/" title="Apple iPhone 5 64Gb">Apple iPhone 5 64Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 5 64Gb" href="/24/1271/"><img alt="Apple iPhone 5 64Gb" src="/pics/items/ico_apple_iphone_52.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки. apple ios, экран 4" ips (640x1136), процессор 1000 мгц (2 ядр.), память 64 гб, аккумулятор 1440 мач <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">965&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">8 347 250&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2515)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
<div class="rightItem"><div class="itemBlockSmall">
<h3><a href="/996/" title="Apple iPhone 4 32Gb">Apple iPhone 4 32Gb</a></h3>
<div class="itemBlockCont">
<div class="iconItem"><a title="Apple iPhone 4 32Gb" href="/996/"><img alt="Apple iPhone 4 32Gb" src="/pics/items/Apple%20iPhone%204%2032Gb_icon.jpg"></a></div>
<div class="desc">14 дней на проверку телефона. доставка в пределах г.минска бесплатно. подарки . Трубка, 115 x 58.5 x 9.5 мм, 140 г, ios 5.0, емкостной экран ips 16 млн. цветов, 640x960, 3.5 дюйм, 326 ppi, камера 8 мп, видео 1920 x 1080 30fps, встроенная память 32768 мб, 3g, wi-fi, стерео bluetooth, gps, 1420 мач li-ion, белый, черный, <br><br>
</div>
<div class="itemPrice"><table class="priceTable" cellpadding="0" cellspacing="0"><tbody><tr>
<td>
<span class="firstPrice">570&nbsp;$</span><span class="divider"><img src="/pics/blank.gif" alt=""></span><span class="secondPrice">4 930 500&nbsp;руб.</span>
</td>
<td><div class="buttons"><a class="buyButton" title="Купить" href="javascript:add_item(2249)"><img src="/pics/blank.gif" alt=""></a></div></td>
</tr></tbody></table></div>
</div>
</div></div>
</div>
<div class="sortRazbItems"><div class="sortingBlock">
<select name="sort" class="sortsel" id="optd" onchange="_chaction()"><option value="?no&amp;page_id=1&amp;page_size=20">Без сортировки</option>
<option value="?sort=name--text&amp;page_id=1&amp;page_size=20">по названию</option>
<option value="?sort=price--number&amp;page_id=1&amp;page_size=20">по цене</option></select><span class="pageSize">
							Показывать по:
								<select name="page" class="viewCount" id="oppg2" onchange="_chactionpg2()"><option value="?page_size=10
			&amp;page_id=1">10 товаров
									</option></select></span>
</div></div>
-->