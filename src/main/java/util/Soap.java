package util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import javax.xml.namespace.QName;
import javax.xml.soap.MessageFactory;
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

public class Soap {

	/**
	 * @param args
	 * @throws SOAPException 
	 * @throws IOException 
	 */
	
	private static String getXmlFromSOAPMessage(SOAPMessage msg) throws SOAPException, IOException {
        ByteArrayOutputStream byteArrayOS = new ByteArrayOutputStream();
        msg.writeTo(byteArrayOS);
        return new String(byteArrayOS.toByteArray());
    }
	
	public static void main(String[] args) throws SOAPException, IOException {
		SOAPMessage message = MessageFactory.newInstance().createMessage();
		SOAPHeader header = message.getSOAPHeader();
		header.detachNode();
		
		SOAPEnvelope envelope = message.getSOAPPart().getEnvelope();
		envelope.setAttribute("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance");
		envelope.setAttribute("xmlns:xsd","http://www.w3.org/2001/XMLSchema");
		envelope.setAttribute("xmlns:soap","http://schemas.xmlsoap.org/soap/envelope/");
		
		SOAPBody body = message.getSOAPBody();
		//body.setAttribute("xmlns", "http://www.nbrb.by/");
		QName bodyName = new QName("http://www.nbrb.by/","ExRatesDaily");
		SOAPBodyElement bodyElement = body.addBodyElement(bodyName);
		SOAPElement symbol = bodyElement.addChildElement("onDate");
		symbol.addTextNode(DateTime.now().toString());
		
		
		SOAPConnection connection = SOAPConnectionFactory.newInstance().createConnection();
		SOAPMessage response = connection.call(message, "http://www.nbrb.by/Services/ExRates.asmx");
		connection.close();
		//message.writeTo(System.out);
		
		SOAPBody responseBody = response.getSOAPBody();
		SOAPBodyElement responseElement = (SOAPBodyElement)responseBody.getChildElements().next();
		SOAPElement returnElement = (SOAPElement)responseElement.getChildElements().next();
		if(responseBody.getFault() != null) { //-- If response has any fault.
		    System.out.println(returnElement.getValue()+" "+responseBody.getFault().getFaultString());
		}  else  {
		    System.out.println(returnElement.getValue());
		}
		
		//System.out.println(getXmlFromSOAPMessage(message));
		System.out.println(getXmlFromSOAPMessage(response));
		Iterator it=returnElement.getAllAttributesAsQNames();
		while (it.hasNext())
		System.out.print(it.next());
		
		//System.out.println(DateTime.now());

	}

}
