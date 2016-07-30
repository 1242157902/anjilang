package com.anjilang.util;

import java.io.InputStream;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class Validator {
	private static Logger log = Logger.getLogger(Validator.class);
	private static final String ISO_8859_1 = "ISO-8859-1";
	private static final String UTF_8 = "UTF-8";

	
	public static void validator(String uri, JSONObject req) throws AjlException {
		JSONObject config = getConfig(uri);
		if (config == null) {
			return;
		}
		JSONArray must = config.getJSONArray("must");
		if (must != null && must.size() > 0) {
			if(req == null) {
				log.error("uri:" + uri + ".报文为null");
				throw AjlException.createErr("5001");
			}
			for (int i = 0, size = must.size(); i < size; i++) {
				String field = must.getString(i);
				String val = req.getString(field);
				if (StringUtil.isEmpty(val)) {
					log.error("uri:" + uri + ".field=" + field + "必填");
					throw AjlException.createErr("5001");
				}
			}
		}
		
		if(req == null) {
			return ;
		}
		
		Set<String> fields = config.keySet();
		fields.remove("must");
		if(fields.size() > 0) {
			Iterator<String> it = fields.iterator();
			while(it.hasNext()) {
				String field = it.next();
				String regx = config.getString(field);
				String val = req.getString(field);
				if(StringUtil.isNotEmpty(regx, val)) {
					if(!val.matches(regx)) {
						log.error("[uri=" + uri + "][field=" + field + "][val="+val+"][rule="+regx+"]校验失败");
						throw AjlException.createErr("5002");
					}
				}
			}
		}

	}
	
	public static void validator(String uri, Object obj) throws AjlException {
		JSONObject req = (JSONObject) JSONObject.toJSON(obj);
		JSONObject config = getConfig(uri);
		if (config == null) {
			return;
		}
		// 获取obj 字段与中文的映射关系
		JSONObject fileNameList = ReflectUtil.getFileName(obj, "");
		
		JSONArray must = config.getJSONArray("must");
		if (must != null && must.size() > 0) {
			if(req == null) {
				log.error("uri:" + uri + ".报文为null");
				throw AjlException.createErr("5001");
			}
			for (int i = 0, size = must.size(); i < size; i++) {
				String field = must.getString(i);
				String val = req.getString(field);
				if (StringUtil.isEmpty(val)) {
					log.error("uri:" + uri + ".field=" + field + "必填");
					AjlException ajlErr = AjlException.createErr("5001");
					if(fileNameList!=null && StringUtil.isNotEmpty(fileNameList.getString(field))) {
						ajlErr.setMsg(fileNameList.getString(field)+"必填");
					}
					
					throw ajlErr;
				}
			}
		}
		
		if(req == null) {
			return ;
		}
		
		Set<String> fields = config.keySet();
		fields.remove("must");
		if(fields.size() > 0) {
			Iterator<String> it = fields.iterator();
			while(it.hasNext()) {
				String field = it.next();
				String regx = config.getString(field);
				String val = req.getString(field);
				if(StringUtil.isNotEmpty(regx, val)) {
					if(!val.matches(regx)) {
						log.error("[uri=" + uri + "][field=" + field + "][rule="+regx+"]校验失败");
						AjlException ajlErr = AjlException.createErr("5002");
						if(fileNameList!=null && StringUtil.isNotEmpty(fileNameList.getString(field))) {
							ajlErr.setMsg(fileNameList.getString(field)+"格式错误");
						}
						
						throw ajlErr;
					}
				}
			}
		}

	}
	

	/** 属性集 */
	private static Properties props = null;

	/** 构造私有 "property.properties" */
	public static void init() {
		if (props == null) {
			try {
				props = new Properties();
				InputStream in = AjlException.class.getClassLoader()
						.getResourceAsStream("validator.properties");
				props.load(in);
			} catch (Exception e) {
				log.error("读取配置文件异常", e);
			}
		}
	}

	public static JSONObject getConfig(String uri) {
		init();
		uri = dealUri(uri);
		String configStr = props.getProperty(uri);
		try {
			if(configStr == null) {
				log.info("uri="+uri+"未配置规则");
				return null;
			}
			configStr = new String(configStr.getBytes(ISO_8859_1), UTF_8);
			return JSONObject.parseObject(configStr);
		} catch (Exception e) {
			log.error("交易配置字符串格式转换异常" + uri, e);
			return null;
		}
	}

	private static String dealUri(String uri) {
		// 去掉uri中的工程路径
		// 域名访问不带工程名时//xxx/xxx.do或者/xxx/xxx.do;带工程名/anjilang/xxx/xxx.do;
		// 将以上数据处理为:/xxx/xxx.do格式数据
		// 去掉工程名称
		uri = (StringUtil.isEmpty(uri)) ? uri : uri.replace("anjilang", "");
		// 去掉双斜线
		return (StringUtil.isEmpty(uri)) ? uri : uri.replace("//", "/");
	}
}
