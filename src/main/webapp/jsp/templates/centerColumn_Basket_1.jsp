<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="util.sql.*"%>
<%
User user=MainServlet.loggedUsers.get(request.getSession().getId());

user=SqlManager.GetUser("admin", "qqqq");
user.addItem("474");user.addItem("474");
user.addItem("477");
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
    <span class="counter">шаг<b>1</b>(из <b><static name="number_of_steps">5</static></b>)</span>
  </h2>
  
  <div class="additionalContent">
  <%if (user!=null){%> 
  
    <form name="shcart" method="get" action="/index" id="shcart">
      <input type="hidden" name="step" value="2">
      <div id="shcartCurrency">
        <select size="1" name="currency_id" onchange="select_currency(document.shcart.currency_id.value);">
          <option class="currency" value="1000196">
            $
          </option>

          <option class="currency" value="1000198">
            руб.
          </option>

          <option class="currency" value="1000197">
            E
          </option>

          <option class="currency" value="1000199">
            р.руб.
          </option>
        </select>
      </div>
     
      <iframe id="myframe4del" style="position: absolute; left: -10000px; top: -10000px;" name=
      "myframe4del"></iframe>
      
      <script language="JavaScript">
      
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
    				cur_suffix = "E";
    				
    				
    				
    				
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
    				trace_log ();
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
      
      function prepare_shcart_step1() {
    	  del_item ();
    	  }
      
      function shcart_step1() {
          
    	  <%for (Phone phone:phones){%>
          var itemPrice_<%=phone.getId()%> = normalizePrice(Math.round(<%=phone.getPriceUSD()%>*cur_koef / cur_round) * cur_round);
          /*document.shcart._t_price_<%=phone.getId()%>.value=itemPrice_<%=phone.getId()%>;*/
          document.getElementById('_t_price_<%=phone.getId()%>').innerHTML=itemPrice_<%=phone.getId()%>;
          
          itemPrice_summ_<%=phone.getId()%> = normalizePrice(itemPrice_<%=phone.getId()%> * document.getElementById('item_<%=phone.getId()%>').innerHTML);
          document.getElementById('_t_summ_<%=phone.getId()%>').innerHTML = itemPrice_summ_<%=phone.getId()%>; 
          
          <%}%>
          
          check_wait ();
          
          
          del_item ();
          
          shcart_summ1=0;
          <%for (Phone phone:phones){%>
          shcart_summ1+=itemPrice_summ_<%=phone.getId()%>*koef_<%=phone.getId()%>;
          <%}%>

          
          var d={'updateItems':''};  
          <%for (Phone phone:phones){%>
          d.phoneId_<%=phone.getId()%>=document.getElementById('item_<%=phone.getId()%>').innerHTML;
          <%}%>
             	  
          $.post('/index', d,
         		 function(data) {
       					if (data==0) alert('Ошибка! Невозможно пересчитать заказ');
       			}); 
          
          
          //document.shcart._t_summ_step1.value=shcart_summ1;
          document.getElementById('_t_summ_step1').innerHTML=shcart_summ1;
          
          return true;
          
      }
      
      function check_wait () {
          
    	  <%for (Phone phone:phones){%>
          if (document.shcart.wait_<%=phone.getId()%>.checked)
          {
                  koef_<%=phone.getId()%>=0;
          }
          else
          {
                  koef_<%=phone.getId()%>=1;
          }
          
          <%}%>
          
          return true;
      }
      
      function del_item () {
          del_url = "";
          
          		  <%for (Phone phone:phones){%>         
                  if (document.shcart.del_<%=phone.getId()%>.checked ||
                		  document.getElementById('item_<%=phone.getId()%>').innerHTML == 0){
                        document.getElementById(<%=phone.getId()%>).style.display='none';
                        koef_<%=phone.getId()%>=0;
                        del_url += '&del_<%=phone.getId()%>=on';
                        if (document.getElementById('item_<%=phone.getId()%>').innerHTML == 0)
                        {
                        document.shcart.del_<%=phone.getId()%>.checked=true;
                        }
                  }
                  <%}%>
                  
                  
            	  
             
                  


          if (del_url != "")
          {
        	  
        	  
                 // document.getElementById("myframe4del").src = "/shcart/?step=1&mode=hidden" + del_url;
          }
          
          return true;
    }
                            
      </script>
      
      <script language="JavaScript" src="/js/jquery-1.3.2.js"></script>
      
      <script language="JavaScript" src="/js/jquery.spinbox.js"></script>
      
      
      <link rel="stylesheet" type="text/css" href="/css/jquery.spinbox.css"/>

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
                <!--shcart_step1_text-->
              </div>
            </td>
          </tr>

          <tr>
            <td class="theadName">Наименование</td>

            <td class="thead">Цена</td>

            <td class="thead">Кол-во</td>

            <td class="thead">Сумма</td>

            <td class="thead">Удалить</td>

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
            <div class="quantity_value spinbox-active" 
            id="item_<%=phone.getId()%>" ><%=user.getItems().get(phone)%></div>
            </td>

            <td class="priceval">
            <div class="price_value"  
            id="_t_summ_<%=phone.getId()%>"/>
            </td>

            <td align="center" class="centercol">
            <input type="checkbox" class="del_checkbox" 
            name="del_<%=phone.getId()%>"></td>

            <td align="center" class="hiddenc" id="wait_id_<%=phone.getId()%>">
            <input type="checkbox" class="del_checkbox" name="wait_<%=phone.getId()%>"></td>
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
      
      <script language="JavaScript">$(".quantity_value").spinbox();</script>

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
              <input type="submit" name="recalc" alt="пересчитать »" 
              onclick="select_currency(document.shcart.currency_id.value);return false;" 
              class="hiddenc" id="recalcbut">
              <a id="recalc" class="recalcBut" onclick="javascript:document.getElementById('recalcbut').click();return false" 
              href="javascript:click()">
              <img src="/pics/blank.gif" width="97" height="18" alt="Пересчитать"/></a>
            </td>

            <td>
              <input type="submit" class="hiddenc" name="next" alt="далее »" id="nextbut" 
              onclick="nextBtnClick();return false;">
              <a id="next" class="nextBut" onclick="javascript:document.getElementById('nextbut').click();return false;" 
              href="javascript:click()">
              <img src="/pics/blank.gif" width="54" height="18" border="0" alt="Далее"/></a>
            </td>

            <td width="33%"></td>
          </tr>
        </tbody>
      </table>
    </form>
    <script>select_currency(document.shcart.currency_id.value);</script>
    
    <script language="JavaScript">
        var pay_message = document.getElementById('paymsg');
            if(pay_message){
            document.getElementById('paymsg').style.display=submitepay_visible;
            }
    </script>
    
    <script>
    if (typeof show_payments !== 'undefined' & document.getElementById('payments')!=null) {
        document.getElementById('payments').style.display = show_payments;
        }                                                           
    </script>
    
    <%}else {%>
   <div class="noCompare">Извините, Ваша корзина пуста. Предварительно закажите какой-либо товар.</div>
    <%}%>
    
  </div>
  
   