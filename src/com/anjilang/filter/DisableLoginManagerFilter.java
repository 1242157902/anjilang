package com.anjilang.filter;

import java.io.IOException;

import javax.servlet.Filter;     
import javax.servlet.FilterChain;     
import javax.servlet.FilterConfig;     
import javax.servlet.ServletException;     
import javax.servlet.ServletRequest;     
import javax.servlet.ServletResponse;     
import javax.servlet.http.HttpServletRequest;     
import javax.servlet.http.HttpServletResponse;     
import javax.servlet.http.HttpSession; 

import com.anjilang.entity.User;

/**   
 * @Title: DisableUserManagerFilter.java 
 * @Package com.anjilang.filter 
 * @Description: 限制用户
 * @author linqingsong
 * @date 2015-1-14 下午11:42:41 
 * @version V1.0   
 */

public class DisableLoginManagerFilter implements Filter{

	public void destroy() {     
        // TODO Auto-generated method stub     
             
    }     
    
    public void doFilter(ServletRequest request, ServletResponse response,     
            FilterChain chain) throws IOException, ServletException {     
        // 设置请求的字符编码     
         request.setCharacterEncoding("UTF-8");     
        // 设置返回请求的字符编码     
        response.setCharacterEncoding("UTF-8");     
        // 转换ServletRequest为 HttpServletRequest     
        HttpServletRequest req = (HttpServletRequest) request;     
        // 转换ServletResponse为HttpServletRequest     
        HttpServletResponse res = (HttpServletResponse) response;     
        // 获取Session     
        HttpSession session = req.getSession();     
        // 获取Session中存储的对象     
        Object o = session.getAttribute("user");     
        // 获取当前请求的URI     
        String url = req.getRequestURI();     
        // 判断Session中的对象是否为空；判断请求的URI是否为不允许过滤的URI     
        if (url.contains("/managers/")) {
        	if(o==null){
        		res.sendRedirect(req.getContextPath() + "/login/login.jsp");
        	}else{
	        	User user=(User)o;
	        	if(!user.getType().equals("3")){
	        		//res.sendRedirect(req.getContextPath() + "/index/index.do");
	        		res.sendRedirect(req.getContextPath() + "/index.html");
	        	}else{
	        		chain.doFilter(request, response);
	        	}
        	}
        
        }else if (url.contains("/answer/addQuestion.do")
        		|| url.contains("/answer/addAnswer.do") 
        		|| url.contains("/answer/addAnswerComment.do") 
        		|| url.contains("/patientGroup/toAdd.do")
        		|| url.contains("/GroupUser/JoinGroup.do")
        		|| url.contains("/answer/addAnswerComment.do")
        		|| url.contains("/comment/save.do")
        		|| url.contains("/dietican/addArticle.jsp")
        		|| url.contains("/TopicReply/addReply.do")
        		||url.contains("/GroupTopic/topublish.do")
        		) {
			if (o == null) {
				System.out.println("##########################");
				//res.sendRedirect(req.getContextPath() + "/login/login.jsp");
				res.sendRedirect(req.getContextPath() + "/login.html");
			} else {
				chain.doFilter(request, response);
			}
		} else {
            chain.doFilter(request, response);     
            res.setHeader("Cache-Control","no-store");           
            res.setDateHeader("Expires",0);        
            res.setHeader("Pragma","no-cache");      
            res.flushBuffer();     
        }
             
    }     
    
    public void init(FilterConfig filterConfig) throws ServletException {     
        // TODO Auto-generated method stub     
             
    }     

}
