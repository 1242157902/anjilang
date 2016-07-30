package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Comment;
import com.anjilang.entity.ReplyComment;
import com.anjilang.entity.ReplyCommentSort;

/**
 * 评论服务
 * @author Jane
 *
 */
public interface CommentService {
	//查询评论内容；
	public int query(long id);

	public void save(Comment comment);

	public PaginationSupport<Comment> queryPage(Map<String, Object> params,
			String[] order, int pagesize, int pageNo);

	public void saveAnswer(ReplyComment answer);

	public List<ReplyComment> find(Long parentId, Long userId, long parseLong);
	//查询评论回复
	public void getReplyList(List<ReplyCommentSort> replyList,Long parentId,int level);
	
	/**
	 * 
	 * @return:       Comment 
	 * @param id
	 * @return
	 * @throws Exception
	 * <p>Description: 根据id查询评论实体<p>
	 * @date:          2015年8月21日下午4:07:47
	 * @author         ysl
	 */
	public Comment getComment(Long id) throws Exception;
	
	/**
	 * 
	 * @return:       void 
	 * @param comment
	 * @throws Exception
	 * <p>Description: 更新Comment实体信息<p>
	 * @date:          2015年8月21日下午5:09:07
	 * @author         ysl
	 */
	public void updateComment(Comment comment) throws Exception;

	public PaginationSupport<Comment> queryCommentByInforId(long id,
			Integer pageSize, Integer pageNo);
}
