package com.anjilang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Author;
import com.anjilang.entity.Book;
import com.anjilang.entity.Comment;
import com.anjilang.entity.FriendLink;
import com.anjilang.entity.Information;
import com.anjilang.entity.InformationType;
import com.anjilang.entity.Picture;
import com.anjilang.entity.ReplyComment;
import com.anjilang.entity.ReplyCommentSort;
import com.anjilang.entity.Report;
import com.anjilang.entity.SpecCol;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.service.AuthorService;
import com.anjilang.service.BookService;
import com.anjilang.service.CommentService;
import com.anjilang.service.DieticianService;
import com.anjilang.service.FriendLinkService;
import com.anjilang.service.InforTypeService;
import com.anjilang.service.PictureService;
import com.anjilang.service.ReportService;
import com.anjilang.service.SpecColService;
import com.anjilang.service.UserService;


/**   
 * @Title: InforController.java 
 * @Package com.anjilang.controller 
 * @Description: 营养师专栏管理
 * @author linqingsong
 * @date 2015-1-1 下午1:30:00 
 * @version V1.0   
 */
@Controller
@RequestMapping("dietican")
public class DieticanController {
	@Autowired
	private DieticianService dieticianService;
	@Autowired
	private InforTypeService inforTypeService;
	@Autowired
	private PictureService pictureService;
	@Autowired
	private SpecColService specColService;
	@Autowired
	private FriendLinkService friendLinkService;
	@Autowired
	private BookService bookService;
	@Autowired
	private AuthorService authorService;
	@Autowired
	private UserService userService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private ReportService reportService;
	/**
	 * 首页展示；
	 */
	@RequestMapping(value = "index.do", produces = { "application/json;charset=UTF-8" })
	public String pictureInfor(HttpServletRequest request,  Model model) throws Exception{
		
		//查询专栏
			int typeId=0;
			String typeIds=request.getParameter("typeId");
			if(StringUtils.isNotBlank(typeIds)){
				typeId=Integer.parseInt(typeIds);
			}
			int pageNo=1;
			String pageNos=request.getParameter("pageNo");
			if(StringUtils.isNotBlank(pageNos)){
				pageNo=Integer.parseInt(pageNos);
			}
			Map<String, Object> params=new HashMap<String,Object>();
			if(typeId!=0){
				params.put("typeId", typeId);
			}
			String order[]={"id"};
			PaginationSupport<SpecCol> specColPage = specColService.queryPage(params, order, 4, pageNo);
			List<SpecCol> listSpec=specColPage.getItems();
			// 过滤html标签
			for(int i=0;i<listSpec.size();i++){
				SpecCol spec=listSpec.get(i);
				String content=spec.getContent().replaceAll("<.*?>", "").replaceAll("&nbsp;", "").replaceAll("&mdash;", "");
				spec.setContent(content);
			}
			model.addAttribute("specColList",listSpec);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("typeId", typeId);
			model.addAttribute("pageCount", specColPage.getPageCount());
			model.addAttribute("totalCount", specColPage.getTotalCount());
		
		//特约医生列表
		List<Picture> docpic = pictureService.query(3);
		model.addAttribute("docpic", docpic);
		//友情链接
		List<FriendLink> friendList=friendLinkService.query();
		model.addAttribute("friendList", friendList);
		//推荐书籍
		List<Book> bookList=bookService.query();
		model.addAttribute("bookList", bookList);
		//推荐作者
		int TypeId=0;
		String TypeIds=request.getParameter("TypeId");
		if(StringUtils.isNotBlank(TypeIds)){
			TypeId=Integer.parseInt(TypeIds);
		}
		int PageNo=1;
		String PageNos=request.getParameter("PageNo");
		if(StringUtils.isNotBlank(PageNos)){
			PageNo=Integer.parseInt(PageNos);
		}
		Map<String, Object> Params=new HashMap<String,Object>();
		if(TypeId!=0){
			Params.put("TypeId", TypeId);
		}
		String order1[]={"id"};
		PaginationSupport<Author> authorPage=authorService.queryPage(Params, order1, 4, PageNo);;
		model.addAttribute("authorList", authorPage.getItems());
		model.addAttribute("TypeId", TypeId);
		model.addAttribute("PageCount", authorPage.getPageCount());
		model.addAttribute("TotalCount", authorPage.getTotalCount());		
		
		
		return "/dietican/index";
		
	} 
	
	@RequestMapping(value = "articleContent.do", produces = { "application/json;charset=UTF-8" })
	public String articleContent(HttpServletRequest request,Integer pageSize,
			Integer pageNo,  Model model) throws Exception{
		try {
			//1 获取文章ID
			String ids=request.getParameter("id");
					
			//2 查询文章消息
			Information information=dieticianService.findById(Long.parseLong(ids));
				model.addAttribute("information", information);
					
			//3 查询前一条数据
			Information listInformationPrev=dieticianService.queryPrev(Long.parseLong(ids));
				model.addAttribute("informationPrev", listInformationPrev);
			
					
			//4 查询后一条数据 
			Information listInformationNext=dieticianService.queryNext(Long.parseLong(ids));
				model.addAttribute("informationNext", listInformationNext);
			
					
					
			//查询当前文章所属分类
				InformationType informationType=inforTypeService.findById(new Long(information.getTypeId()));
				model.addAttribute("informationType", informationType);
				
			//查询作者信息
			Author author=authorService.findById(new Long(information.getAuthorId()));
			model.addAttribute("author", author);
					
			//推荐作者
				List<Author> authorList=authorService.queryOtherAuthor(new Long(information.getAuthorId()));
				model.addAttribute("authorList", authorList);
				
			//特约医生列表
				List<Picture> docpic = pictureService.query(3);
				model.addAttribute("docpic", docpic);
			
			//查询评论
				/*int typeId=0;
				String typeIds=request.getParameter("typeId");
				if(StringUtils.isNotBlank(typeIds)){
					typeId=Integer.parseInt(typeIds);
				}
				int pageNo=1;
				String pageNos=request.getParameter("pageNo");
				if(StringUtils.isNotBlank(pageNos)){
					pageNo=Integer.parseInt(pageNos);
				}
				Map<String, Object> params=new HashMap<String,Object>();
				if(typeId!=0){
					params.put("typeId", typeId);
				}
				String order[]={"id"};
				PaginationSupport<Comment> comPage = commentService.queryPage(params, order, 3, pageNo);
				List<Comment> listSpec=comPage.getItems();
				// 过滤html标签
				for(int i=0;i<listSpec.size();i++){
					Comment com=listSpec.get(i);
					String content=com.getContent().replaceAll("<.*?>", "").replaceAll("&nbsp;", "").replaceAll("&mdash;", "");
					com.setContent(content);
				}
				model.addAttribute("listSpec",listSpec);
				model.addAttribute("typeId", typeId);
				model.addAttribute("pageNo", pageNo);
				model.addAttribute("pageCount", comPage.getPageCount());
				model.addAttribute("totalCount", comPage.getTotalCount());*/
				
				pageSize = (pageSize == null) ? 3 : pageSize;
				pageNo = (pageNo == null) ? 1 : pageNo;
				PaginationSupport<Comment> comPage=commentService.queryCommentByInforId(Long.parseLong(ids), pageSize, pageNo);
				List<Comment> listSpec=comPage.getItems();
				//
				List<ReplyCommentSort> replyList=new ArrayList<ReplyCommentSort>();
				
				commentService.getReplyList(replyList, 9l, 0);
				
				model.addAttribute("comList", replyList);
				model.addAttribute("listSpec",listSpec);
				model.addAttribute("pageNo", pageNo);
				model.addAttribute("pageCount", comPage.getPageCount());
				model.addAttribute("totalCount", comPage.getTotalCount());
				
				//查询专栏最热文章
			List<SpecCol> specColList = specColService.query();
			model.addAttribute("specColList", specColList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/dietican/showContent";
	}
	
	@RequestMapping(value="addReport")
	public void addReport(Long repid,String reason,String reasondetail)throws Exception{
		Report report = new Report();
		report.setReason(reason);
		report.setReasonDetail(reasondetail);
		report.setReportDate(new Date());
		report.setFormtable("comment");
		if (repid != null) {
			TopicReply topicReply = new TopicReply();
			topicReply.setId(repid);
			report.setTopicReply(topicReply);
			Comment	 comment = commentService.getComment(repid);
			if (comment !=null) {
				report.setContent(comment.getContent());
			}
		}
		reportService.addReport(report);
	}
	
}
