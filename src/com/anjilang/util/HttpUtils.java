package com.anjilang.util;

import java.util.Iterator;
import java.util.Map;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpConnectionManager;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpState;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;



public class HttpUtils {
	
	private static final Logger log = Logger.getLogger(HttpUtils.class);

	/**
	 * HTTP请求未能发出的情况(如网络连接等)
	 */
	static final int CODE_EXCEPTION = 600;
	
	/**
	 * 默认的http连接的超时时间.
	 */
	private static final int CONN_TIMEOUT = 20000;
	/**
	 *
	 */
	private static final int LINGER_TIME = 10000;
	
	
	private static HttpClient client;
	
	/**
	 *
	 */
	private static HttpConnectionManager httpConnMgr;
	/**
	 *
	 */
	static {
		init();
	}
	
	private static void init() {
		httpConnMgr = new MultiThreadedHttpConnectionManager();
		if (httpConnMgr != null) {
			HttpConnectionManagerParams mgrParams = buildManagerParams();
			httpConnMgr.setParams(mgrParams);
		}
		client = new HttpClient(httpConnMgr);
	}
	
	static HttpConnectionManagerParams buildManagerParams() {
		HttpConnectionManagerParams mgrParams = new HttpConnectionManagerParams();
		mgrParams.setSoTimeout(CONN_TIMEOUT);
		mgrParams.setTcpNoDelay(true);
		mgrParams.setConnectionTimeout(CONN_TIMEOUT);
		mgrParams.setLinger(LINGER_TIME);
		mgrParams.setDefaultMaxConnectionsPerHost(10);
		mgrParams.setMaxTotalConnections(15);
		return mgrParams;
	}
	
	public static Response post(String url, String formCharset,
			Map<String, String> extraHeaders, Map<String, String> postParams) {
		PostMethod method = new PostMethod(url);
		formCharset = StringUtil.isEmpty(formCharset) ? "UTF-8" : formCharset;
		method.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded; charset=" + formCharset);
		NameValuePair[] parametersBody = null;
		if (postParams != null) {
			int size = postParams.size();
			parametersBody = new NameValuePair[size];
			int i = 0;
			for (Iterator iter = postParams.keySet().iterator(); iter.hasNext(); i++) {
				String name = (String) iter.next();
				String value = postParams.get(name);
				NameValuePair valuePair = new NameValuePair();
				parametersBody[i] = valuePair;
				parametersBody[i].setName(name);
				parametersBody[i].setValue(value);
			}
			method.setRequestBody(parametersBody);
		}

		HttpState state = null;
		return getResponseInternal(url, method, extraHeaders, state);
	}
	
	/**
	 * 单线程方式发送请求, 对虚IP等情况支持较好.
	 * 
	 * @param url
	 * @param method
	 * @param headers
	 * @param state
	 * @return
	 */
	static Response getResponseInternal(String url, HttpMethod method,
			Map headers, HttpState state) {
		HttpClient httpClient = buildHttpClient();
		HttpMethodParams params = method.getParams();
		if (params != null) {
			params.setCookiePolicy(CookiePolicy.BROWSER_COMPATIBILITY);
		}

		// 大量CLOSE_WAIT连接
		method.setRequestHeader("Connection", "Close");
		// 加载请求头
		Response res = new Response(url);
		if (headers != null) {
			for (Iterator it = headers.entrySet().iterator(); it.hasNext();) {
				Map.Entry e = (Map.Entry) (it.next());
				method.setRequestHeader((String) e.getKey(), (String) e
						.getValue());
			}
		}
		// 设置状态
		if (state != null) {
			httpClient.setState(state);
		}

		try {
			res.setActualPath(method.getPath());
			int respCode = httpClient.executeMethod(method);
			if (log.isDebugEnabled()) {
				log.debug("[Request]" + method.getName() + " "
						+ method.getURI() + " [Response]"
						+ method.getStatusLine());
			}
			res.setStatusCode(respCode);
			res.setStatusText(method.getStatusText());

			Header[] respHeaders = method.getResponseHeaders();
			for (int i = 0; i < respHeaders.length; i++) {
				res.addResponseHeader(respHeaders[i].getName(), respHeaders[i]
						.getValue());
			}
			if (res.statusCodeIsFine()) {
				res.setResponseBody(method.getResponseBody());
			} else {
				log.warn("respCode=" + respCode + "! url=" + url);
			}
		} catch (Throwable e) {
			// 会导致大量的无谓日志，因此取消记录
			res.setFail(true);
			res.setError(e);
			res.setStatusCode(CODE_EXCEPTION);
			res.setStatusText(e.getMessage());
		} finally {
			method.releaseConnection();
		}
		return res;
	}
	
	/**
	 * 构造http协议请求的客户端对象
	 * 
	 * @return http协议请求的客户端对象
	 */
	private static HttpClient buildHttpClient() {
		return client;

	}
}
