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
    <span class="counter">шаг<b>3</b>(из <b><static name="number_of_steps">3</static></b>)</span>
  </h2>
  
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
    	  document.getElementById('preload').style.display='block';
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
       						hideLoading();
       						alert('Заказ отправлен. В ближайшее время мы с Вами свяжемся');
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
  
  
   