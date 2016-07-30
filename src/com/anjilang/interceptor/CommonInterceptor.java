package com.anjilang.interceptor;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	/** 日志 */
	private static Logger LOGGER = Logger.getLogger(CommonInterceptor.class);
	private static final String LOGMODUAL = "拦截器";
	/** uri中包含此内容不受拦截 */
	private static final String[] URI_CONTAINS = { "/test/" };

	/** uri中以如下内容结尾不受拦截 */
	private static final String[] URI_ENDSWITH = { "/test/test.do" };

	/**
	 * 
	 * @Title: notIntercept
	 * @Description: 如果uri无需被拦截器处理则返回true,否则返回false
	 * @param uri
	 * @return
	 * 
	 * @since 1.0
	 */
	private boolean notIntercept(String uri) {
		// 如果URI包含其中的一个内容则认为不需要拦截
		for (String contains : URI_CONTAINS) {
			if (uri.contains(contains)) {
				return true;
			}
		}
		// 如果uri以数组结尾则认为不需要拦截
		for (String endswith : URI_ENDSWITH) {
			if (uri.endsWith(endswith)) {
				return true;
			}
		}
		return false;
	}

	/** 前置处理：参数封装，鉴权 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		String logFlag = UUID.randomUUID().toString();
		request.setAttribute("logFlag", logFlag);
		String uri = request.getRequestURI();
		LOGGER.info(logFlag + " " + uri);
		// 判断该URI是否需要拦截,如果不需要则跳过后续处理
		if (notIntercept(uri)) {
			return true;
		}
		// TODO XXX
		return true;
	}

	/**
	 * 发送返回数据
	 * 
	 * @param code
	 *            返回码
	 * @param message
	 *            返回信息
	 * @param data
	 *            返回json数据
	 * @param response
	 *            servlet响应
	 */
	private void sendBackPacketError(HttpServletResponse response, String logFlag) {
		try {
			response.getOutputStream().write("错误报文".getBytes("UTF-8"));
		} catch (IOException e) {
			LOGGER.error(e.toString(), e);
		}
	}
}
