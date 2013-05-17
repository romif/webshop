<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.User"%>
<%@ page import="servlet.MainServlet"%>

<%User user=MainServlet.loggedUsers.get(request.getSession().getId());%>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="/css/color.css" rel="stylesheet" type="text/css">
  <link href="/css/main.css" rel="stylesheet" type="text/css">
  <link href="/css/ie.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
      var dom;
        var ns4;
        var ie4;
        var BV;
        var OP;
        var IE;
        dom = (document.getElementById)? true : false;
        ns4 = (document.layers)? true : false;

        IE=(navigator.userAgent.indexOf('MSIE')!=-1)?true:false;
        if (OP) {IE=true;}
        function check_layer(){
                
                        if (!IE){
                                //close();
                        }else {
                        //      parent.tocart(1,1);
                        }
                        
  }
  </script>

  <title></title>
</head>

<body id="shcart_win" onload="check_layer();select_currencym(document.shcart.currency_id.value);">
  <script type="text/javascript">
var cur_koef=1;
  var cur_round=1;
  var local_sum=0 +<%if (user!=null)out.print(user.getItemsPrice());else out.print(0);%>;

  local_sum = bugPrice(local_sum);
  if (document.getElementById('currency_id2') !== null) { 
                var actsuf = document.getElementById('currency_id2').options[document.getElementById('currency_id2').selectedIndex].text;
        }



  /* Устранение бага с большим числом символов после перемножения вещественных чисел */
  function bugPrice (price) {
        var bugPrice = price.toString();
        var normalPrice;

        if (bugPrice.indexOf(".") == -1)
        {
                normalPrice = bugPrice;
        }
        else
        {
                normalPrice = bugPrice.substring(0, bugPrice.indexOf(".")+3);
        }

        return normalPrice;
  }
  /* ------------------------------------------------------------------------------- */

  function go_shcart(){
                parent.document.location.href='/shcart/?step=2&nstep=2&currency_id='+document.getElementById('currency_id2').value+'&url='+escape(parent.document.location.href);
  }

  function select_currencym(value_1){
        var val = document.getElementById('currency_id2').value;
        document.getElementById('currency_id').value = val;
                var local_sum=bugPrice(0+<%if (user!=null)out.print(user.getItemsPrice());else out.print(0);%>*1);

        switch (value_1) {
                
                case '1000196': 
                        {
                        cur_koef = 1;
                        cur_round = 1.00;
                        }
                        break;
                
                case '1000198': 
                        {
                        cur_koef = <%=MainServlet.Currencies.get("USD")%>;
                        cur_round = 1.00;
                        }
                        break;
                
                case '1000197': 
                        {
                        cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                        <%=MainServlet.Currencies.get("EUR")%>;
                        cur_round = 1.00;
                        }
                        break;
                
                case '1000199': 
                        {
                        cur_koef = <%=MainServlet.Currencies.get("USD")%> / 
                        <%=MainServlet.Currencies.get("RUB")%>;
                        cur_round = 1.00;
                        }
                        break;
                
                default : {
                        
                }
        }       
        
        document.getElementById("pricecont").innerHTML=bugPrice(Math.round(local_sum*cur_koef / cur_round) * cur_round);

        if (document.getElementById("pricecontdis"))
        {
                document.getElementById('pricecontdis').value= bugPrice((Math.round(discount_sum*cur_koef / cur_round)) * cur_round);
        }
  }
  </script>

  <form name="shcart" method="post" action="/shcart/" id="shcart">
    <p class="wins">Товаров:<span class="znach">
    <%if (user!=null)out.print(user.getItemsCount());else out.print(0);%>
    </span></p>

    <p class="wins">Сумма:<span class="znach" id="pricecont"></span></p>

    <p class="wins">валюта: 
      <select class="selval" id="currency_id2" name="currency_id" 
    	      onchange="select_currencym(document.getElementById('currency_id2').value);">
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
    
    <input type="hidden" name="step" value="2">
      <input type="hidden" name="nstep" value="2">
    	<input type="hidden" id="currency_id" name="currency_id" value="1000196">
    </p>
    
    <%if ((user!=null)&&(user.getItemsCount()!=0)){ %>
    <p class="wins">
      <a href="javascript:go_shcart()" class="boform">Оформить заказ</a>
    </p>
    <%}%>
  </form>
  
  <script type="text/javascript">
  select_currencym(document.getElementById('currency_id2').value);
  </script>
  
</body>
</html>
