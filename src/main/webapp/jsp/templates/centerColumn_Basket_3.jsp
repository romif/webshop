<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="util.sql.*"%>
<%
User user=MainServlet.loggedUsers.get(request.getSession().getId());

if (request.getParameter("sessionId")!=null)  
	user=MainServlet.loggedUsers.get(request.getParameter("sessionId"));
System.out.println(request.getParameter("sessionId"));
%>
<!--

//-->
</script>

 <script language="JavaScript" src="/js/basket.js"></script>

  <ul id="sectionsTree">
    <li class="firstSectionTree">
      <a href="/index">Главная</a>&#160;»&#160;
    </li>

    <li>Корзина</li>
  </ul>
  
  <h2>Корзина: 
    <span class="counter">шаг<b>3</b>(из <b><static name="number_of_steps">5</static></b>)</span>
  </h2>
  <!-- 
  <div class="additionalContent">
  <%if ((user!=null)&&(!user.getItems().isEmpty())){%> 
  
    <form name="shcart" method="get" action="/index" id="shcart">
      <input type="hidden" name="basket">
      <input type="hidden" name="step" value="3">
      <div id="shcartCurrency">
        <select size="1" name="currency_id" onchange="select_currency(document.shcart.currency_id.value);">
          <option class="currency" value="1000196">
            $
          </option>

          <option class="currency" value="1000198">
            руб.
          </option>

          <option class="currency" value="1000197">
            €
          </option>

          <option class="currency" value="1000199">
            р.руб.
          </option>
        </select>
      </div>

      
      <script language="JavaScript">
      var delivery=1000195;
      
      function select_currency(value){


    		switch (value) {
    			
    			
    			case '1000196':
    				{
    				cur_koef = 1;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "$";
    				}
    				break;
    			
    			
    			case '1000198': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "руб.";
    				}
    				break;
    			
    			
    			case '1000197': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                    <%=MainServlet.Currencies.get("EUR")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "€";
    				}
    				break;
    			
    			
    			case '1000199': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                    <%=MainServlet.Currencies.get("RUB")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "р.руб.";
    				}
    				break;
    			
    			default : {
    				cur_koef = 1;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "$";
    				}
    		}	
    		
    		
    		shcart_step1();
    		
    		count_all(0);
    		
    		
    		return (true);
    	}
      
      
      <%
      Set<Phone>set=user.getItems().keySet();
      Iterator<Phone> it=set.iterator();
      Phone[] phones=new Phone[set.size()];
      int i=0;
      while (it.hasNext()){
    	  phones[i]=it.next();
    	  i++;
      }
      %>
      
      <%for (Phone phone:phones){%>
    	  var koef_<%=phone.getId()%>=1;  
      <%}%>
      

      
      function shcart_step1() {
          
    	  <%for (Phone phone:phones){%>
          var itemPrice_<%=phone.getId()%> = 
        	  normalizePrice(Math.round(<%=phone.getPriceUSD()%>*cur_koef / cur_round) * cur_round);
          document.getElementById('_t_price_<%=phone.getId()%>').innerHTML=itemPrice_<%=phone.getId()%>;
          
          itemPrice_summ_<%=phone.getId()%> = 
        	  normalizePrice(itemPrice_<%=phone.getId()%> * document.shcart.item_<%=phone.getId()%>.value);
          document.getElementById('_t_summ_<%=phone.getId()%>').innerHTML = itemPrice_summ_<%=phone.getId()%>; 
          
          <%}%>
          
          
          
          //document.shcart._t_summ_step1.value=shcart_summ1;
          
          shcart_summ1=0;
          <%for (Phone phone:phones){%>
          shcart_summ1+=itemPrice_summ_<%=phone.getId()%>*koef_<%=phone.getId()%>;
          <%}%>
          
          document.getElementById('_t_summ_step1').innerHTML=shcart_summ1;
          
          <%if (request.getParameter("post")!=null) {%>
          shcart_summ2 = 
        	  normalizePrice(Math.round(<%=Tarifikator.getTarif(user)%>*cur_koef / cur_round) * cur_round);
          document.shcart._t_bring_1000196.value=shcart_summ2;
          <%}%>
          return true;
          
      }

      
      
      
      function count_all(id){
    	 
    	  
    	  
    		main_summ1=Number(shcart_summ1)+Number(shcart_summ2)+Number(shcart_summ3);
    		//if (!document.shcart._t_summ_main_i) {return false;}
    		//document.shcart._t_summ_main_i.value=main_summ1;
    		document.getElementById('_t_summ_main_i').innerHTML=main_summ1;
    		if (id==1){
    			<%for (Phone phone:phones){%> 
    			document.shcart.item_<%=phone.getId()%>.disabled="disabled";
    			<%}%>
    			document.shcart._t_bring_1000195.disabled="disabled";
    			document.shcart._t_bring_1000196.disabled="disabled";
    			document.shcart.submit();
    			return true;
    		} else {
    			return false;
    		}
    	}
      
      function placeOrder(){
    	  var delivery='';
    	  if (QueryString.courier!=null)delivery='courier';
    	  else if (QueryString.post!=null)delivery='post';
    	  else history.back();
    	  var d={
    			  'placeOrder':'',
    			  'delivery': delivery,
    			  'comment': document.shcart.comment.value
    	  };  
             	  
          $.post('/index', d,
         		 function(data) {
       					if (data==0) {
       						alert('Ошибка! Невозможно отправить заказ. Попробуйте еще раз');
       					} else if (data==1) {
       						alert('Заказ отправлен. В ближайшее время мы с вами свяжемся');
       						
       					}
       					document.location='/index';
       			});
      }
                            
      </script>


      <table class="tshcartFirst" cellspacing="0" cellpadding="0" width="100%">
        <tbody>
          <tr>
            <td colspan="6" class="tovar">
              <table cellspacing="0" cellpadding="0" width="100%" height="18">
                <tbody>
                  <tr class="shcartHeadTable">
                    <td class="shcartHeaderLeft"></td>

                    <td class="shcartHeaderTitle">Товары</td>

                    <td class="shcartHeaderRight"></td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>

          <tr>
            <td colspan="6">
              <div class="shcartBanners">
                <br>

              </div>
            </td>
          </tr>

          <tr>
            <td class="theadName">Наименование</td>

            <td class="thead">Цена</td>

            <td class="thead">Кол-во</td>

            <td class="thead">Сумма</td>

            <td class="hiddenc"></td>
          </tr>
          
          
          <%for (Phone phone:phones){%>

          <tr id="<%=phone.getId()%>">
            <td class="itemname">
              <a href="/index?phoneID=<%=phone.getId()%>"><%=phone.getTitle()%></a>
            </td>

            <td class="price">
            <div class="price_value" id="_t_price_<%=phone.getId()%>"/> 
            </td>

            <td class="quantyval">
            <input type="text" class="quantity_value spinbox-active" 
            name="item_<%=phone.getId()%>" value="<%=user.getItems().get(phone)%>" />
            </td>

            <td class="priceval">
            <div class="price_value"  
            id="_t_summ_<%=phone.getId()%>"/>
            </td>

          </tr>
          
          <%}%>
          

          <tr>
            <td colspan="3"></td>
          </tr>

          <tr class="resultsum">
            <td class="s_result_price">Итого:</td>

            <td colspan="4" id="summ_step1" class="shcart_itogo_value">
            <div id="_t_summ_step1" class="price_valueBlue"/></td>
          </tr>
        
        </tbody>
      </table>
      
      <table class="tshcart" width="100%" cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
            <td colspan="3" class="tovar">
              <table cellspacing="0" cellpadding="0" width="100%" height="37">
                <tbody>
                  <tr>
                    <td class="shcartHeaderLeft"></td>
                    <td class="shcartHeaderTitle">Способ доставки</td>
                    <td class="shcartHeaderRight"></td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>

          <tr>
            <td colspan="3" height="5">
              <div class="shcartBanners">
                <br>
              </div>
            </td>
          </tr>

          <tr>
            <td class="bringName">Наименование</td>

            <td class="thead">Цена</td>
          </tr>
          
          
          <%if (request.getParameter("courier")!=null) {%>
          <tr>
            <td class="tdesc">Доставка товара курьером. Расчет с курьером наличными</td>

            <td class="priceval"><input type="text" readonly class="price_value" name="_t_bring_1000195" value="0.00"></td>
          </tr>
          <%} else          
          if (request.getParameter("post")!=null) {%>
          <tr>
            <td class="tdesc">Доставка товара почтовой посылкой. 
            Оплата в почтовом отделении наложеным платежом</td>

            <td class="priceval"><input type="text" readonly class="price_value" name="_t_bring_1000196" value="0"></td>
          </tr>
          <%}
          else {%>
          <script>javascript:history.back();</script>
          <%}%>
          
        </tbody>
      </table>
      

      <table class="blueSumm" cellpadding="0" cellspacing="0" width="100%">
        <tbody>
          <tr>
            <td class="s_result_priceWhite">Итого:</td>

            <td class="priceval">
            <div class="price_valueWhite" id="_t_summ_main_i"/>
            </td>
          </tr>
        </tbody>
      </table>
      
      <table class="tshcart" width="100%" cellspacing="0" cellpadding="0">
        <tbody>       
          <tr>
            <td colspan="3" class="tovar">
              <table cellspacing="0" cellpadding="0" width="100%" height="37">
                <tbody>
                  <tr>

                    <td class="shcartHeaderTitle">Добавить комментарий</td>

                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3" height="5">
              <div class="shcartBanners">
                <br>
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <textarea id="comment" name="comment" style="width: 434px; height: 146px"></textarea>
            </td>
          </tr>
        </tbody>
      </table>
      

      <table cellpadding="0" cellspacing="10" width="100%">
        <tbody>
          <tr>
            <td width="33%"></td>

            <td align="center">
              <input type="submit" class="hiddenc" name="backsh" id="backbut" alt="вернуться в магазин »"
              onclick="document.location.href='/index'; return false;">
              <a id="back" class="backshopBut" href="/index">
              <img src="/pics/blank.gif" width="123" height="18" alt="Назад в магазин"/></a>
            </td>

            <td>
              <a class="backBut" href="javascript:history.back();">
              <img src="/pics/blank.gif" width="54" height="18" alt="Назад"/></a>
            </td>


            <td>
              <input type="submit" class="hiddenc" name="next" alt="отправить заказ »" id="nextbut" 
              onclick="placeOrder();return false;">
              <a id="next" class="nextBut" onclick="javascript:document.getElementById('nextbut').click();return false;" 
              href="javascript:click()">
              <img src="/pics/blank.gif" width="54" height="18" border="0" alt="Отправить заказ"/></a>
            </td>

            <td width="33%"></td>
          </tr>
        </tbody>
      </table>
    </form>
    
    
    <script>
    for(var i=0;i<document.shcart.currency_id.options.length;i++){
        if (document.shcart.currency_id.options[i].value == QueryString.currency_id) {
        	document.shcart.currency_id.selectedIndex = i;
            break;
        }
    }
    select_currency(QueryString.currency_id);
    //select_currency(document.shcart.currency_id.value);
    </script>
    
    
    <%}else {%>
   <div class="noCompare">Извините, Ваша корзина пуста. Предварительно закажите какой-либо товар.</div>
    <%}%>
    
  </div>
   -->
  
  <div class="additionalContent" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
  <%if ((user!=null)&&(!user.getItems().isEmpty())){%> 
  
    <form name="shcart" method="get" action="/index" id="shcart">
      <input type="hidden" name="basket">
      <input type="hidden" name="step" value="3">
      <div id="shcartCurrency" style="font: 100% Arial, Helvetica, sans-serif;color: #1CA21F;font-size: 11px;text-align: right;">
        <select size="1" name="currency_id" onchange="select_currency(document.shcart.currency_id.value);" style="border: 1px solid #ccc;font-size: 11px;">
          <option class="currency" value="1000196">
            $
          </option>

          <option class="currency" value="1000198">
            руб.
          </option>

          <option class="currency" value="1000197">
            €
          </option>

          <option class="currency" value="1000199">
            р.руб.
          </option>
        </select>
      </div>

      
      <script language="JavaScript">
      var delivery=1000195;
      
      function select_currency(value){


    		switch (value) {
    			
    			
    			case '1000196':
    				{
    				cur_koef = 1;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "$";
    				}
    				break;
    			
    			
    			case '1000198': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "руб.";
    				}
    				break;
    			
    			
    			case '1000197': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                    <%=MainServlet.Currencies.get("EUR")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "€";
    				}
    				break;
    			
    			
    			case '1000199': 
    				{
    				cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                    <%=MainServlet.Currencies.get("RUB")%>;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "р.руб.";
    				}
    				break;
    			
    			default : {
    				cur_koef = 1;
                    cur_round = 1.00;
    				cur_id = value;
    				cur_suffix = "$";
    				}
    		}	
    		
    		
    		shcart_step1();
    		
    		count_all(0);
    		
    		
    		return (true);
    	}
      
      
      <%
      Set<Phone>set=user.getItems().keySet();
      Iterator<Phone> it=set.iterator();
      Phone[] phones=new Phone[set.size()];
      int i=0;
      while (it.hasNext()){
    	  phones[i]=it.next();
    	  i++;
      }
      %>
      
      <%for (Phone phone:phones){%>
    	  var koef_<%=phone.getId()%>=1;  
      <%}%>
      

      
      function shcart_step1() {
          
    	  <%for (Phone phone:phones){%>
          var itemPrice_<%=phone.getId()%> = 
        	  normalizePrice(Math.round(<%=phone.getPriceUSD()%>*cur_koef / cur_round) * cur_round);
          document.getElementById("_t_price_<%=phone.getId()%>").innerHTML=itemPrice_<%=phone.getId()%>;
          
          itemPrice_summ_<%=phone.getId()%> = 
        	  normalizePrice(itemPrice_<%=phone.getId()%> * document.shcart.item_<%=phone.getId()%>.value);
          document.getElementById("_t_summ_<%=phone.getId()%>").innerHTML = itemPrice_summ_<%=phone.getId()%>; 
          
          <%}%>
          
          
          
          //document.shcart._t_summ_step1.value=shcart_summ1;
          
          shcart_summ1=0;
          <%for (Phone phone:phones){%>
          shcart_summ1+=itemPrice_summ_<%=phone.getId()%>*koef_<%=phone.getId()%>;
          <%}%>
          
          document.getElementById('_t_summ_step1').innerHTML=shcart_summ1;
          
          <%if (request.getParameter("post")!=null) {%>
          shcart_summ2 = 
        	  normalizePrice(Math.round(<%=Tarifikator.getTarif(user)%>*cur_koef / cur_round) * cur_round);
          document.shcart._t_bring_1000196.value=shcart_summ2;
          <%}%>
          return true;
          
      }

      
      
      
      function count_all(id){
    	 
    	  
    	  
    		main_summ1=Number(shcart_summ1)+Number(shcart_summ2)+Number(shcart_summ3);
    		//if (!document.shcart._t_summ_main_i) {return false;}
    		//document.shcart._t_summ_main_i.value=main_summ1;
    		document.getElementById('_t_summ_main_i').innerHTML=main_summ1;
    		if (id==1){
    			<%for (Phone phone:phones){%> 
    			document.shcart.item_<%=phone.getId()%>.disabled="disabled";
    			<%}%>
    			document.shcart._t_bring_1000195.disabled="disabled";
    			document.shcart._t_bring_1000196.disabled="disabled";
    			document.shcart.submit();
    			return true;
    		} else {
    			return false;
    		}
    	}
      
      function placeOrder(){
    	  var delivery='';
    	  if (QueryString.courier!=null)delivery='courier';
    	  else if (QueryString.post!=null)delivery='post';
    	  else history.back();
    	  var d={
    			  'placeOrder':'',
    			  'delivery': delivery,
    			  'comment': document.shcart.comment.value
    	  };  
             	  
          $.post('/index', d,
         		 function(data) {
       					if (data==0) {
       						alert('Ошибка! Невозможно отправить заказ. Попробуйте еще раз');
       					} else if (data==1) {
       						alert('Заказ отправлен. В ближайшее время мы с вами свяжемся');
       						
       					}
       					document.location='/index';
       			});
      }
                            
      </script>


      <table class="tshcartFirst" cellspacing="0" cellpadding="0" width="100%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
        <tbody>
          <tr style="background: #ffffff;">
            <td colspan="6" class="tovar" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;">
              <table cellspacing="0" cellpadding="0" width="100%" height="18" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
                <tbody>
                  <tr class="shcartHeadTable" style="background: #769eb3;">
                    <td class="shcartHeaderLeft" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>

                    <td class="shcartHeaderTitle" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;">Товары</td>

                    <td class="shcartHeaderRight" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>

          <tr style="background: #ffffff;">
            <td colspan="6" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <div class="shcartBanners" style="font: 100% Arial, Helvetica, sans-serif;color: #666;font-size: 11px;">
                <br>
                <!--shcart_step1_text-->
              </div>
            </td>
          </tr>

          <tr style="background: #ffffff;">
            <td class="theadName" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;">Наименование</td>

            <td class="thead" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;">Цена</td>

            <td class="thead" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;">Кол-во</td>

            <td class="thead" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;">Сумма</td>

            <td class="hiddenc" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
          </tr>
          
          
          <%for (Phone phone:phones){%>

          <tr id="<%=phone.getId()%>" style="background: #ffffff;">
            <td class="itemname" style="font: 100% Arial, Helvetica, sans-serif;color: #000;border-right: #cccccc 1px solid;border-top: #cccccc 1px solid;border-left: #cccccc 1px solid;">
              <a href="/index?phoneID=<%=phone.getId()%>" style="font: 100% Arial, Helvetica, sans-serif;color: #7db82b;text-decoration: underline;font-weight: bold;font-size: 11px;"><%=phone.getTitle()%></a>
            </td>

            <td class="price" style="font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;">
            <div class="price_value" id="_t_price_<%=phone.getId()%>" style="font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;"></div> 
            </td>

            <td class="quantyval" style="font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;">
            <input type="text" class="quantity_value spinbox-active" name="item_<%=phone.getId()%>" value="<%=user.getItems().get(phone)%>" style="border: 1px #ccafbe solid;background: none;font-size: 11px;text-align: center;color: #333;">
            </td>

            <td class="priceval" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;">
            <div class="price_value" id="_t_summ_<%=phone.getId()%>" style="font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;"></div>
            </td>

          </tr>
          
          <%}%>
          

          <tr style="background: #ffffff;">
            <td colspan="3" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
          </tr>

          <tr class="resultsum" style="background: #ffffff;">
            <td class="s_result_price" style="font: 100% Arial, Helvetica, sans-serif;color: #000;font-size: 11px;font-weight: bold;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;border: #cccccc 1px solid;">Итого:</td>

            <td colspan="4" id="summ_step1" class="shcart_itogo_value" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;">
            <div id="_t_summ_step1" class="price_valueBlue" style="font: 100% Arial, Helvetica, sans-serif;color: #1CA21F;border: none;background: none;font-size: 11px;text-align: center;"></div></td>
          </tr>
        
        </tbody>
      </table>
      
      <table class="tshcart" width="100%" cellspacing="0" cellpadding="0" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
        <tbody>
          <tr>
            <td colspan="3" class="tovar" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;">
              <table cellspacing="0" cellpadding="0" width="100%" height="37" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
                <tbody>
                  <tr>
                    <td class="shcartHeaderLeft" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
                    <td class="shcartHeaderTitle" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;">Способ доставки</td>
                    <td class="shcartHeaderRight" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>

          <tr>
            <td colspan="3" height="5" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <div class="shcartBanners" style="font: 100% Arial, Helvetica, sans-serif;color: #666;font-size: 11px;">
                <br>
              </div>
            </td>
          </tr>

          <tr>
            <td class="bringName" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;">Наименование</td>

            <td class="thead" style="font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;">Цена</td>
          </tr>
          
          
          <%if (request.getParameter("courier")!=null) {%>
          <tr>
            <td class="tdesc" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;">Доставка товара курьером. Расчет с курьером наличными</td>

            <td class="priceval" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;"><input type="text" readonly class="price_value" name="_t_bring_1000195" value="0.00" style="border: none;background: none;font-size: 11px;text-align: center;color: #333;"></td>
          </tr>
          <%} else          
          if (request.getParameter("post")!=null) {%>
          <tr>
            <td class="tdesc" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;">Доставка товара почтовой посылкой. 
            Оплата в почтовом отделении наложеным платежом</td>

            <td class="priceval" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;"><input type="text" readonly class="price_value" name="_t_bring_1000196" value="0" style="border: none;background: none;font-size: 11px;text-align: center;color: #333;"></td>
          </tr>
          <%}
          else {%>
          <script>javascript:history.back();</script>
          <%}%>
          
        </tbody>
      </table>
      

      <table class="blueSumm" cellpadding="0" cellspacing="0" width="100%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;background: #c1d7e2;">
        <tbody>
          <tr>
            <td class="s_result_priceWhite" style="font: 100% Arial, Helvetica, sans-serif;color: #000000;font-size: 11px;font-weight: bold;">Итого:</td>

            <td class="priceval" style="font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;border: none;">
            <div class="price_valueWhite" id="_t_summ_main_i" style="font: 100% Arial, Helvetica, sans-serif;color: #000000;border: none;background: none;font-weight: bold;font-size: 11px;text-align: center;"></div>
            </td>
          </tr>
        </tbody>
      </table>
      
      <table class="tshcart" width="100%" cellspacing="0" cellpadding="0" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
        <tbody>       
          <tr>
            <td colspan="3" class="tovar" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;">
              <table cellspacing="0" cellpadding="0" width="100%" height="37" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
                <tbody>
                  <tr>

                    <td class="shcartHeaderTitle" style="font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;">Добавить комментарий</td>

                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3" height="5" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <div class="shcartBanners" style="font: 100% Arial, Helvetica, sans-serif;color: #666;font-size: 11px;">
                <br>
              </div>
            </td>
          </tr>
          <tr>
            <td style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <textarea id="comment" name="comment" style="width: 434px; height: 146px"></textarea>
            </td>
          </tr>
        </tbody>
      </table>
      

      <table cellpadding="0" cellspacing="10" width="100%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
        <tbody>
          <tr>
            <td width="33%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>

            <td align="center" style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <input type="submit" class="hiddenc" name="backsh" id="backbut" alt="вернуться в магазин »" onclick="document.location.href='/index'; return false;">
              <a id="back" class="backshopBut" href="/index" style="font: 100% Arial, Helvetica, sans-serif;color: #0072BC;text-decoration: none;">
              <img src="/pics/blank.gif" width="123" height="18" alt="Назад в магазин" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></a>
            </td>

            <td style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <a class="backBut" href="javascript:history.back();" style="font: 100% Arial, Helvetica, sans-serif;color: #0072BC;text-decoration: none;">
              <img src="/pics/blank.gif" width="54" height="18" alt="Назад" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></a>
            </td>


            <td style="font: 100% Arial, Helvetica, sans-serif;color: #000;">
              <input type="submit" class="hiddenc" name="next" alt="отправить заказ »" id="nextbut" onclick="placeOrder();return false;">
              <a id="next" class="nextBut" onclick="javascript:document.getElementById('nextbut').click();return false;" href="javascript:click()" style="font: 100% Arial, Helvetica, sans-serif;color: #0072BC;text-decoration: none;">
              <img src="/pics/blank.gif" width="54" height="18" border="0" alt="Отправить заказ" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></a>
            </td>

            <td width="33%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;"></td>
          </tr>
        </tbody>
      </table>
    </form>
    
    
    <script>
    for(var i=0;i<document.shcart.currency_id.options.length;i++){ if (document.shcart.currency_id.options[i].value="=" querystring.currency_id) { document.shcart.currency_id.selectedindex="i;" break; } select_currency(querystring.currency_id);></document.shcart.currency_id.options.length;i++){>/select_currency(document.shcart.currency_id.value);
    </script>
    
    
    <%}else {%>
   <div class="noCompare" style="font: 100% Arial, Helvetica, sans-serif;color: #7db82b;font-weight: bold;text-align: center;">Извините, Ваша корзина пуста. Предварительно закажите какой-либо товар.</div>
    <%}%>
    
  </div>


   