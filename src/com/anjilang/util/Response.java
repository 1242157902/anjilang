package com.anjilang.util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * 对HTTP客户端请求获得的响应的封装. <BR>
 */
public class Response {

    
    public static final String DEF_ENCODING = "ISO8859-1";
    
    private String requestURL;
    
    private String actualPath;
    
    private int statusCode;
    
    private String statusText;
    
    private byte[] responseBody;
    
	private Map<String, String> responseHeaders;
    
    private String encoding = DEF_ENCODING;
    
    /**
     * 论坛返回的响应码,0失败,1成功
     */
    private String code;
    
    /**
     * 论坛返回的响应信息
     */
    private String message;

	/**
	 * 是否有异常发生.
	 */
    private boolean fail;

	/**
	 * 异常对象.
	 */
    private Throwable error;

	/**
	 * 异常信息.
	 */
    private String exceptionInfo;
    
    public Response(){}
    
    public Response(String url) {
		responseHeaders = new HashMap<String, String>();
        requestURL = url;
    }
    
    public Response(String url, Throwable t) {
        this(url);
        if (t != null) {
            fail = true;
            error = t;
            exceptionInfo = t.toString();
        }
    }
    
	/**
	 * @see java.lang.Object#toString()
	 * @since liushen @ May 16, 2010
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Response [url: ").append(requestURL).append(
				", status: ").append(getStatusLine()).append("]");
		return builder.toString();
	}

	/**
	 * 获取状态码和简要说明.
	 * 
	 * @since liushen @ Jan 7, 2012
	 */
	public String getStatusLine() {
		if (StringUtil.isEmpty(statusText)) {
			return String.valueOf(statusCode);
		} else {
			return statusCode + " " + statusText;
		}
    }
    
    public String getResponseBodyAsTrimStr() {
        if (responseBody == null) {
            return null;
        }
        
        try {
            return new String(responseBody, encoding).trim();
        } catch (UnsupportedEncodingException e) {
            return new String(responseBody).trim();
        } catch (java.nio.charset.IllegalCharsetNameException e) { 
            return new String(responseBody).trim();
        }
    }

	/**
	 *  
	 */
    public int getResponseBodyLength() {
        if (responseBody == null) {
            return 0;
        }
        
        return responseBody.length;
    }
    
	/**
	 * 获取响应头"Content-Length"的值。
	 * 
	 * @since liushen @ Jan 7, 2012
	 */
	public int getContentLength() {
		return StringUtil.parseInt(getResponseHeader("Content-Length"));
	}

	public boolean statusCodeIsFine() {
        if (statusCode == 0) {
            return false;
        }
//      2xx, 3xx means OK?
        return statusCode / 100 < 4;
    }
    
    /**
     * @since ls@08.0219
     */
    public boolean statusCodeIs2XX() {
    	return statusCode / 100 == 2;
    }
    
    public String getMainInfo() {
        if (statusCodeIs2XX()) {
            return getResponseBodyAsTrimStr();
        } else if (isFail()) {
            return getExceptionInfo();
        } else {
            return getStatusLine();
        }
    }
    
	/**
	 * 供包内的 {@link PureClient} 调用，保存响应头信息。
	 * 
	 * @param name
	 * @param value
	 * @since liushen @ Jan 7, 2012
	 */
	void addResponseHeader(String name, String value) {
		if (name == null) {
			return;
		}
		name = name.toUpperCase();
        Object originValue = responseHeaders.get(name);
        if (originValue instanceof String) {
            responseHeaders.put(name, originValue + "; " + value);
        } else {
            responseHeaders.put(name, value);
        }
        
        if ("Content-Type".equalsIgnoreCase(name)) {
            if (value != null && value.indexOf('=') > 0) {
                encoding = StringUtil.truncateAndTrim(value, "=");
                if (encoding != null) {
                    encoding = encoding.toUpperCase();
                }
            }
        }
    }

    /**
     * Returns the {@link #error}.
     * @return the error.
     */
    Throwable getError() {
        return error;
    }

    /**
     * Set the {@link #error}.
     * @param error the error to set
     */
    void setError(Throwable error) {
        this.error = error;
        if (error != null) {
            exceptionInfo = error.toString();
        }
    }

    /**
	 * 获取给定的HTTP响应头的值.
	 * 
	 * @param name
	 *            响应头名称；大小写无关.
	 * @return 如果没有此响应头，则返回<code>null</code>.
	 * @since liushen @ Jul 11, 2012
	 */
	public String getResponseHeader(String name) {
		if (name == null) {
			return null;
		}
		name = name.toUpperCase();
		return responseHeaders.get(name);
	}

	/**
	 * 获取所有的响应头(以Map形式)。
	 * 
	 * @return 该Map的Key为响应头名称的全大写形式，Value为其值。
	 */
	public Map<String, String> getResponseHeaders() {
        return responseHeaders;
    }

    /**
     * Returns the {@link #responseBody}.
     * @return the responseBody.
     */
    public byte[] getResponseBody() {
        return responseBody;
    }

    /**
     * Set the {@link #responseBody}.
     * @param responseBody the responseBody to set
     */
    void setResponseBody(byte[] responseBody) {
        this.responseBody = responseBody;
    }

    /**
     * Returns the {@link #statusCode}.
     * @return the statusCode.
     */
    public int getStatusCode() {
        return statusCode;
    }

    /**
     * Set the {@link #statusCode}.
     * @param statusCode the statusCode to set
     */
    void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    /**
     * Returns the {@link #statusText}.
     * @return the statusText.
     */
    public String getStatusText() {
        return statusText;
    }

    /**
     * Set the {@link #statusText}.
     * @param statusText the statusText to set
     */
    void setStatusText(String statusText) {
        this.statusText = statusText;
    }

    /**
     * Returns the {@link #fail}.
     * @return the success.
     */
    public boolean isFail() {
        return fail;
    }

    /**
     * Set the {@link #fail}.
     * @param success the success to set
     */
    void setFail(boolean success) {
        this.fail = success;
    }

    /**
     * Returns the {@link #requestURL}.
     * @return the requestURL.
     */
    public String getRequestURL() {
        return requestURL;
    }

    /**
     * Set the {@link #requestURL}.
     * @param requestURL the requestURL to set
     */
    void setRequestURL(String requestURL) {
        this.requestURL = requestURL;
    }

    /**
     * Returns the {@link #encoding}.
     * @return the encoding.
     */
    public String getEncoding() {
        return encoding;
    }

    /**
     * Returns the {@link #actualPath}.
     * @return the actualURL.
     */
    public String getActualPath() {
        return actualPath;
    }

    /**
     * Set {@link #actualPath}.
     * @param actualURL The actualURL to set.
     */
    void setActualPath(String actualURL) {
        this.actualPath = actualURL;
    }

    /**
     * Returns the {@link #exceptionInfo}.
     * @return the exceptionInfo.
     */
    public String getExceptionInfo() {
        return exceptionInfo;
    }

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}


}
