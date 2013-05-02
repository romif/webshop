<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>

<%
List<Phone> phones=SqlManager.GetPhones("Apple");
%>

    <div style="width:1010px;height:1px;">  
    </div>

    <h2>Поиск товара</h2>

    <div id="si0" class="adSearchHeader" onclick="shSB(0)">
      <div class="adSearchHeaderRight">
        <div id="" class="adSearchHeaderContent">
          Поиск по названию и описанию
        </div>
      </div>
    </div>

    <div class="searchbody" id="sb0" style="display:block">
      <form method="get" action="/find/" id="f0" name="f0">
        <div class="fcatalogBox">
          <table class="fcatalog" cellspacing="0" cellpadding="0">
            <tbody>
              <tr>
                <td class="in">Найти:</td>

                <td class="inpSearch"><input type="text" name="findtext" id="findtext2" value="(480x800),"></td>
              </tr>

              <tr>
                <td class="in">Цена($):</td>

                <td class="inpSearch"><input type="hidden" id="main_course" value="8650"><input type="hidden" id="course" value=
                "8650"><label>от<input type="text" id="price_before_new" name="price_before_new" class="fprice" maxlength="9"
                max-size="9" value=""></label><label>до<input type="text" id="price_after_new" name="price_after_new" class=
                "fprice" maxlengthh="9" max-size="9" value=""></label></td>
              </tr>

              <tr>
                <td class="in">&quot;Не отображать товары,<br>
                которых нет на складе&quot;</td>

                <td class="inpSearch"><input type="checkbox" name="item_status" style="width:15px; text-align:left;" value=
                "0"></td>
              </tr>

              <tr>
                <td></td>

                <td>
                  <input type="submit" name="search" onclick="find_form(0);" class="hiddenc" id="fbuttbut"><a class="fbutt" id=
                  "fbutt" onclick="javascript:document.getElementById(&#39;fbuttbut&#39;).click();return false" href=
                  "javascript:click()"></a>
                </td>
              </tr>
            </tbody>
          </table>

          <table class="fcatalog" cellspacing="0" align="left" style="display:none;">
            <tbody>
              <tr>
                <td class="in">Цена($):</td>

                <td class="inpSearch"><label>от<input type="text" id="price_before" class="fprice" name=
                "price_before"></label><label>до<input type="text" id="price_after" class="fprice" name=
                "price_after"></label></td>
              </tr>
            </tbody>
          </table>
        </div>
      </form>
    </div>

    <div class="sortRazbItems">
      <div class="findButton">
        <table cellspacing="0" cellpadding="0" width="100%" id="navig_line">
          <tbody>
            <tr>
              <td width="50%">Найдено:<span class="bold"><%=phones.size()%></span></td>

              <td>
                <div class="sort">
                  <span>Сортировка:</span><select name="sort" class="sortsel" id="optd" onchange="_chaction()">
                    <option value=
                    "?no&amp;page_id=1&amp;page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=Отправить&amp;price_before=&amp;price_after=">
                    Без сортировки
                    </option>

                    <option value=
                    "?sort=price--number&amp;page_id=1&amp;page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=Отправить&amp;price_before=&amp;price_after=">
                    Начать с дешевых
                    </option>

                    <option value=
                    "?sort=price--number--desc&amp;page_id=1&amp;page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=Отправить&amp;price_before=&amp;price_after=">
                    Начать с дорогих
                    </option>

                    <option value=
                    "?sort=name--text&amp;page_id=1&amp;page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=Отправить&amp;price_before=&amp;price_after=">
                    Название А-Я
                    </option>

                    <option value=
                    "?sort=name--text--desc&amp;page_id=1&amp;page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=Отправить&amp;price_before=&amp;price_after=">
                    Название Я-А
                    </option>
                  </select>
                </div>
              </td>
            </tr>

            <tr>
              <td>Показано: с <span class="bold">1</span> по <span class="bold">20</span> <span class=
              "num_pag">отображать по: <select name="page" id="oppg" onchange="_chactionpg()">
                <option value=
                "?page_size=10 &amp;page_id=1 &amp;findtext=(480x800), &amp;price_before_new= &amp;price_after_new= &amp;search=Отправить &amp;price_before= &amp;price_after=">
                10
                </option>

                <option value=
                "?page_size=20 &amp;page_id=1 &amp;findtext=(480x800), &amp;price_before_new= &amp;price_after_new= &amp;search=Отправить &amp;price_before= &amp;price_after="
                selected>
                  20
                </option>

                <option value=
                "?page_size=50 &amp;page_id=1 &amp;findtext=(480x800), &amp;price_before_new= &amp;price_after_new= &amp;search=Отправить &amp;price_before= &amp;price_after=">
                50
                </option>
              </select></span></td>

              <td>
                <ul class="sortingBlockRight">
                  <li id="first" class="razbAct"><span class="razbActText">1</span></li>

                  <li>
                    <a href=
                    "?%20page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=%C3%90%C2%9E%C3%91%C2%82%C3%90%C2%BF%C3%91%C2%80%C3%90%C2%B0%C3%90%C2%B2%C3%90%C2%B8%C3%91%C2%82%C3%91%C2%8C&amp;price_before=&amp;price_after=%20&amp;page_id=2">
                    2</a>
                  </li>

                  <li>
                    <a href=
                    "?%20page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=%C3%90%C2%9E%C3%91%C2%82%C3%90%C2%BF%C3%91%C2%80%C3%90%C2%B0%C3%90%C2%B2%C3%90%C2%B8%C3%91%C2%82%C3%91%C2%8C&amp;price_before=&amp;price_after=%20&amp;page_id=3">
                    3</a>
                  </li>

                  <li>
                    <a href=
                    "?%20page_size=20&amp;findtext=(480x800),&amp;price_before_new=&amp;price_after_new=&amp;search=%C3%90%C2%9E%C3%91%C2%82%C3%90%C2%BF%C3%91%C2%80%C3%90%C2%B0%C3%90%C2%B2%C3%90%C2%B8%C3%91%C2%82%C3%91%C2%8C&amp;price_before=&amp;price_after=%20&amp;page_id=4">
                    4</a>
                  </li>
                </ul>
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
			<h3><a href="/index?phone=<%=((Phone)phones.get(i*2)).getId()%>" title="<%=((Phone)phones.get(i*2)).getTitle()%>"><%=((Phone)phones.get(i*2)).getTitle()%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i*2)).getTitle()%>" href="/index?phoneID=<%=((Phone)phones.get(i*2)).getId()%>">
						<img alt="<%=((Phone)phones.get(i*2)).getTitle()%>" src="http://tomcat7-romif.rhcloud.com/picture?pic=<%=((Phone)phones.get(i*2)).getId()%>">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i*2)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i*2)).getFirstPrice()%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i*2)).getSecondPrice()%>&nbsp;руб.</span>
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
			<h3><a href="/index?phone=<%=((Phone)phones.get(i*2+1)).getId()%>" 
			title="<%=((Phone)phones.get(i*2+1)).getTitle()%>"><%=((Phone)phones.get(i*2+1)).getTitle()%></a></h3>
			<div class="itemBlockCont">
				<div class="iconItem">
					<a title="<%=((Phone)phones.get(i*2+1)).getTitle()%>" href="/index?phoneID=<%=((Phone)phones.get(i*2+1)).getId()%>">
						<img alt="<%=((Phone)phones.get(i*2+1)).getTitle()%>" src="http://tomcat7-romif.rhcloud.com/picture?pic=<%=((Phone)phones.get(i*2+1)).getId()%>">
					</a>
				</div>
				<div class="desc"><%=((Phone)phones.get(i*2+1)).getDescription()%><br><br>
				</div>
				<div class="itemPrice">
					<table class="priceTable" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<span class="firstPrice"><%=((Phone)phones.get(i*2+1)).getFirstPrice()%>&nbsp;$</span>
									<span class="divider"><img src="/pics/blank.gif" alt=""></span>
									<span class="secondPrice"><%=((Phone)phones.get(i*2+1)).getSecondPrice()%>&nbsp;руб.</span>
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