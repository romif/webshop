<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="util.sql.*"%>


  <ul id="sectionsTree">
    <li class="firstSectionTree">
      <a href="/">Главная</a>B۠
    </li>

    <li>Корзина</li>
  </ul>
  
  <h2>Корзина: 
    <span class="counter">шаг<b>1</b>(из <b><static name="number_of_steps">5</static></b>)</span>
  </h2>
  
  <div class="additionalContent">
    <form name="shcart" method="get" action="/shcart/" id="shcart">
      <input type="hidden" name="url" value="/"><input type="hidden" name="step" value="2"><input type="hidden" name="nstep" value=
      "3"><input type="hidden" name="action" value="submit">

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
                                  var koef_2935=1;
                                
                                        var koef_2937=1;
                                

                                function prepare_shcart_step1() {
                                del_item ();
                                }
                                                
                                function shcart_step1() {
                                        
                                        
                                                var itemPrice_2935 = normalizePrice(Math.round(284*cur_koef / cur_round) * cur_round);
                                                document.shcart._t_price_2935.value=itemPrice_2935;
                                                
                                                itemPrice_summ_2935 = normalizePrice(itemPrice_2935 * document.shcart.item_2935.value);
                                                document.shcart._t_summ_2935.value = itemPrice_summ_2935; 
                                        
                                                var itemPrice_2937 = normalizePrice(Math.round(245.00*cur_koef / cur_round) * cur_round);
                                                document.shcart._t_price_2937.value=itemPrice_2937;
                                                
                                                itemPrice_summ_2937 = normalizePrice(itemPrice_2937 * document.shcart.item_2937.value);
                                                document.shcart._t_summ_2937.value = itemPrice_summ_2937; 
                                        
                                        check_wait ();
                                        
                                        
                                        del_item ();
                                        
                                        
                                        shcart_summ1 = normalizePrice(0+itemPrice_summ_2935*koef_2935+itemPrice_summ_2937*koef_2937)
                                
                                        
                                        document.shcart._t_summ_step1.value=shcart_summ1;
                                        
                                        return true;
                                }
                                
                                function check_wait () {
                                        
                                                if (document.shcart.wait_2935.checked)
                                                {
                                                        koef_2935=0;
                                                }
                                                else
                                                {
                                                        koef_2935=1;
                                                }
                                        
                                                if (document.shcart.wait_2937.checked)
                                                {
                                                        koef_2937=0;
                                                }
                                                else
                                                {
                                                        koef_2937=1;
                                                }
                                        
                                        
                                        return true;
                                }
                                
                                function del_item () {
                                        del_url = "";
                                        
                                                if (document.shcart.del_2935.checked || document.shcart.item_2935.value == 0){
                                                        document.getElementById(2935).style.display='none';
                                                        koef_2935=0;
                                                        del_url += '&del_2935=on';
                                                        if (document.shcart.item_2935.value == 0)
                                                        {
                                                        document.shcart.del_2935.checked=true;
                                                        }
                                                }
                                        
                                                if (document.shcart.del_2937.checked || document.shcart.item_2937.value == 0){
                                                        document.getElementById(2937).style.display='none';
                                                        koef_2937=0;
                                                        del_url += '&del_2937=on';
                                                        if (document.shcart.item_2937.value == 0)
                                                        {
                                                        document.shcart.del_2937.checked=true;
                                                        }
                                                }
                                        

                                        if (del_url != "")
                                        {
                                                document.getElementById("myframe4del").src = "/shcart/?step=1&mode=hidden" + del_url;
                                        }
                                        
                                        return true;
                                }
      </script>
      
      <script language="JavaScript" src="/lib/js/jquery-1.3.2.js"></script>
      
      <script language="JavaScript" src="/lib/js/spinbox/jquery.spinbox.js"></script>
      
      
      <link rel="stylesheet" type="text/css" href="/lib/js/spinbox/jquery.spinbox.css">

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

          <tr id="2935">
            <td class="itemname">
              <a href="/1476/">Nokia Lumia 620</a>
            </td>

            <td class="price"><input type="edit" class="price_value" readonly name="_t_price_2935" value="284"></td>

            <td class="quantyval"><input type="edit" class="quantity_value spinbox-active" name="item_2935" value="1"></td>

            <td class="priceval"><input type="edit" class="price_value" readonly name="_t_summ_2935" value="1"></td>

            <td align="center" class="centercol"><input type="checkbox" class="del_checkbox" name="del_2935"></td>

            <td align="center" class="hiddenc" id="wait_id_2935"><input type="checkbox" class="del_checkbox" name="wait_2935"></td>
          </tr>

          <tr id="2937">
            <td class="itemname">
              <a href="/1478/">Samsung Galaxy Ace 2 La FLeur (I8160)</a>
            </td>

            <td class="price"><input type="edit" class="price_value" readonly name="_t_price_2937" value="245.00"></td>

            <td class="quantyval"><input type="edit" class="quantity_value spinbox-active" name="item_2937" value="1"></td>

            <td class="priceval"><input type="edit" class="price_value" readonly name="_t_summ_2937" value="1"></td>

            <td align="center" class="centercol"><input type="checkbox" class="del_checkbox" name="del_2937"></td>

            <td align="center" class="hiddenc" id="wait_id_2937"><input type="checkbox" class="del_checkbox" name="wait_2937"></td>
          </tr>

          <tr>
            <td colspan="3"></td>
          </tr>

          <tr class="resultsum">
            <td class="s_result_price">Итого:</td>

            <td colspan="4" id="summ_step1" class="shcart_itogo_value"><input size="5" name="_t_summ_step1" value="0" readonly
            class="price_valueBlue"></td>
          </tr>
        </tbody>
      </table>
      
      <script language="JavaScript">$(".quantity_value").spinbox();</script>

      <table class="blueSumm" cellpadding="0" cellspacing="0" width="100%">
        <tbody>
          <tr>
            <td class="s_result_priceWhite">Итого:</td>

            <td class="priceval"><input type="text" class="price_valueWhite" size="5" value="0" name="_t_summ_main_i" readonly
            ></td>
          </tr>
        </tbody>
      </table>

      <table cellpadding="0" cellspacing="10" width="100%">
        <tbody>
          <tr>
            <td width="33%"></td>

            <td align="center">
              <input type="submit" class="hiddenc" name="backsh" id="backbut" alt="вернуться в магазин »"
              onclick="document.location.href=&#39;/&#39;; return false;"><a id="back" class="backshopBut" href="/"><img src=
              "/pics/blank.gif" width="123" height="18" alt="Назад в магазин"></a>
            </td>

            <td>
              <a class="backBut" href="javascript:history.back();"><img src="/pics/blank.gif" width="54" height="18" alt=
              "Назад"></a>
            </td>

            <td>
              <input type="submit" name="recalc" alt="пересчитать »" onclick=
              "select_currency(document.shcart.currency_id.value);return false;" class="hiddenc" id="recalcbut"><a id="recalc"
              class="recalcBut" onclick="javascript:document.getElementById(&#39;recalcbut&#39;).click();return false" href=
              "javascript:click()"><img src="/pics/blank.gif" width="97" height="18" alt="Пересчитать"></a>
            </td>

            <td>
              <input type="submit" class="hiddenc" name="next" alt="далее »" id="nextbut" onclick=
              "nextBtnClick();return false;"><a id="next" class="nextBut" onclick=
              "javascript:document.getElementById(&#39;nextbut&#39;).click();return false;" href="javascript:click()"><img src=
              "/pics/blank.gif" width="54" height="18" border="0" alt="Далее"></a>
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
    
  </div>