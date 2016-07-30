package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.AnswerCommentDao;
import com.anjilang.dao.CommentDao;
import com.anjilang.dao.ReplyCommentDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.AnswerComment;
import com.anjilang.entity.Comment;
import com.anjilang.entity.ReplyComment;
import com.anjilang.entity.ReplyCommentSort;
import com.anjilang.service.CommentService;
import com.anjilang.util.DateUtil;
@Service
public class CommentServiceImpl implements CommentService {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommentDao Dao;
	@Autowired
	private ReplyCommentDao  replyCommentDao;
	@Override
	@Transactional
	public int query(long id) {
		return 0;
	}

	@Override
	public void save(Comment comment) {
		Dao.saveOrUpdate(comment);
	}

	@Override
	public PaginationSupport<Comment> queryPage(Map<String, Object> params,
			String[] order, int pagesize, int pageNo) {
		return	Dao.queryPage(params, order, pagesize, pageNo);
	}

	@Override
	public void saveAnswer(ReplyComment answer) {
		replyCommentDao.save(answer);
		
	}

	@Override
	public List<ReplyComment> find(Long parentId, Long userId, long parseLong) {
		Object [] values={parentId,userId,parseLong};
		String hql="from ReplyComment r where r.parentId=? and r.userId=? and r.inforId=?";
		return replyCommentDao.find(hql, values);
		
	}

	@Override
	public void getReplyList(List<ReplyCommentSort> replyList, Long parentId,
			int level) {
		ReplyCommentSort bean=null;
		ReplyComment bean1=null;
		List<ReplyComment> list=new ArrayList<ReplyComment>();
		List<ReplyCommentSort> list1=new ArrayList<ReplyCommentSort>();
		String hql="from ReplyComment where parentId="+parentId+"";
		try{
			
			
		list=replyCommentDao.find(hql);
		
		
		
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				bean=new ReplyCommentSort(); //不new的话就是没有分配空间；
				bean1=list.get(i);
				bean.setContent(bean1.getContent());
				bean.setCrTime(DateUtil.formatDate3(bean1.getCrTime()));
				bean.setNickname(bean1.getNickname());
				bean.setLevel(level+1);
				replyList.add(bean);
				getReplyList(replyList,bean.getId(),level+1);
			}
		}else{
			level--;
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	@Override
	public Comment getComment(Long id) throws Exception {
		return Dao.get(id);
	}

	@Override
	public void updateComment(Comment comment) throws Exception {
			Dao.update(comment);
	}

	@Override
	public PaginationSupport<Comment> queryCommentByInforId(long id,
			Integer pageSize, Integer pageNo) {
		pageSize = (pageSize == null) ? 3 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		return  Dao.queryCommentByInforId(id, pageSize, pageNo);
	}

}
