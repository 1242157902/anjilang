package com.anjilang.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.controller.base.BaseController;
import com.anjilang.controller.vo.IndexPicVo;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.FriendLink;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.Information;
import com.anjilang.entity.InformationType;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.Picture;
import com.anjilang.entity.Question;
import com.anjilang.entity.SeniorDoctor;
import com.anjilang.entity.SpecCol;
import com.anjilang.entity.User;
import com.anjilang.service.DieticianService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.GroupTopicService;
import com.anjilang.service.InforService;
import com.anjilang.service.InforTypeService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.PictureService;
import com.anjilang.service.QuestionService;
import com.anjilang.service.SeniorDoctorService;
import com.anjilang.service.SpecColService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.ReflectUtil;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.Validator;
import com.anjilang.service.FriendLinkService;

/**
 * @Title: IndexController.java
 * @Package com.anjilang.controller
 * @Description: 首页controller
 * @author linqingsong
 * @date 2015-1-1 下午3:48:14
 * @version V1.0
 */
@Controller
@RequestMapping("index")
public class IndexController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private InforTypeService inforTypeService;
	
	@Autowired
	private InforService inforService;

	@Autowired
	private PictureService pictureService;
	@Autowired
	private UserService userService;
	
	@Autowired
	private DiseaseProjectService diseaseProjectService;
	
	@Autowired
	private QuestionService questionService;
	
	@Autowired
	private FriendLinkService friendLinkService;
	
	@Autowired
	private SeniorDoctorService seniorDoctorService;
	
	@Autowired
	private SpecColService specColService;
	
	@Autowired
	private PatientGroupService  patientGroupService;
	
	@Autowired
	private GroupTopicService groupTopicService;
	
	@Autowired
	private DieticianService dieticianService;
	
	@RequestMapping(value = "toIndex.do", produces = { Constants.PRODUCES })
	public String logout(HttpServletRequest request) {
		SessionUtil.logoutSession(request);
		//return "redirect:/index/index.do";
		return "redirect:/index.html";
	}
	

	/**
	 * 首页信息查询
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "index.do", produces = { "application/json;charset=UTF-8" } /*, method=RequestMethod.POST*/)
	public String index(HttpServletRequest request, Model model)
			throws Exception {
		System.out.println("----------index-------------");

		//1	查询资讯
		List<InformationType> inforTypeList = inforTypeService.queryIndex();
		
		
		for (InformationType informationType : inforTypeList) {
			
		  Long  id=inforService.findBytypeId(informationType.getId());
		  
		  informationType.setUrl("infor/toInforDetail.do?id="+id);
			
			
		}
		
		
		
		
		model.addAttribute("inforTypeList", inforTypeList);
		
		//1	自己添加       查询Hot资讯
		List<Information> inforList = inforService.queryHot() ;
		model.addAttribute("inforList", inforList);
		
		
		//2 table列表
		List<Picture> tablepic = pictureService.query(1);
		model.addAttribute("tablepic", tablepic);
		//3 shop列表
		
		List<Picture> shoppic = pictureService.query(2);
		model.addAttribute("shoppic", shoppic);
		
		
		/*//4	特约医生列表
	 List<Picture> docpic = pictureService.newQuery(3);
		model.addAttribute("docpic", docpic); */
		
		// 分页查询已审核的医生
		PaginationSupport<User> pageUser = userService.queryUserByAudit(
							"2", "1", 4, 1, null, null);
		// 当前页数据
		List<User> userList = pageUser.getItems();
		model.addAttribute("userList", userList); 
		//5 疾病列表
		List<DiseaseProject> diseaseList=diseaseProjectService.queryAll();
		model.addAttribute("diseaseList", diseaseList);
		// 6问题列表
		List<List<Question>> lists = new ArrayList<List<Question>>();
		int i = 0;
		for(DiseaseProject dp : diseaseList) {
			if(dp!=null) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("diseaseId", dp.getId().toString());
				map.put("pageNo","1");
			    PaginationSupport<Question> qs = questionService.queryHotest(map);
			    if(qs.getTotalCount()>0 && qs.getItems()!=null) {
			    	lists.add(qs.getItems());
			    }else {
			    	lists.add(new ArrayList<Question>());
			    }
			}else {
				lists.add(new ArrayList<Question>());
			}
			i++;
			// 最大仅仅取10个
			if(i >= 10) {
				break;
			}
		}
		model.addAttribute("lists", lists);
		
		//7 友情链接
		List<FriendLink> friendList=friendLinkService.query();
		model.addAttribute("friendList", friendList);
		request.getSession().setAttribute("friendList", friendList);
		//8 资深营养师
		PaginationSupport<SeniorDoctor> seniorDoctorPage = seniorDoctorService.queryAll(true, 6, 1);
		model.addAttribute("seniorDoctorList", seniorDoctorPage.getItems());
		
		//9安吉郎专栏
		PaginationSupport<SpecCol> specColPage = specColService.queryAll(true, 4, 1);
		model.addAttribute("specColList", specColPage.getItems());
		
		
		
		//hyh
		List<PatientGroup>  patientGroups=patientGroupService.queryByCount();
		List<User>  groupuser=new ArrayList<User>();
		for (int j = 0; j < patientGroups.size(); j++) {
			groupuser.add(userService.queryUserById(patientGroups.get(j).getUserid()));
		}
		model.addAttribute("patientGroups", patientGroups);
		model.addAttribute("groupuser", groupuser);
		
		//图文推荐文章
		List<GroupTopic>  picTopics=groupTopicService.RecomTopic(1);
		model.addAttribute("picTopics", picTopics);
		//文章推荐
		List<GroupTopic>  artTopics=groupTopicService.RecomTopic(2);
		model.addAttribute("artTopics",artTopics);
		
		
		//最新文章列表
		List<GroupTopic>  newTopics=groupTopicService.queryByNew();
		model.addAttribute("newTopics", newTopics);
		
		// 营养师专栏
		SpecCol spec1=null;
		List<SpecCol> specList=specColService.query();
		for(i=0;i<specList.size();i++){
			spec1=specList.get(i);
			break;
		}
		model.addAttribute("spec",spec1);
		
		return "index";
	}

	/**
	 * 后台添加首页图片
	 * 
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "savepic.do", produces = { Constants.PRODUCES })
	public String savepic(HttpServletRequest request, IndexPicVo vo, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]" + ((vo == null) ? ("null") : (vo.toString())));
		model.addAttribute("type", vo.getType());
		String retStr = "/managers/indexpic/indexTableList";
		try {
			if (1 == vo.getType()) {
				retStr = "/managers/indexpic/indexTableList";
			} else if (2 == vo.getType()) {
				retStr = "/managers/indexpic/indexShopList";
				if(vo.getDiseaseId()==null || vo.getDiseaseId() < 0) {
					log.error("["+flg+"]商城图片必须属于一个疾病");
					throw AjlException.createErr("5001");
				}
			} else if (3 == vo.getType()) {
				retStr = "/managers/indexpic/indexDoctorList";
			}
			Validator.validator(request.getRequestURI(), vo);
			// 跳转到查询页面
			Picture pic = new Picture();
			ReflectUtil.copy(vo, pic, flg);
			pictureService.save(pic);

			success(model);
			return retStr;
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
			error(model, e);
		} catch (Throwable e) {
			log.info("[" + flg + "]", e);
			error(model, AjlException.createErr("5025"));
		}

		return retStr;
	}

	/**
	 * 后台添加首页table图片
	 * 
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "piclist.do", produces = { Constants.PRODUCES })
	public @ResponseBody String piclist(HttpServletRequest request, IndexPicVo vo,
			Integer pageSize, Integer pageNo) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]" + ((vo == null) ? ("null") : (vo.toString())));
		log.info("[" + flg + "]pageNo=" + pageNo + ",pageSiz[" + pageSize + "]");
		try {
			Validator.validator(request.getRequestURI(), vo);
			if (1 == vo.getType()) {
			} else if (2 == vo.getType()) {
			} else if (3 == vo.getType()) {
			} else {
				log.error("[" + flg + "]非法type=" + vo.getType());
				throw AjlException.createErr("5026");
			}
			pageSize = (pageSize!=null && pageSize > 0) ? pageSize : 100;
			pageNo = (pageNo!=null && pageNo > 0) ? pageNo : 1;
			// 跳转到查询页面
			List<Picture> list =  pictureService.query(vo.getType());
			
			JSONArray jSONArray=JSONArray.fromObject(list);
			return jSONArray.toString();
		} catch (AjlException e) {
			log.error("[" + flg + "]" + e.toString());
//			error(model, e);
		} catch (Throwable e) {
			log.info("[" + flg + "]", e);
//			error(model, AjlException.createErr("5027"));
		}
		return new JSONArray().toString();
	}
	
	@RequestMapping(value = "deletepic.do", produces = { Constants.PRODUCES })
	public String deletepic(HttpServletRequest request,Integer type, Model modelv) {
		String retStr;
		if (1 == type) {
			retStr = "/managers/indexpic/indexTableList";
		} else if (2 == type) {
			retStr = "/managers/indexpic/indexShopList";
		} else if (3 == type) {
			retStr = "/managers/indexpic/indexDoctorList";
		} else {
			return "/managers/indexpic/indexTableList";
		}
		
		//1 获取数据
		String[] ids=request.getParameterValues("id");
		//2 删除
		if(ids!=null && ids.length>0){
			for(int i=0;i<ids.length;i++){
				Picture pic  = new Picture();
				pic.setId(Long.parseLong(ids[i]));
				pictureService.delete(pic);
			}
		}
		
		return retStr;
	}
	
	@RequestMapping(value = "toedit.do", produces = { Constants.PRODUCES })
	public String toedit(HttpServletRequest request,  Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		//1 获取数据
		String id=request.getParameter("id");
		String type=request.getParameter("type");
		
		//2 查询
		Picture picture = pictureService.findById(new Long(id));
		model.addAttribute("picture", picture);
		
		String retStr = "/managers/indexpic/editIndexTable";
		
		//3 跳转页面
		if ("1".equals(type)) {
			retStr = "/managers/indexpic/editIndexTable";
		} else if ("2".equals(type)) {
			List<DiseaseProject> list;
			try {
				list = diseaseProjectService.queryAll();
				model.addAttribute("project", list);
			} catch (AjlException e) {
				log.error("["+flg+"]"+e.toString());
				error(model, e);
				return "/managers/indexpic/indexShopList";
			}
			
			retStr = "/managers/indexpic/editIndexShop";
		} else if ("3".equals(type)) {
			retStr = "/managers/indexpic/editIndexDoctor";
		}
		return retStr;
	}
	
	@RequestMapping(value = "editpic.do", produces = { Constants.PRODUCES })
	public String editpic(HttpServletRequest request, IndexPicVo vo,  Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		String retStr = "/managers/indexpic/indexTableList";
		log.info("["+flg+"]" + (vo==null?("null"):vo.toString()));
		try{
			Validator.validator(request.getRequestURI(), vo);
			if (1 == vo.getType()) {
				retStr = "/managers/indexpic/indexTableList";
			} else if (2 == vo.getType()) {
				retStr = "/managers/indexpic/indexShopList";
			} else if (3 == vo.getType()) {
				retStr = "/managers/indexpic/indexDoctorList";
			}
			Picture pic = new Picture();
			ReflectUtil.copy(vo, pic, flg);
			pictureService.update(pic);
		} catch(AjlException e) {
			log.error("["+flg+"]", e);
		} catch(Throwable e) {
			log.error("["+flg+"]", e);
		}
		//3 跳转页面
		return retStr;
	}
}
