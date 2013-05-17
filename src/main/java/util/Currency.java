package util;

import javax.xml.namespace.QName;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.Node;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPBodyElement;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPHeader;
import javax.xml.soap.SOAPMessage;

import org.joda.time.DateTime;
import org.w3c.dom.Element;

import servlet.MainServlet;

public class Currency implements Runnable {

	public Currency() {
	}

	@Override
	public void run() {
		try {
			while (true){
				SOAPMessage message;
				message = MessageFactory.newInstance().createMessage();
				SOAPHeader header = message.getSOAPHeader();
				header.detachNode();
				
				SOAPEnvelope envelope = message.getSOAPPart().getEnvelope();
				envelope.setAttribute("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance");
				envelope.setAttribute("xmlns:xsd","http://www.w3.org/2001/XMLSchema");
				envelope.setAttribute("xmlns:soap","http://schemas.xmlsoap.org/soap/envelope/");
				SOAPBody body = message.getSOAPBody();
				QName bodyName = new QName("http://www.nbrb.by/","ExRatesDaily");
				SOAPBodyElement bodyElement = body.addBodyElement(bodyName);
				SOAPElement symbol = bodyElement.addChildElement("onDate");
				symbol.addTextNode(DateTime.now().toString());
				SOAPConnection connection = SOAPConnectionFactory.newInstance().createConnection();
				SOAPMessage response = connection.call(message, "http://www.nbrb.by/Services/ExRates.asmx");
				connection.close();
				
				SOAPBody responseBody = response.getSOAPBody();
				SOAPBodyElement responseElement = (SOAPBodyElement)responseBody.getChildElements().next();
				SOAPElement returnElement = (SOAPElement)responseElement.getChildElements().next();
				if(responseBody.getFault() != null) { //-- If response has any fault.
				    System.out.println(returnElement.getValue()+" "+responseBody.getFault().getFaultString());
				}  else  {
					for (int i=0;i<responseBody.getElementsByTagName("DailyExRatesOnDate").getLength();i++){
						String Cur_Abbreviation=((Node) ((Element) responseBody.getElementsByTagName("DailyExRatesOnDate").item(i)).
								getElementsByTagName("Cur_Abbreviation").item(0)).getValue();
						Float Cur_OfficialRate=Float.parseFloat(((Node) ((Element) responseBody.getElementsByTagName("DailyExRatesOnDate").item(i)).
								getElementsByTagName("Cur_OfficialRate").item(0)).getValue());
						
						if (Cur_Abbreviation.equals("USD")||Cur_Abbreviation.equals("EUR")||Cur_Abbreviation.equals("RUB")){
							MainServlet.Currencies.put(Cur_Abbreviation, Cur_OfficialRate);
						}
					}
					System.out.println(MainServlet.Currencies);
				}
				Thread.sleep(8640000);
			}
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		new Currency().run();
	}

}
