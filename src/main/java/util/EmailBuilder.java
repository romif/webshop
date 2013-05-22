package util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import servlet.MainServlet;

import com.google.common.base.CharMatcher;

public class EmailBuilder {

	private EmailBuilder() {
		// TODO Auto-generated constructor stub
	}
	
	
	public static String OrderBuilder(HttpServletRequest request){
		String st=
	  "<table cellspacing='0' cellpadding='0' width='100%' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
        "<tbody>" +
          "<tr style='background: #ffffff;'>" +
            "<td colspan='6' class='tovar' style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;'>" +
              "<table cellspacing='0' cellpadding='0' width='100%' height='18' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                "<tbody>" +
                  "<tr class='shcartHeadTable' style='background: #769eb3;'>" +
                    "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'></td>" +

                    "<td style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;'>Товары /td>" +

                    "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'></td>" +
                  "</tr>" +
                "</tbody>" +
              "</table>" +
            "</td>" +
          "</tr>" +

          "<tr style='background: #ffffff;'>" +
            "<td colspan='6' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
              "<div style='font: 100% Arial, Helvetica, sans-serif;color: #666;font-size: 11px;'>" +
                "<br>" +
              "</div>" +
            "</td>" +
          "</tr>" +

          "<tr style='background: #ffffff;'>" +
            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;'>Наименование</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;'>Цена</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;'>Кол-во</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;'>Сумма</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'></td>" +
          "</tr>";
		User user=MainServlet.loggedUsers.get(request.getSession().getId());  
		Set<Phone>set=user.getItems().keySet();
	    Iterator<Phone> it=set.iterator();
	    while (it.hasNext()){
	    	Phone phone=it.next();
	    	st+=
	      "<tr style='background: #ffffff;'>" +
            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-right: #cccccc 1px solid;border-top: #cccccc 1px solid;border-left: #cccccc 1px solid;'>" +
              "<a href='/index?phoneID="+phone.getId()+"' style='font: 100% Arial, Helvetica, sans-serif;color: #7db82b;text-decoration: underline;font-weight: bold;font-size: 11px;'>" +phone.getTitle()+"</a>" +
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;'>" +"</div>" + 
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<input type='text' value='"+user.getItems().get(phone)+"' style='border: 1px #ccafbe solid;background: none;font-size: 11px;text-align: center;color: #333;'>" +
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;'>" +"</div>" +
            "</td>" +

          "</tr>";
	    };
	    
	    st+=
          "<tr style='background: #ffffff;'>" +
            "<td colspan='3' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +"</td>" +
          "</tr>" +

          "<tr style='background: #ffffff;'>" +
            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;font-size: 11px;font-weight: bold;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;border: #cccccc 1px solid;'>Итого:</td>" +

            "<td colspan='4' id='summ_step1' class='shcart_itogo_value' style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #1CA21F;border: none;background: none;font-size: 11px;text-align: center;'>" +"</div>" +"</td>" +
          "</tr>" +
        
        "</tbody>" +
      "</table>"+

          "<table width='100%' cellspacing='0' cellpadding='0' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
            "<tbody>" +
              "<tr>" +
                "<td colspan='3' class='tovar' style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;'>" +
                  "<table cellspacing='0' cellpadding='0' width='100%' height='37' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                    "<tbody>" +
                      "<tr>" +
                        "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +"</td>" +
                        "<td style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;'>Способ доставки</td>" +
                        "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +"</td>" +
                      "</tr>" +
                    "</tbody>" +
                  "</table>" +
                "</td>" +
              "</tr>" +

              "<tr>" +
                "<td colspan='3' height='5' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                  "<div style='font: 100% Arial, Helvetica, sans-serif;color: #666;font-size: 11px;'>" +
                    "<br>" +
                  "</div>" +
                "</td>" +
              "</tr>" +

              "<tr>" +
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;'>Наименование</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #666666;background: #c1d7e2;font-size: 11px;text-align: center;'>Цена</td>" +
              "</tr>";
              
              
              if (request.getParameter("courier")!=null) {
            	  st+=
              "<tr>" +
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;'>Доставка товара курьером. Расчет с курьером наличными</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;'>" +"<input type='text' readonly class='price_value' name='_t_bring_1000195' value='0.00' style='border: none;background: none;font-size: 11px;text-align: center;color: #333;'>" +"</td>" +
              "</tr>";
              } else          
              if (request.getParameter("post")!=null) {
            	  st+=
              "<tr>" +
                "<td class='tdesc' style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;'>Доставка товара почтовой посылкой." +
                "Оплата в почтовом отделении наложеным платежом</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;'>" +
                "<input type='text' readonly class='price_value' name='_t_bring_1000196' value='0' style='border: none;background: none;font-size: 11px;text-align: center;color: #333;'>" +"</td>" +
              "</tr>";
              }
              st+=
            "</tbody>" +
          "</table>";      
            
          
      /*<table class="blueSumm" cellpadding="0" cellspacing="0" width="100%" style="font: 100% Arial, Helvetica, sans-serif;color: #000;background: #c1d7e2;">
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
          </table>*/
		
		return st;
	}
	
	public static void main(String[] args){
		//System.out.print(EmailBuilder.OrderBuilder('EU1xDaJ9oTXfiFM+S5-UulSL.undefined'));

		
	}

}
