package com.anjilang.controller;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.bouncycastle.jce.provider.JDKDSASigner.noneDSA;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.controller.vo.RegistVo;
import com.anjilang.entity.City;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.RegistCode;
import com.anjilang.entity.User;
import com.anjilang.service.CityService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.RegistCodeService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.DButils;
import com.anjilang.util.DateUtil;
import com.anjilang.util.HttpUtils;
import com.anjilang.util.Mail;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.ReflectUtil;
import com.anjilang.util.Response;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.StringUtil;
import com.anjilang.util.ThreeDESUtil;
import com.anjilang.util.Validator;

@Controller
@RequestMapping("regist")
public class RegistController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private CityService cityService;

	@Autowired
	private DiseaseProjectService diseaseProjectService;

	@Autowired
	private UserService userService;

	@Autowired
	private RegistCodeService registCodeService;
	
	/**
	 * ecshop商城的用户注册接口地址
	 */
	private static final String ECSHOP_REGISTER_URL = "http://www.angelaround.com/shop/user.php?act=act_register&laiyuan=wcm";

	/**
	 * 医生注册页面初始化
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "init.do", produces = { Constants.PRODUCES })
	public String init(HttpServletRequest request, String vo, String estr, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "][仅仅当注册失败时 vo值]vo[" + vo + "]estr["+estr+"]");
		try {
			RegistVo regVo = new RegistVo();
			if (!StringUtil.isEmpty(vo)) {
				vo = URLDecoder.decode(vo, Constants.ENCODE);
				log.info("[" + flg + "][仅仅当注册失败时 vo值]vo[" + vo + "]");
				JSONObject json = JSONObject.parseObject(vo);
				regVo = JSONObject.toJavaObject(json, RegistVo.class);
			}
			
			// 查询所有的省份列表
			List<City> pList = cityService.queryCityByParentId(0l);
			// 查询北京下的所有区(市)
			// 北京ID=1
			List<City> cList = cityService.queryCityByParentId(1l);

			// 查询疾病项目列表
			List<DiseaseProject> dlist = diseaseProjectService.queryAll();

			// 查询最新注册的2位认证的医生
			List<User> docList = userService.queryUserByAudit("2", "1");
			model.addAttribute("docList", docList);

			success(model);
			model.addAttribute("provinceList", pList);
			model.addAttribute("cityList", cList);
			model.addAttribute("projectList", dlist);
			model.addAttribute("regVo", regVo);
			
			if (!StringUtil.isEmpty(estr)) {
				estr = URLDecoder.decode(estr, Constants.ENCODE);
				log.info("[" + flg + "][仅仅当注册失败时 estr值]estr[" + estr + "]");
				JSONObject json = JSONObject.parseObject(estr);
				model.addAttribute("code", json.getString("code"));
				model.addAttribute("msg", json.getString("msg"));
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]注册初始化失败", e);
			error(model, AjlException.createErr("5004"));
		}
		
		// 跳转到regist/init.jsp页面
		return "regist/init";
	}
	  @RequestMapping(value={"sendMessage.do"}, produces={"application/json;charset=UTF-8"})
	  @ResponseBody
	  public String sendMessage(HttpServletRequest request, String phone, Model model)
	    throws MalformedURLException, UnsupportedEncodingException
	  {
	    String flg = (String)request.getAttribute("logFlag");
	    this.log.info("[" + flg + "]" + "phone:" + phone);

	    com.anjilang.util.SendMessage sms = new com.anjilang.util.SendMessage();
	    String num = sms.random(6);
	    this.log.info("[" + flg + "]" + "生成的验证码为：num:" + num);
	    String msg = "";
	   // String Content = "验证码为：" + num + "感谢您注册安吉朗网站，验证码十分钟之内有效【安吉朗】";
	   String code =  sms.sendSMS(phone, num);//真正放开就行
	    //String code = "2";
	    if (code.equals("2"))
	    {
	      request.getSession().setAttribute("num", num);
	      msg = "success";
	    } else if (code.equals("406"))
	    {
	      msg = "err_phone";
	    } else {
	      msg = "err_code！";
	    }
	    this.log.info("[" + flg + "]" + "msg:" + msg+"短信返回code:"+code);
	    model.addAttribute("msg", msg);
	    success(model);
	    return msg;
	  }
	/**
	 * 查询是否用户是否已注册
	 * 
	 * @param request
	 * @param userName
	 * @return
	 */
	@RequestMapping(value = "isRegisted.do", produces = { Constants.PRODUCES })
	public @ResponseBody
	String isRegisted(HttpServletRequest request, String userName) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		JSONObject ret = new JSONObject();
		try {
			JSONObject req = new JSONObject();
			req.put("userName", userName);

			log.info("[" + flg + "]" + req.toJSONString());
			Validator.validator(request.getRequestURI(), req);

			List<User> dList = userService.queryUserByUserName(userName);
			if (dList != null && dList.size() > 0) {
				log.error("[" + flg + "]userName=" + userName + "已存在");
				throw AjlException.createErr("5007");
			}
			success(ret);
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(ret, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]查询userName=" + userName + "是否存时，系统异常", e);
			error(ret, AjlException.createErr("5006"));
		}
		return ret.toJSONString();
	}

	/**
	 * 医生注册
	 * 
	 * @param request
	 * @param userName
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "regist.do", produces = { Constants.PRODUCES })
	public String regist(HttpServletRequest request, RegistVo vo, Model model,
			RedirectAttributes attr) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		AjlException err = null;
		try {
			log.info("[" + flg + "]注册:" + (vo != null ? vo.toString() : "null"));
			Validator.validator(request.getRequestURI(), vo);
		/*	if (!vo.getPassword().equals(vo.getPassword2())) {
				log.error("[" + flg + "]两次输入密码不一致.");
				throw AjlException.createErr("5024");
			}*/
			List<User> dList = userService.queryUserByUserName(vo.getUserName());
			
			if (  dList.size() == 0) {
				log.error("[" + flg + "]email=" + vo.getUserName() + "还未登录！");
				throw AjlException.createErr("5017");
			}
			User user = dList.get(0);
			user.setTitle(vo.getTitle());
			user.setSex(vo.getSex());
			user.setRealName(vo.getRealName());
			user.setProject(vo.getProject());
			user.setProvince(vo.getProvince());
			user.setHospital(vo.getHospital());
			user.setCity(vo.getCity());
			user.setHeader(vo.getHeader());
			user.setCertificateNo(vo.getCertificateNo());
			//user.setBirthday(new Date(vo.getBirStr()));
			//ReflectUtil.copy(vo, user, flg);
			// 1-医生
			user.setType("1");
			// 未审核
			user.setAudit("1");
			Date birth = DateUtil
					.parse2Date(vo.getBirStr(), DateUtil.FORMMAT_3);
			user.setBirthday(birth);
			user.setCreateTime(new Date());
			//userService.save(user);
			userService.update(user);
			// success(model);
			log.info("[" + flg + "]医生注册成功");
			// 医生注册成功 跳转到提示页 审核成功过后显示
			model.addAttribute("message", "医生注册申请成功，审核通过之后才能进行登陆");
			
		/*	//同步注册用户到ecshop
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", vo.getUserName());
			params.put("password ", vo.getPassword());
			params.put("email", vo.getUserName());
			
			Response response = HttpUtils.post(ECSHOP_REGISTER_URL, null, null, params);	
			String result = response.getResponseBodyAsTrimStr();
			Response response2 =  JSONObject.parseObject(result, Response.class);
			
			String code = response2.getCode();
			String msg = response2.getMessage();
			if(code!=null & !code.equals("1")){
			log.error("register user to ecshop error,username is[" + vo.getUserName()
					+ "]", new Throwable("code is " + code
					+ ",error message is[" + msg + "]"));			
			}*/
			
			return "/result";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
			err = e;
		} catch (Throwable e) {
			log.error("[" + flg + "]保存用户信息="
					+ (vo != null ? vo.toString() : "null") + "，系统异常", e);
			error(model, AjlException.createErr("5006"));
			err = AjlException.createErr("5006");
		}
		vo = (vo == null) ? (new RegistVo()) : vo;
		String voStr = ((JSONObject) JSONObject.toJSON(vo)).toJSONString();

		String errStr = (err != null) ? "{'code':'" + err.getCode() + "',msg:'"
				+ err.getMsg() + "'}" : "{}";
		try {
			voStr = URLEncoder.encode(voStr, Constants.ENCODE);
			errStr = URLEncoder.encode(errStr, Constants.ENCODE);
		} catch (UnsupportedEncodingException e) {
			log.error("[" + flg + "]", e);
			voStr = null;
			errStr = null;
		}
		attr.addAttribute("vo", voStr);
		attr.addAttribute("estr", errStr);
		return "redirect:/regist/init.do";
	}
	
	/**
	 * 医生注册
	 * 
	 * @param request
	 * @param userName
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "registNew.do", produces = { Constants.PRODUCES })
	public String registNew(HttpServletRequest request, RegistVo vo, Model model,
			RedirectAttributes attr) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		AjlException err = null;
		try {
			log.info("[" + flg + "]注册:" + (vo != null ? vo.toString() : "null"));
			Validator.validator(request.getRequestURI(), vo);
			/*	if (!vo.getPassword().equals(vo.getPassword2())) {
				log.error("[" + flg + "]两次输入密码不一致.");
				throw AjlException.createErr("5024");
			}*/
			List<User> dList = userService.queryUserByUserName(vo.getUserName());
			
			if (  dList.size() == 0) {
				log.error("[" + flg + "]email=" + vo.getUserName() + "还未登录！");
				throw AjlException.createErr("5017");
			}
			User user = dList.get(0);
			user.setTitle(vo.getTitle());
			user.setSex(vo.getSex());
			user.setRealName(vo.getRealName());
			user.setProject(vo.getProject());
			user.setProvince(vo.getProvince());
			user.setHospital(vo.getHospital());
			user.setCity(vo.getCity());
			user.setHeader(vo.getHeader());
			user.setCertificateNo(vo.getCertificateNo());
			//user.setBirthday(new Date(vo.getBirStr()));
			//ReflectUtil.copy(vo, user, flg);
			// 1-医生
			user.setType("1");
			// 未审核
			user.setAudit("1");
			Date birth = DateUtil
					.parse2Date(vo.getBirStr(), DateUtil.FORMMAT_3);
			user.setBirthday(birth);
			user.setCreateTime(new Date());
			//userService.save(user);
			userService.update(user);
			// success(model);
			log.info("[" + flg + "]医生注册成功");
			// 医生注册成功 跳转到提示页 审核成功过后显示
			model.addAttribute("message", "医生注册申请成功，审核通过之后才能进行登陆");
			
			/*	//同步注册用户到ecshop
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", vo.getUserName());
			params.put("password ", vo.getPassword());
			params.put("email", vo.getUserName());
			
			Response response = HttpUtils.post(ECSHOP_REGISTER_URL, null, null, params);	
			String result = response.getResponseBodyAsTrimStr();
			Response response2 =  JSONObject.parseObject(result, Response.class);
			
			String code = response2.getCode();
			String msg = response2.getMessage();
			if(code!=null & !code.equals("1")){
			log.error("register user to ecshop error,username is[" + vo.getUserName()
					+ "]", new Throwable("code is " + code
					+ ",error message is[" + msg + "]"));			
			}*/
			
			return "/result";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
			err = e;
		} catch (Throwable e) {
			log.error("[" + flg + "]保存用户信息="
					+ (vo != null ? vo.toString() : "null") + "，系统异常", e);
			error(model, AjlException.createErr("5006"));
			err = AjlException.createErr("5006");
		}
		vo = (vo == null) ? (new RegistVo()) : vo;
		String voStr = ((JSONObject) JSONObject.toJSON(vo)).toJSONString();
		
		String errStr = (err != null) ? "{'code':'" + err.getCode() + "',msg:'"
				+ err.getMsg() + "'}" : "{}";
		try {
			voStr = URLEncoder.encode(voStr, Constants.ENCODE);
			errStr = URLEncoder.encode(errStr, Constants.ENCODE);
		} catch (UnsupportedEncodingException e) {
			log.error("[" + flg + "]", e);
			voStr = null;
			errStr = null;
		}
		attr.addAttribute("vo", voStr);
		attr.addAttribute("estr", errStr);
		return "redirect:/regist/init.do";
	}

	/**
	 * 注册:发送验证邮件
	 * 
	 * @param request
	 * @param email
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "userreg.do", produces = { Constants.PRODUCES })
	public String userreg(HttpServletRequest request, String email, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		JSONObject req = new JSONObject();
		req.put("email", email);
		log.info("[" + flg + "][" + request.getRequestURI() + "]"
				+ req.toJSONString());
		model.addAttribute("email", email);
		try {
			Validator.validator(request.getRequestURI(), req);
			List<User> dList = userService.queryUserByUserName(email);
			if (dList != null && dList.size() > 0) {
				log.error("[" + flg + "]email=" + email + "已存在");
				throw AjlException.createErr("5007");
			}
			// 保存注册码
			RegistCode rc = new RegistCode();
			rc.setCreateTiem(new Date());
			rc.setEmail(email);
			// 激活验证码
			rc.setUuid(flg);
			// 未使用
			rc.setState("0");
			registCodeService.save(rc);

			String emialEncrypt = ThreeDESUtil.encryptData(
					Constants.THREE_DES_KEY, email);
			String param = "regist/verify.do?flag=" + emialEncrypt + "&uuid="
					+ flg;
			String url = PropertyUtil.newInstans().getValue("url");
			log.info("[" + flg + "]工程地址:" + url);
			if (StringUtil.isEmpty(url)) {
				log.error("[" + flg + "]注册验证地址未配置");
				throw AjlException.createErr("5010");
			}
			// 发验证邮件
			// SendEmail se = new SendEmail();
			Mail mail = new Mail();
			StringBuffer content = new StringBuffer();
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String newTim = sdf.format(date);

			content.append("<div style=\"background:#fcfcfc;width:650px;margin:0 auto;padding:20px\">");
			content.append("<h1 style=\"margin:0;padding:0;border-bottom:1px #b2b2b2 dotted;padding-bottom:15px\">");
			content.append("<a href=\"http://www.angelaround.com/\" target=\"_blank\">");
			content.append("<img src=\"http://www.angelaround.com/image/logo.png\" title=\"安吉朗\" style=\"margin:0;padding:0;border:0;vertical-align:middle\"></a></h1>");
			content.append("<div style=\"margin:0;padding:15px 0 60px 0;border-bottom:1px #b2b2b2 dotted\">");
			content.append("<h4 style=\"margin:0;font-size:14px;padding:10px 0\">尊敬的安吉朗用户！</h4>");
			content.append("<p style=\"margin:0;padding:10px 0;font-size:14px;line-height:24px;color:#333\">欢迎使用安吉朗，您于<span style=\"border-bottom-width: 1px; border-bottom-style: dashed; border-bottom-color: rgb(204, 204, 204); position: relative;\" t=\"5\" times=\"\">"
					+ newTim
					+ "</span>提交了用户注册，此邮件是为了验证您提交邮件地址的正确性。如果您确认是您本人提交的申请，</p>");
			content.append("<p style=\"margin:0;font-size:14px;font-weight:bold;padding:10px 0\"><a href=\""
					+ url
					+ param
					+ "\" target=\"_blank\" style=\"color:#0b8ab6;text-decoration:underline\">点击继续</a></p>");
			content.append("<p style=\"margin:0;font-size:14px;color:#333;padding:10px 0 5px 0;line-height:24px\">如果上述文字点击无效，请把下面地址复制到浏览器地址栏中打开：</p>");
			content.append("<p style=\"margin:0;font-size:12px;color:#666;line-height:20px;word-wrap: break-word;word-break: normal\"><a href=\""
					+ url
					+ param
					+ "\" target=\"_blank\">"
					+ url
					+ param
					+ "</a></p>");
			content.append("<p style=\"margin:0;font-size:12px;color:#999;padding:20px 0 0 0\">该邮件将在30分钟后过期");
			content.append("</p><p style=\"margin:0;font-size:12px;color:#999;padding:20px 0 0 0\">如非本人操作，请您忽略该邮件，给您造成的不便敬请谅解。</p>");
			content.append("<p style=\"margin:0;font-size:12px;color:#999;padding:10px 0 0 0;text-align:right;line-height:20px\">【安吉朗】<br>"
					+ newTim + "&nbsp; </p>");
			content.append("</div>");
			content.append("<div style=\"margin:0;padding:20px 0\">");
			content.append("<p style=\"margin:0;font-size:12px;color:#999\">此为系统自动发送邮件，请勿回复。</p>");
			content.append("<p style=\"margin:0;font-size:12px;color:#999;padding:15px 0 0 0;line-height:20px\">请妥善保管好您的邮箱，避免安吉朗账户被他人盗用！<br>如有疑问，请登录<a href=\"http://www.angelaround.com/\" target=\"_blank\" style=\"text-decoration:underline;color:#000\">http://www.angelaround.com</a>查看详细信息");
			content.append("</div>");
			content.append("</div>");
			// se.doSendHtmlEmail("注册邮箱验证", content, email);
			mail.sendMessage(email, "安吉朗平台信息中心", content.toString());

			String suffix = email.substring(email.lastIndexOf("@") + 1);
			model.addAttribute("mailUrl", "http://mail." + suffix);
			success(model);
			return "regist/userreg1";
		} catch (AjlException e) {
			log.error("[" + flg + "]用户注册1失败email：" + email + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]用户注册1注册失败email：" + email, e);
			error(model, AjlException.createErr("5010"));
		}
		return "regist/userreg";
	}
	@RequestMapping(value={"userreg1.do"}, produces={"application/json;charset=UTF-8"})
	  public String userreg1(HttpServletRequest request, String phone, String verifycode, Model model)
	  {
	    String flg = (String)request.getAttribute("logFlag");
	    this.log.info("[" + flg + "]" + "phone:" + phone);
	    model.addAttribute("phone", phone);
	    JSONObject req = new JSONObject();
	    req.put("phone", phone);
	    try {
	      Validator.validator(request.getRequestURI(), req);
	      List dList = this.userService.queryUserByPhone(phone);
	      if ((dList != null) && (dList.size() > 0)) {
	        this.log.error("[" + flg + "]phone=" + phone + "已存在");
	        throw AjlException.createErr("5029");
	      }
	      String num = (String)request.getSession().getAttribute("num");
	      System.out.println(num + verifycode);
	      if (!(verifycode.equals(num)))
	      {
	        throw AjlException.createErr("5030");
	      }
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      
	      return "regist/userreg3";
	    } catch (AjlException e) {
	      this.log.error("[" + flg + "]用户注册1失败phone：" + phone + e.toString());
	      error(model, e);
	    }
	    catch (Throwable e) {
	      this.log.error("[" + flg + "]用户注册1注册失败phone：" + phone, e);
	      error(model, AjlException.createErr("5010"));
	    }

	    return "regist/userreg";
	  }
	/**
	 * 验证邮箱
	 * 
	 * @param request
	 * @param flag
	 * @param uuid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "verify.do", produces = { Constants.PRODUCES })
	public String verify(HttpServletRequest request, String flag, String uuid,
			Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		JSONObject req = new JSONObject();
		req.put("flag", flag);
		req.put("uuid", uuid);
		log.info("[" + flg + "][" + request.getRequestURI() + "]"
				+ req.toJSONString());
		try {
			Validator.validator(request.getRequestURI(), req);
			// 解密邮箱地址
			String email = ThreeDESUtil.decryptData(Constants.THREE_DES_KEY,
					flag);
			if (StringUtil.isNotEmpty(email)) {
				email = email.trim();
			} else {
				log.error("[" + flg + "]");
				throw AjlException.createErr("5015");
			}
			// 验证是否存在
			registCodeService.queryRegistCode(email, uuid);
			model.addAttribute("userName", email);
			success(model);
			return "regist/userreg2";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
			error(model, AjlException.createErr("5015"));
		}

		return "regist/userreg";
	}

	/**
	 * 注册(普通用户)
	 * 
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "userregist.do", produces = { Constants.PRODUCES })
	public String userregist(HttpServletRequest request, RegistVo vo,
			Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);

		try {
			log.info("[" + flg + "]普通用户注册vo="
					+ ((vo == null) ? ("null") : (vo.toString())));
			Validator.validator(request.getRequestURI(), vo);
			if (!vo.getPassword().equals(vo.getPassword2())) {
				log.error("[" + flg + "]两次输入密码不一致.");
				throw AjlException.createErr("5023");

			}

			if (StringUtils.isBlank(vo.getRealName())) {
				throw AjlException.createErr("5201");
			}

			User user = new User();
			ReflectUtil.copy(vo, user, flg);
			user.setCreateTime(new Date());
			user.setType("2");
			user.setHeader("image/defaultHead.png");
			userService.save(user);
			
			
/********************************************************Ecshop同步**********************************/
			
			Connection conn=null;
			PreparedStatement	statement=null;
			try {
				conn=DButils.getConnection();
				
				String sql="insert into ecs_users(email,password,user_name) values(?,?,?)";
				
			statement=conn.prepareStatement(sql);
			statement.setString(1, user.getUserName());
			statement.setString(2, user.getPassword());
			statement.setString(3, user.getRealName());
			
			statement.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}finally
			{
			   DButils.release(conn, statement, null);
			}
			
			
			
			
			
			
			
			
			
	/**************************************************ECShop同步*********************************/

			user.setPassword(null);
			request.getSession().setAttribute("user", user);
			SessionUtil.loginSession(request, user);
			model.addAttribute("user", user);
			
		/*	//同步注册用户到ecshop
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", vo.getUserName());
			params.put("password ", vo.getPassword());
			params.put("email", vo.getUserName());
			
			Response response = HttpUtils.post(ECSHOP_REGISTER_URL, null, null, params);	
			String result = response.getResponseBodyAsTrimStr();
			Response response2 =  JSONObject.parseObject(result, Response.class);
			
			String code = response2.getCode();
			String msg = response2.getMessage();
			if(code!=null & !code.equals("1")){
			log.error("register user to ecshop error,username is[" + vo.getUserName()
					+ "]", new Throwable("code is " + code
					+ ",error message is[" + msg + "]"));			
			}*/
			// to 登录成功页面
			// return "index";
			//return "redirect:/index/index.do";
			return "redirect:/index.html";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
			error(model, AjlException.createErr("5010"));
		}
		model.addAttribute("userName", vo.getUserName());
		return "regist/userreg2";
	}
	@RequestMapping(value={"userregist1.do"}, produces={"application/json;charset=UTF-8"})
	  public String userregist1(HttpServletRequest request, RegistVo vo, Model model)
	  {
	    String flg = (String)request.getAttribute("logFlag");
	    try
	    {
	      this.log.info("[" + flg + "]普通用户注册vo=" + 
	        ((vo == null) ? "null" : vo.toString()));
	      Validator.validator(request.getRequestURI(), vo);
	      if (!(vo.getPassword().equals(vo.getPassword2()))) {
	        this.log.error("[" + flg + "]两次输入密码不一致.");
	        throw AjlException.createErr("5023");
	      }

	      if (StringUtils.isBlank(vo.getRealName())) {
	        throw AjlException.createErr("5201");
	      }

	      User user = new User();
	      ReflectUtil.copy(vo, user, flg);
	      user.setCreateTime(new Date());
	      user.setType("2");
	      user.setHeader("image/defaultHead.png");
	      this.userService.save(user);

	      user.setPassword(null);
	      request.getSession().setAttribute("user", user);
	      SessionUtil.loginSession(request, user);
	      model.addAttribute("user", user);

	      return "redirect:/index.html";
	    } catch (AjlException e) {
	      this.log.error("[" + flg + "]" + e.toString());
	      error(model, e);
	    } catch (Throwable e) {
	      this.log.error("[" + flg + "]", e);
	      error(model, AjlException.createErr("5010"));
	    }
	    model.addAttribute("userName", vo.getUserName());
	    return "regist/userreg3";
	  }
}
