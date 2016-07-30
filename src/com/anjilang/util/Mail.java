package com.anjilang.util;

/**
 * ClassName: Mail 
 * @Description: 发送邮件
 * @author linqingsong
 * @date 2015年1月19日
 */
import java.util.Calendar;  
import java.util.Properties;  
  
import javax.mail.Authenticator;  
import javax.mail.MessagingException;  
import javax.mail.PasswordAuthentication;  
import javax.mail.Session;  
import javax.mail.Transport;  
import javax.mail.Message.RecipientType;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage;  
  
public class Mail {  
	private static String smtpHost="smtp.qq.com";
	private static String from="center@angelaround.com";
	private static String fromUserPassword="anjilang2014";
	private static String messageType="text/html;charset=gb2312";
	
    public static void sendMessage(String to, String subject,  
            String messageText) throws MessagingException {  
        // 第一步：配置javax.mail.Session对象  
        System.out.println("为" + smtpHost + "配置mail session对象");  
          
          
        Properties props = new Properties();  
        props.put("mail.smtp.host", smtpHost);  
        props.put("mail.smtp.starttls.enable","true");//使用 STARTTLS安全连接  
        //props.put("mail.smtp.port", "25");             //google使用465或587端口  
        props.put("mail.smtp.auth", "true");        // 使用验证  
        //props.put("mail.debug", "true");  
        Session mailSession = Session.getInstance(props,new MyAuthenticator(from,fromUserPassword));  
  
        // 第二步：编写消息  
        System.out.println("编写消息from——to:" + from + "——" + to);  
  
        InternetAddress fromAddress = new InternetAddress(from);  
        InternetAddress toAddress = new InternetAddress(to);  
  
        MimeMessage message = new MimeMessage(mailSession);  
  
        message.setFrom(fromAddress);  
        message.addRecipient(RecipientType.TO, toAddress);  
  
        message.setSentDate(Calendar.getInstance().getTime());  
        message.setSubject(subject);  
        message.setContent(messageText, messageType);  
  
        // 第三步：发送消息  
        Transport transport = mailSession.getTransport("smtp");  
        transport.connect(smtpHost,"chaofeng19861126", fromUserPassword);  
        transport.send(message, message.getRecipients(RecipientType.TO));  
        System.out.println("message yes");  
    }  
  
    public static void main(String[] args) {  
        try {  
        	Mail.sendMessage("lin_qs357357@sina.com", "111TTTTTTT",  
                    "---------------wrwe-----------");  
        } catch (MessagingException e) {  
            e.printStackTrace();  
        }  
    }  
}  
class MyAuthenticator extends Authenticator{  
    String userName="";  
    String password="";  
    public MyAuthenticator(){  
          
    }  
    public MyAuthenticator(String userName,String password){  
        this.userName=userName;  
        this.password=password;  
    }  
     protected PasswordAuthentication getPasswordAuthentication(){     
        return new PasswordAuthentication(userName, password);     
     }   
}