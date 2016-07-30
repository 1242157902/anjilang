package com.anjilang.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import weibo4j.model.WeiboException;
import weibo4j.org.json.JSONException;
import weibo4j.org.json.JSONObject;

import com.anjilang.controller.base.BaseController;
import com.anjilang.controller.vo.RegistVo;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.DoctorType;
import com.anjilang.entity.FriendLink;
import com.anjilang.entity.Message;
import com.anjilang.entity.User;
import com.anjilang.service.DoctorTypeService;
import com.anjilang.service.FriendLinkService;
import com.anjilang.service.MessageService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.HttpUtils;
import com.anjilang.util.Response;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.StringUtil;
import com.anjilang.util.Validator;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;

/**
 * 登录
 * 
 * @author xym
 * 
 */
@Controller
@RequestMapping("login")
public class LoginController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private UserService userService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private DoctorTypeService doctorTypeService;
	@Autowired
	private FriendLinkService friendLinkService;
	
	private static final String ECSHOP_LOGIN_URL = "http://123.56.84.207:81/jmshop/flow.php?step=login";
	
	private static final String ECSHOP_LOGOUT_URL = "http://123.56.84.207:81/jmshop/user.php?act=logout";

	@RequestMapping(value = "login.do", produces = { Constants.PRODUCES })
	public String login(HttpServletRequest request, RegistVo vo, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]vo="
				+ ((vo == null) ? ("null") : (vo.toString())));
		try {
			Validator.validator(request.getRequestURI(), vo);
			List<User> userList = userService.queryUserByUserName(vo
					.getUserName());
			if (userList == null || userList.size() < 1
					|| userList.get(0) == null) {
				log.error("[" + flg + "] 用户不存在userName=" + vo.getUserName());
				throw AjlException.createErr("5017");
			}
			User user = userList.get(0);
			if (!vo.getPassword().equals(user.getPassword())) {
				log.error("[" + flg + "]密码错误");
				throw AjlException.createErr("5018");
			}

			//同步登陆到ecshop
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("username", "wzqjava");
			param.put("password", "111111");
			param.put("act", "signin");
			
			
			
			try {
				Response response = HttpUtils.post(ECSHOP_LOGIN_URL, null, null, param);	
				String result = response.getResponseBodyAsTrimStr();
				
				
				/*Response response2 =  com.alibaba.fastjson.JSONObject.parseObject(result, Response.class);
				
				String code = response2.getCode();
				String msg = response2.getMessage();
				System.out.println("-------------code:"+code+"___msg:"+msg);
				if(code!=null & !code.equals("1")){
					log.error("user login to ecshop error,username is[" + vo.getUserName()
							+ "]", new Throwable("code is " + code
							+ ",error message is[" + msg + "]"));	
				
					}*/
			} catch (Exception e) {
				e.printStackTrace();
			}	
		
			
			// 医生
			String docType = "";
			if ("1".equals(user.getType())) {
				if ("1".equals(user.getAudit())) {
					log.error("[" + flg + "]" + "医生账号还在审核中");
					throw AjlException.createErr("5028");
				}
				if (user.getDoctorType() != null) {
					DoctorType dt = doctorTypeService.queryById(user
							.getDoctorType());
					docType = (dt != null && StringUtil
							.isNotEmpty(dt.getName())) ? dt.getName() : "";
				}
			} else if ("3".equals(user.getType())) {
//				user.setPassword(null);
				request.getSession().setAttribute("user", user);
				SessionUtil.loginSession(request, user);
				model.addAttribute("user", user);
				return "/managers/index";
			}
			// 用户
			else {
				// return "index";
			}
			// 查询站内信息
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("fromUserId", user.getId());
			params.put("isRead", 0);
			PaginationSupport<Message> page = messageService.findByUserId(
					params, new String[] { "createTime" }, 5, 1);
			long msgTotalSize = 0;
			List<Message> msgList = new ArrayList<Message>();
			if (page != null) {
				msgTotalSize = page.getTotalCount();
				msgList = page.getItems();
			}
			request.getSession().setAttribute("msgTotalSize", msgTotalSize);
			request.getSession().setAttribute("msgList", msgList);

			request.getSession().setAttribute("user", user);
			SessionUtil.loginSession(request, user);
			request.getSession().setAttribute("docType", docType);
			model.addAttribute("user", user);
			success(model);
			
			//return "redirect:/index/index.do";
			return "redirect:/index.html";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Exception e) {
			log.error("[" + flg + "]登录失败:", e);
			error(model, AjlException.createErr("5016"));
		}
		return "/login/login";

	}

	@RequestMapping(value = "logout.do", produces = { Constants.PRODUCES })
	public String logout(HttpServletRequest request) {
		SessionUtil.logoutSession(request);
		
		//同步退出登陆ecshop
		
		try {
			Response response = HttpUtils.post(ECSHOP_LOGOUT_URL, null, null, null);	
			String result = response.getResponseBodyAsTrimStr();
			/*Response response2 =  com.alibaba.fastjson.JSONObject.parseObject(result, Response.class);
			
			String code = response2.getCode();
			String msg = response2.getMessage();
			if(code!=null & !code.equals("1")){
				log.error("user login to ecshop error,username is[" + SessionUtil.getLoginUser(request).getUserName()
						+ "]", new Throwable("code is " + code
						+ ",error message is[" + msg + "]"));			
				}	*/	
			
		} catch (Exception e) {
		//	log.error("user login to ecshop error,username is[" +SessionUtil.getLoginUser(request).getUserName()
				//		+ "]",e);
		}
		
		//return "redirect:/index/index.do";
		return "redirect:/index.html";
	}
	
	
	/**
	 * QQ登陆页面跳转
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "qqLogin.do", produces = { Constants.PRODUCES })
	public void qqLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		try {
			response.sendRedirect(new Oauth().getAuthorizeURL(request));
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
		// return null;
	}

	/**
	 * 登陆后进行处理逻辑
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "qqLoginAfter.do", produces = { Constants.PRODUCES })
	public String qqLoginAfter(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		try {
			AccessToken accessTokenObj = (new Oauth())
					.getAccessTokenByRequest(request);

			String accessToken = null, openID = null;
			//Long tokenExpireIn = null;

			if (accessTokenObj.getAccessToken().equals("")) {
				System.out.println("QQ登录校验失败!");
			} else {
				accessToken = accessTokenObj.getAccessToken();
				OpenID openIDObj = new OpenID(accessToken);
				openID = openIDObj.getUserOpenID();

				UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
				UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
			

				// 第三方处理用户绑定逻辑
				String user_id = openID;
				String nickname = new String(userInfoBean.getNickname());
				System.out.println("-----user_id:" + user_id);
				System.out.println("-----nickname:" + nickname);
				User user = userService.queryByQQId(user_id);
				if (user != null) {
					request.getSession().setAttribute("user", user);
					SessionUtil.loginSession(request, user);
					
				} else {
					User userNew = new User();
					userNew.setCreateTime(new Date());
					userNew.setType("2");
					userNew.setHeader("image/defaultHead.png");
					userNew.setQqOpenId(user_id);
					userNew.setRealName(nickname);
					try {
						userService.save(userNew);
					} catch (AjlException e) {
						e.printStackTrace();
					}
					
					request.getSession().setAttribute("user", userNew);
					SessionUtil.loginSession(request, userNew);
				}
				
				
			}
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
		//return "redirect:/index/index.do";
		return "redirect:/index.html";
	}
	
	/**
	 * weibo登陆页面跳转
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "weiboLogin.do", produces = { Constants.PRODUCES })
	public String weiboLogin(HttpServletRequest request, HttpServletResponse response){
		
		weibo4j.Oauth oauth = new weibo4j.Oauth();
        String url="";
		try {
			url = oauth.authorize("code");
		} catch (WeiboException e) {
			e.printStackTrace();
		}
		
        return "redirect:" + url;
		
	}
	
	/**
	 * sina微博登陆后逻辑操作
	 * @param request
	 * @param response
	 * @return
	 * @throws WeiboException 
	 * @throws JSONException 
	 * @throws IOException
	 */
	@RequestMapping(value = "weiBoLoginAfter.do", produces = { Constants.PRODUCES })
	public String weiBoLoginAfter(HttpServletRequest request,
			HttpServletResponse response)  {
		System.out.println("----------222222222-------------");
		response.setContentType("text/html;charset=UTF-8");
        String accessToken = null ;
        String uid = null ;
        String screenName = null ;        
        String username = null ;
        String head=null;
        weibo4j.http.AccessToken accessTokenObj = null ;
        weibo4j.Oauth oauth2 = new weibo4j.Oauth();
    	
        String code=request.getParameter("code");
        System.out.println("----------code:"+code);
        try {
			accessTokenObj = oauth2.getAccessTokenByCode(code) ;
	        accessToken = accessTokenObj.getAccessToken() ;
	        oauth2.setToken(accessToken) ;
	        weibo4j.Account account = new weibo4j.Account() ;
	        account.client.setToken(accessToken) ;
	        JSONObject uidJson = account.getUid() ;
	        uid = uidJson.getString("uid") ;
	        
	        weibo4j.Users users = new weibo4j.Users() ;
	        users.client.setToken(accessToken) ;
	        weibo4j.model.User weiboUser = users.showUserById(uid) ; 
	        username = weiboUser.getName() ;
	        screenName = weiboUser.getScreenName();
	         head = weiboUser.getAvatarLarge();
	        
        } catch (Exception e) {
			e.printStackTrace();
		}
        System.out.println("---------uid："+uid);
        System.out.println("---------username："+username);
        System.out.println("---------screenName："+screenName);
        System.out.println("---------head:"+head);
		User user=this.userService.queryByWeiBoUid(uid);
        if(user!=null){
        	request.getSession().setAttribute("user", user);
			SessionUtil.loginSession(request, user);
        }else{
        	User userNew = new User();
			userNew.setCreateTime(new Date());
			userNew.setType("2");
			userNew.setHeader("image/defaultHead.png");
			userNew.setWeiboUid(uid);
			userNew.setRealName(screenName);
			try {
				userService.save(userNew);
			} catch (AjlException e) {
				e.printStackTrace();
			}
			
			request.getSession().setAttribute("user", userNew);
			SessionUtil.loginSession(request, userNew);
        }
        
		//return "redirect:/index/index.do";
        return "redirect:/index.html";
	}
}
