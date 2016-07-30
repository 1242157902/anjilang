package com.anjilang.util;

import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 异常类
 * 
 * @author xym
 * 
 */
public class AjlException extends Exception {
	private static Logger log = Logger.getLogger(AjlException.class);
	private static final String ISO_8859_1 = "ISO-8859-1";
	private static final String UTF_8 = "UTF-8";

	/**
	 * 
	 */
	private static final long serialVersionUID = 8149279196909104645L;
	private String code;
	private String msg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	// 操作异常配置文件------------------- -------------------------
	/** 属性集 */
	private static Properties props = null;

	/** 构造私有 "property.properties" */
	private static void init() {
		if (props == null) {
			try {
				props = new Properties();
				InputStream in = AjlException.class.getClassLoader()
						.getResourceAsStream("err.properties");
				props.load(in);
			} catch (Exception e) {
				log.error("读取配置文件异常", e);
			}
		}
	}

	public AjlException(String code, String errMsg) {
		this.code = code;
		this.msg = errMsg;
	}

	/**
	 * 获取字符串对应值
	 * 
	 * @throws IOException
	 */
	public static AjlException createErr(String code) {
		// 取出相关值
		try {
			init();
			String errMsg = props.getProperty(code);
			errMsg = new String(errMsg.getBytes(ISO_8859_1), UTF_8);
			return new AjlException(code, errMsg);
		} catch (Exception e) {
			log.error("读取配置文件属性异常", e);
			return new AjlException("5000", "未知异常");
		}
	}

	@Override
	public String toString() {
		return "AjlException [code=" + code + ", msg=" + msg + "]";
	}
	
	
	
}
