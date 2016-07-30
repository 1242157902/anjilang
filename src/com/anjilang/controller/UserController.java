package com.anjilang.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.controller.vo.RegistVo;
import com.anjilang.entity.City;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.DoctorType;
import com.anjilang.entity.Picture;
import com.anjilang.entity.User;
import com.anjilang.service.ArticleInfoService;
import com.anjilang.service.CityService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.DoctorTypeService;
import com.anjilang.service.PictureService;
import com.anjilang.service.QuestionService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.DateUtil;
import com.anjilang.util.HttpUtils;
import com.anjilang.util.ImageUtils;
import com.anjilang.util.Mail;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.ReflectUtil;
import com.anjilang.util.Response;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.StringUtil;
import com.anjilang.util.Validator;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private UserService userService;
	@Autowired
	private DiseaseProjectService diseaseProjectService;
	@Autowired
	private DoctorTypeService doctorTypeService;
	@Autowired
	private CityService cityService;
	@Autowired
	private DiseaseProjectService projectService;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private ArticleInfoService articleInfoService;
	@Autowired
	private PictureService pictureService;
	
	private static final String ECSHOP_MODIFY_URL = "http://www.angelaround.com/shop/user.php?act=act_edit_password&laiyuan=wcm";

	/**
	 * 找回密码 充值密码和发邮件
	 * 
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "findpwd.do", produces = { Constants.PRODUCES })
	public String findpwd(HttpServletRequest request, RegistVo vo, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]" + (vo != null ? vo.toString() : "null"));

		try {
			Validator.validator(request.getRequestURI(), vo);
			String userName = vo.getUserName();
			List<User> uList = userService.queryUserByUserName(userName);
			if (uList == null || uList.size() < 1 || uList.get(0) == null) {
				log.error("[" + flg + "]用户不存在userName=" + userName);
				throw AjlException.createErr("5017");
			}
			// 重置密码
			User user = uList.get(0);
			String random = StringUtil.getRandomNum(6);
			user.setPassword(random);
			log.info("[" + flg + "]random=" + random);
			userService.update(user);
			// 发邮件
			//SendEmail se = new SendEmail();
			Mail mail=new Mail();
			StringBuffer content = new StringBuffer();
			String url = PropertyUtil.newInstans().getValue("url");
			log.info("[" + flg + "]工程地址:" + url);
			content.append("安吉郎用户找回密码,密码已重置为:"+random+".建议立刻修改密码.<a href=\""+url+"login/login.jsp\">点击进行登录</a>");
			//se.doSendHtmlEmail("注册邮箱验证", content, userName);
			mail.sendMessage(userName, "重置密码", content.toString());
			String suffix = userName.substring(userName.lastIndexOf("@") + 1);
			model.addAttribute("mailUrl", "http://mail." + suffix);
			
			success(model);
			model.addAttribute("msg", "密码已重置,请登录邮箱:"+userName+"查看");
//			return "redirect:/index/index.do";
		} catch (AjlException e) {
			log.error("[" + flg + "]找回密码失败" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]找回密码失败", e);
			error(model, AjlException.createErr("5021"));
		}
		return "forgetpassword";
	}
	
	/**
	 * 
	 * @param oldpwd
	 * @param newpwd
	 * @return
	 */
	@RequestMapping(value="modifypwd.do", produces={Constants.PRODUCES})
	public String modifypwd(HttpServletRequest request, String oldpwd, String newpwd, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		JSONObject req = new JSONObject();
		req.put("oldpwd", oldpwd);
		req.put("newpwd", newpwd);
		log.info("[" + flg + "]" + req.toJSONString());

		try {
			Validator.validator(request.getRequestURI(), req);
			User user = (User)request.getSession().getAttribute("user");
			User u = userService.queryUserById(user.getId());
			if(!oldpwd.equals(u.getPassword())) {
				log.error("["+flg+"]修改密码-旧密码与原密码匹配失败");
				throw AjlException.createErr("5024");
			}
			u.setPassword(newpwd);
			userService.update(user);
			
			success(model);
			model.addAttribute("msg", "密码修改成功");
		} catch (AjlException e) {
			log.error("[" + flg + "]找回密码失败" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]找回密码失败", e);
			error(model, AjlException.createErr("5021"));
		}
		return "forgetpassword";
	}
	
	/**
	 * 
	 * @param oldpwd
	 * @param newpwd
	 * @return
	 */
	@RequestMapping(value="doctor.do", produces={Constants.PRODUCES})
	public @ResponseBody String doctor(HttpServletRequest request, String audit) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]audit["+audit+"]");

		try {
			if(StringUtil.isEmpty(audit)) {
				log.error("["+flg+"]审核状态为空");
			}
			List<User> userList = userService.queryUserByAudit(audit, "1");
			if(userList!=null && userList.size() > 0) {
				JSONArray arr = JSONArray.fromObject(userList);
				return arr.toString();
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]查询医生失败" + e.toString());
		} catch (Throwable e) {
			log.error("[" + flg + "]查询医生失败", e);
		}
		return new JSONArray().toString();
	}
	
	/**
	 * 修改用户审核状态
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toaudit.do", produces={Constants.PRODUCES})
	public String toaudit(HttpServletRequest request, Long id, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]id["+id+"]");
		try{
			User user = userService.queryUserById(id);
			if(user != null) {
				List<Long> pidList = dealProject(user.getProject(), flg);
				
				String pStr = "";
				for(Long projectId : pidList) {
					DiseaseProject dp = diseaseProjectService.findById(projectId);
					if(dp!=null && StringUtil.isNotEmpty(dp.getDiseaseName())) {
						pStr += dp.getDiseaseName() + "、";
					}
				}
				List<DoctorType> doctorTypeList = doctorTypeService.queryAll();
				City p = cityService.queryById(user.getProvince());
				City c = cityService.queryById(user.getProvince());
				String regAddr = "";
				if(p!=null && StringUtil.isNotEmpty(p.getCityName())) {
					regAddr = p.getCityName();
				}
				if(StringUtil.isNotEmpty(regAddr)) {
					if(c!=null && StringUtil.isNotEmpty(c.getCityName())) {
						regAddr += "." + c.getCityName();
					}
				} else {
					if(c!=null && StringUtil.isNotEmpty(c.getCityName())) {
						regAddr +=  c.getCityName();
					}
				}
				model.addAttribute("regDateTime", DateUtil.formatDate1(user.getCreateTime()));
				model.addAttribute("birth", DateUtil.formatDate3(user.getBirthday()));
				model.addAttribute("regAddr", regAddr);
				model.addAttribute("pStr", pStr);
				model.addAttribute("user", user);
				model.addAttribute("doctorTypeList", doctorTypeList);
				return "/managers/audit/editdoctor";
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]查询医生失败" + e.toString());
		} catch (Throwable e) {
			log.error("[" + flg + "]查询医生失败", e);
		}
		return "/managers/audit/doctorlist";
	}
	
	/**
	 * 处理
	 * @param project
	 * @param flg
	 * @return
	 */
	private List<Long> dealProject(String project, String flg) {
		List<Long> pidList = new ArrayList<Long>();
		try {
			// 去掉的第一个逗号和最后一个逗号
			project = project.substring(1,project.length()-1);
			String[] pArr = project.split(",");
			
			for(String p : pArr) {
				try{
					pidList.add(Long.parseLong(p));
				}catch(Exception e){} 
			}
		} catch(Exception e) {
			log.error("["+flg+"]解析project失败", e);
		}
		return pidList;
	}
	
	
	/**
	 * 修改用户审核状态
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="audit.do", produces={Constants.PRODUCES})
	public String audit(HttpServletRequest request, Long id, String audit, Long doctorType, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]id["+id+"]audit["+audit+"]doctorType["+doctorType+"]");
		try{
			User user = userService.queryUserById(id);
			if(user != null && (",1,2,").contains(","+audit+",")) {
				user.setAudit(audit);
				user.setDoctorType(doctorType);
				userService.update(user);
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]查询医生失败" + e.toString());
		} catch (Throwable e) {
			log.error("[" + flg + "]查询医生失败", e);
		}
		return "/managers/audit/doctorlist";
	}
	
	/**
	 * 删除用户
	 * @param request
	 * @param ids
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="delete.do", produces={Constants.PRODUCES})
	public String delete(HttpServletRequest request, Model model) {
		String[] ids = request.getParameterValues("id");
		userService.delete(ids);
		return "/managers/audit/doctorlist";
	}
	
	
	/**
	 * 修改账号信息
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "setAccountMod.do", produces = { "application/json;charset=UTF-8" })
	public String setAccountMod(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User user=(User)request.getSession().getAttribute("user");
		
		if (user!=null) 
		{
			//2 查询用户信息
			User users=userService.queryUserById(user.getId());
			model.addAttribute("user", users);
		}
		//3 跳转页面
		return "/account/accountMod";
	}
	
	/**
	 * 修改账号密码
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "setAccountPwd.do", produces = { "application/json;charset=UTF-8" })
	public String setAccountPwd(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User user=(User)request.getSession().getAttribute("user");
		
		//2 查询用户信息
		User users=userService.queryUserById(user.getId());
		model.addAttribute("user", users);
		
		//3 跳转页面
		return "/account/accountPwd";
	}
	
	/**
	 * 修改账号头像
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "setAccountHead.do", produces = { "application/json;charset=UTF-8" })
	public String setAccountHead(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User user=(User)request.getSession().getAttribute("user");
		
		//2 查询用户信息
		if (user == null) {
			return null ;
		}
		User users=userService.queryUserById(user.getId());
		model.addAttribute("user", users);
		
		//3 跳转页面
		return "/account/accountHead";
	}
	
	/**
	 * 修改医生账号信息
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "setAccountDocMod.do", produces = { "application/json;charset=UTF-8" })
	public String setAccountDocMod(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User user=(User)request.getSession().getAttribute("user");
		
		//2 查询用户信息
		User users=userService.queryUserById(user.getId());
		model.addAttribute("user", users);
		//3 查询疾病项目信息
		List<DiseaseProject> projectList=diseaseProjectService.queryAll();
		model.addAttribute("projectList", projectList);
		
		//3 跳转页面
		return "/account/accountDocMod";
	}
	
	/**
	 * 修改医生资料
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "accountDocMod.do", produces = { "application/json;charset=UTF-8" })
	public String accountDocMod(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User user=(User)request.getSession().getAttribute("user");
		String education=request.getParameter("education");
		String eduExperience=request.getParameter("eduExperience");
		String resume=request.getParameter("resume");
		String []project=request.getParameterValues("p");
		//2 修改用户信息
		User users=userService.queryUserById(user.getId());
		users.setEducation(education);
		users.setEduExperience(eduExperience);
		users.setResume(resume);
		
		if(project!=null && project.length>0){
			String projects=",";
			
			for(int i=0;i<project.length;i++){
				projects+=project[i]+",";
			}
			users.setProject(projects);
		}
		userService.update(users);
		
		model.addAttribute("user", users);
		
		//3 查询疾病项目信息
		List<DiseaseProject> projectList=diseaseProjectService.queryAll();
		model.addAttribute("projectList", projectList);
		model.addAttribute("message", "修改成功");
		//4 跳转页面
		return "/account/accountDocMod";
	}
	
	/**
	 * 修改账号信息
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "accountMod.do", produces = { "application/json;charset=UTF-8" })
	public String accountMod(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User users=(User)request.getSession().getAttribute("user");
		String realName=request.getParameter("realName");
		String sex=request.getParameter("sex");
		String birStr=request.getParameter("birStr");
		String addr=request.getParameter("addr");
		String signature=request.getParameter("signature");
		
		
		//2 查询用户信息
		User user=userService.queryUserById(users.getId());
		
		//3 修改用户信息
		if(StringUtils.isNotBlank(realName)){
			user.setRealName(realName);
		}
		if(StringUtils.isNotBlank(sex)){
			user.setSex(sex);
		}
		if(StringUtils.isNotBlank(birStr)){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date date=sdf.parse(birStr);
			user.setBirthday(date);
		}
		if(StringUtils.isNotBlank(addr)){
			user.setAddr(addr);
		}
		if(StringUtils.isNotBlank(signature)){
			user.setSignature(signature);
		}
		
		userService.update(user);
		model.addAttribute("user", user);
		model.addAttribute("message", "修改成功");
		//3 跳转页面
		return "/account/accountMod";
	}
	
	
	/**
	 * 修改账号头像
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "accountHead.do", produces = { "application/json;charset=UTF-8" })
	public String accountHead(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User users=(User)request.getSession().getAttribute("user");
		String picture=request.getParameter("picture");
		//2 查询用户信息
		User user=userService.queryUserById(users.getId());
		
		//3 修改用户头像
		user.setHeader(picture);
		
		userService.update(user);
		model.addAttribute("user", user);
		model.addAttribute("message", "修改成功");
		
		request.getSession().setAttribute("user", user);
		SessionUtil.loginSession(request, user);
		//3 跳转页面
		return "/account/accountHead";
	}
	/**
	 * 修改账号头像
	 * @param request
	 * @param model
	 * @param File
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "accountHeadNew.do", produces = { "application/json;charset=UTF-8" })
	public String accountHeadNew(HttpServletRequest request,  Model model,
			@RequestParam("file") CommonsMultipartFile file,String path) throws Exception {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		String uri  = "";
		log.info("[" + flg + "]上传图片" + path);
	//	String dir = request.getRealPath("") + "/";//D:\软件\tomcat\apache-tomcat-7.0.23\webapps\anjilang/
	
	String dirPath = "upload/"
				+ ((StringUtil.isEmpty(path)) ? "" : (path + "/"))
				+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");

	@SuppressWarnings("deprecation")
		String dir = request.getRealPath("") + "/";
		dir += dirPath;
		File f = new File(dir);
		if (!f.exists()) { // 如果不存在则创建目录
			f.mkdirs();
		}

		int fileSize = (int) file.getSize();// 图片大小
		file.getName();//
		// TODO XXX 处理图片大小限制与图片后缀限制
		if (fileSize > 2097152)
		{
			return null;
		}
		JSONObject json = new JSONObject();
		// 访问图片地址
		String url = PropertyUtil.newInstans().getValue("url");
		try {
			String fileName = flg + ".png";
			ImageUtils.saveFile(file.getInputStream(), dir, fileName);
			uri = dirPath + fileName;
			// 图片相对路径用于存入数据库
			json.put("path", uri);
			json.put("url", url + dirPath + fileName);
			success(json);
		} catch (AjlException e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, AjlException.createErr("5020"));
		}
		log.info("[" + flg + "]" + json.toJSONString());
		
		
		
		//1 获取数据
		User users=(User)request.getSession().getAttribute("user");
		//String picture=request.getParameter("picture");
		//2 查询用户信息
		User user=userService.queryUserById(users.getId());
		
		//3 修改用户头像
		user.setHeader(uri);
		
		userService.update(user);
		model.addAttribute("user", user);
		model.addAttribute("message", "修改成功");
		model.addAttribute("headPath", url+uri);
		request.getSession().setAttribute("user", user);
		SessionUtil.loginSession(request, user);
		//3 跳转页面
		return "/account/accountHead";
	}
	
	/**
	 * 修改账号密码
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "accountPwd.do", produces = { "application/json;charset=UTF-8" })
	public String accountPwd(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		User users=(User)request.getSession().getAttribute("user");
		
		String nowPwd=request.getParameter("nowPwd");
		String newPwd=request.getParameter("newPwd");
		String retPwd=request.getParameter("retPwd");
		
		if(!newPwd.equals(retPwd)){
			model.addAttribute("message", "2次输入密码不匹配");
			return "/account/accountPwd";
		}
		
		//2 查询用户信息
		User user=userService.queryUserById(users.getId());
		if(!user.getPassword().equals(nowPwd)){
			model.addAttribute("message", "原始密码不匹配");
			return "/account/accountPwd";
		}
		
		//3 修改用户密码
		user.setPassword(newPwd);
		
		userService.update(user);
		
		//4.同步修改ecshop的用户密码
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("old_password", nowPwd);
		param.put("new_password ", newPwd);
		param.put("username", users.getUserName());
		try {
			Response response = HttpUtils.post(ECSHOP_MODIFY_URL, null, null, param);	
			String result = response.getResponseBodyAsTrimStr();
			Response response2 =  com.alibaba.fastjson.JSONObject.parseObject(result, Response.class);
			
			String code = response2.getCode();
			String msg = response2.getMessage();
			if(code!=null & !code.equals("1")){
				log.error("user modify password to ecshop error,username is[" + users.getUserName()
						+ "]", new Throwable("code is " + code
						+ ",error message is[" + msg + "]"));			
				}		
			
		}catch(Exception e){
			log.error("user modify password to ecshop error,username is[" + users.getUserName()
					+ "]", e);
		}
		
		model.addAttribute("user", user);
		model.addAttribute("message", "修改成功");
		//3 跳转页面
		return "/account/accountPwd";
	}
	
	/**
	 * 获取个人资料
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toPersonData.do", produces = { "application/json;charset=UTF-8" })
	public String queryUser(HttpServletRequest request,  Model model) throws Exception {
		String id = request.getParameter("id");
		//1 获取banner图片
		List<Picture> list=pictureService.query(4);
		if(list!=null && list.size()>0){
			int num=(int)(Math.random()*list.size());
			model.addAttribute("topPic", list.get(num).getPicUrl());
		}
		String userIds = request.getParameter("id");
		Long userId = Long.parseLong(userIds);
		User user = userService.queryUserById(userId);
		City city = cityService.queryById(user.getCity());
		City province = cityService.queryById(user.getProvince());
		List<DiseaseProject> projects = projectService.queryById(user.getProject().split(","));
		model.addAttribute("user", user);
		model.addAttribute("city", city);
		model.addAttribute("province", province);
		if(projects== null || projects.size()==0){
			model.addAttribute("isProjectNot", "1");
		}else{
			model.addAttribute("projects", projects);
		}
		Long answerNum = questionService.queryAnswerNum(userId);
		Map<String,String> maps = new HashMap<String,String>();
		maps.put("userId", userIds);
		model.addAttribute("answerNum",answerNum==null?0:answerNum);
		model.addAttribute("articleNum",articleInfoService.queryCount(maps));
		model.addAttribute("agreeNum",userService.getTotelAgreeNum(userId));
		
		//3 跳转页面
		return "personPage/personData";
	}
	
	
	/**
	 * 查询普通用户
	 * @param request
	 * @return
	 * @throws AjlException 
	 */
	@RequestMapping(value="queryUserOrdinary.do", produces={Constants.PRODUCES})
	public @ResponseBody String queryUserOrdinary(HttpServletRequest request) throws AjlException {
			List<User> users=this.userService.queryUserByAudit(null, "2");
			JSONArray jSONArray=JSONArray.fromObject(users);
			return jSONArray.toString();
	}
	
	/**
	 * 后台注册(普通用户)
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

			return "/managers/user/list";
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
			error(model, AjlException.createErr("5010"));
		}
		model.addAttribute("userName", vo.getUserName());
		return "/managers/user/list";
	}
	
	/**
	 * 设置管理员(普通用户)
	 * 
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 * @throws AjlException 
	 * @throws NumberFormatException 
	 */
	@RequestMapping(value = "toEditManager.do", produces = { Constants.PRODUCES })
	public String toEditManager(HttpServletRequest request, RegistVo vo,
			Model model) throws NumberFormatException, AjlException {
		String id=request.getParameter("id");
		User user=userService.queryUserById(new Long(id));
		user.setType("3");
		userService.update(user);
		
		return "/managers/user/list";
	}
}
