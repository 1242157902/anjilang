package com.anjilang.util;

import java.io.IOException;
import java.util.Random;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * 
 * <p>Title：        SendMessage<p>
 * <p>Description:  发送短信验证码<p>
 * @date:           2015年8月6日下午1:39:23
 * @author:         ysl
 * @version         1.0
 */
public class SendMessage {
	
	private static String Url = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";
	/**
	 * @return:      String 
	 * @param Mobile
	 * @param Content
	 * @param send_time
	 * <p>Description: 0:提交失败，2提交成功<p>
	 * @date:          2015年8月6日下午1:40:47
	 * @author         ysl
	 */
	public String sendSMS(String mobile,String mobile_code) 
	{
		HttpClient client = new HttpClient(); 
		PostMethod method = new PostMethod(Url); 
			
		//client.getParams().setContentCharset("GBK");		
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=UTF-8");

		
		//int mobile_code = (int)((Math.random()*9+1)*100000);

		//System.out.println(mobile);
		
	    String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。"); 

		NameValuePair[] data = {//提交短信
			    new NameValuePair("account", "cf_lonelyskybird"), 
			    new NameValuePair("password", "teshijie123"), //密码可以使用明文密码或使用32位MD5加密
			    //new NameValuePair("password", util.StringUtil.MD5Encode("密码")),
			    new NameValuePair("mobile",  mobile), 
			    new NameValuePair("content", content),
		};
		
		method.setRequestBody(data);		
		
		
		try {
			client.executeMethod(method);	
			
			String SubmitResult =method.getResponseBodyAsString();
					
			//System.out.println(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult); 
			Element root = doc.getRootElement();


			String code = root.elementText("code");	
			//String msg = root.elementText("msg");	
			//String smsid = root.elementText("smsid");	
			//System.out.println("---------------------------->"+code);
			return code;
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}	
		return "0";
		
	}
	
	
	/*获得4位随机数*/
	public String random(int n) {
        if (n < 1 || n > 10) {
            throw new IllegalArgumentException("cannot random " + n + " bit number");
        }
        Random ran = new Random();
        if (n == 1) {
            return String.valueOf(ran.nextInt(10));
        }
        int bitField = 0;
        char[] chs = new char[n];
        for (int i = 0; i < n; i++) {
            while(true) {
                int k = ran.nextInt(10);
                if( (bitField & (1 << k)) == 0) {
                    bitField |= 1 << k;
                    chs[i] = (char)(k + '0');
                    break;
                }
            }
        }
        return new String(chs);
    }
}
