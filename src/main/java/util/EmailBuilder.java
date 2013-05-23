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
	
	
	private static String OrderBuilder(HttpServletRequest request){
		String st=
	  "<table cellspacing='0' cellpadding='0' width='100%' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
        "<tbody>" +
          "<tr style='background: #ffffff;'>" +
            "<td colspan='6' class='tovar' style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;'>" +
              "<table cellspacing='0' cellpadding='0' width='100%' height='18' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                "<tbody>" +
                  "<tr class='shcartHeadTable' style='background: #769eb3;'>" +
                    "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'></td>" +
                    "<td style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;'>Товары</td>" +
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
	    int sum=0;
	    while (it.hasNext()){
	    	Phone phone=it.next();
	    	st+=
	      "<tr style='background: #ffffff;'>" +
            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-right: #cccccc 1px solid;border-top: #cccccc 1px solid;border-left: #cccccc 1px solid;'>" +
              "<a href='http://tomcat7-romif.rhcloud.com/index?phoneID="+phone.getId()+"' style='font: 100% Arial, Helvetica, sans-serif;color: #7db82b;text-decoration: underline;font-weight: bold;font-size: 11px;'>" +phone.getTitle()+"</a>" +
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;'>"+phone.getPriceUSD()+"</div>" + 
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;'>" +user.getItems().get(phone)+"</div>" +
            "</td>" +

            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #333;border: none;background: none;font-size: 11px;text-align: center;'>"+phone.getPriceUSD()*user.getItems().get(phone)+"</div>" +
            "</td>" +

          "</tr>";
	    	sum+=phone.getPriceUSD()*user.getItems().get(phone);
	    };
	    
	    st+=
          "<tr style='background: #ffffff;'>" +
            "<td colspan='3' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +"</td>" +
          "</tr>" +

          "<tr style='background: #ffffff;'>" +
            "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;font-size: 11px;font-weight: bold;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;border: #cccccc 1px solid;'>Итого:</td>" +

            "<td colspan='4' id='summ_step1' class='shcart_itogo_value' style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;border-top: #cccccc 1px solid;border-left: none;border-bottom: #cccccc 1px solid;border-right: #cccccc 1px solid;'>" +
            "<div style='font: 100% Arial, Helvetica, sans-serif;color: #1CA21F;border: none;background: none;font-size: 11px;text-align: center;'>" +sum+"</div>" +
            "</td>" +
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
              
              float deliveryCost=0;
              if (request.getParameter("delivery")!=null) {
            	  if (request.getParameter("delivery").equals("courier")){
            		  deliveryCost=0;
            	  st+=
              "<tr>" +
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;'>Доставка товара курьером. Расчет с курьером наличными</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;'>" +
                "<div style='border: none;background: none;font-size: 11px;text-align: center;color: #333;'>" +deliveryCost+ "</div>" +
                "</td>" +
              "</tr>";
            	  } else          
            		  if (request.getParameter("delivery").equals("post")) {
            			 deliveryCost=Math.round(Tarifikator.getTarif(user));
            	  st+=
              "<tr>" +
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: center;font-size: 11px;'>Доставка товара почтовой посылкой." +
                "Оплата в почтовом отделении наложеным платежом</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;'>" +
                "<div style='border: none;background: none;font-size: 11px;text-align: center;color: #333;'>" +deliveryCost+ "</div>" +
                "</td>" +
              "</tr>";
            		  }
              }
              st+=
            "</tbody>" +
          "</table>";      
            
          st+=
      "<table cellpadding='0' cellspacing='0' width='100%' style='font: 100% Arial, Helvetica, sans-serif;color: #000;background: #c1d7e2;'>" +
            "<tbody>" +
              "<tr>" +
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000000;font-size: 11px;font-weight: bold;'>Итого:</td>" +

                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;text-align: right;border: none;'>" +
                "<div style='font: 100% Arial, Helvetica, sans-serif;color: #000000;border: none;background: none;font-weight: bold;font-size: 11px;text-align: center;'>" +(sum+deliveryCost)+"</div>" +
                "</td>" +
              "</tr>" +
            "</tbody>" +
          "</table>" +
          
          "<table width='100%' cellspacing='0' cellpadding='0' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
            "<tbody>" +       
              "<tr>" +
                "<td colspan='3' class='tovar' style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;background: #769eb3;font-size: 12px;font-weight: bold;'>" +
                  "<table cellspacing='0' cellpadding='0' width='100%' height='37' style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                    "<tbody>" +
                      "<tr>" +

                        "<td style='font: 100% Arial, Helvetica, sans-serif;color: #ffffff;font-size: 12px;font-weight: bold;'>Комментарий</td>" +

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
                "<td style='font: 100% Arial, Helvetica, sans-serif;color: #000;'>" +
                  "<div style='width: 434px; height: 146px'>" +request.getParameter("comment")+ "</div>" +
                "</td>" +
              "</tr>" +
            "</tbody>" +
          "</table>";
		
		return st;
	}
	
	public static String UserOrderBuilder (HttpServletRequest request){
		String st=
				"<div>Вы получили это письмо, потому что сделали заказ на сайте tomcat7-romif</div>";
		st+=OrderBuilder(request);
		return st;
	}
	
	public static String AdminOrderBuilder (HttpServletRequest request){
		String st=
				"<div>Заказ от "+MainServlet.loggedUsers.get(request.getSession().getId()).getE_mail()+
				"</div>";
		st+=OrderBuilder(request);
		return st;
	}
	
	
	
	public static void main(String[] args){
		//System.out.print(EmailBuilder.OrderBuilder('EU1xDaJ9oTXfiFM+S5-UulSL.undefined'));

		
	}

}
