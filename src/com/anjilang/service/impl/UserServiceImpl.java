package com.anjilang.service.impl;

import com.anjilang.dao.AnswerDao;
import com.anjilang.dao.UserDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.User;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.StringUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl
  implements UserService
{
  private Logger log = Logger.getLogger(super.getClass());

  @Autowired
  private UserDao userDao;

  @Autowired
  private AnswerDao answerDao;

  @Transactional
  public void save(User user)
    throws AjlException
  {
    this.log.info("保存用户:" + user.toString());
    List dList = queryUserByUserName(user.getUserName());
    if ((dList != null) && (dList.size() > 0)) {
      this.log.error("userName=" + user.getUserName() + "已存在");
      throw AjlException.createErr("5007");
    }
    try {
      this.userDao.save(user);
    } catch (Exception e) {
      this.log.error("userName=" + user.getUserName() + "保存失败", e);
      throw AjlException.createErr("5008");
    }
  }

  public List<User> queryUserByUserName(String userName) throws AjlException
  {
    try
    {
      this.log.info("查询用户userName=" + userName);
      String hql = "FROM User WHERE userName = '" + userName + "' or real_name='"+userName+"' or phone='"+userName+"' ORDER BY createTime desc";
      return this.userDao.find(hql);
    } catch (Exception e) {
      this.log.error("根据用户名查询用户失败userName=" + userName, e);
      throw AjlException.createErr("5006");
    }
  }

  public User queryUserById(Long id) throws AjlException
  {
    try {
      this.log.info("查询用户id=" + id);
      return ((User)this.userDao.get(id));
    } catch (Exception e) {
      this.log.error("根据id查询用户失败id=" + id, e);
      throw AjlException.createErr("5006");
    }
  }

  @Transactional
  public void update(User user) throws AjlException
  {
    this.log.info("修改用户:" + user.toString());
    try {
      this.userDao.update(user);
    } catch (Exception e) {
      this.log.error("id=" + user.getId() + "修改失败", e);
      throw AjlException.createErr("5022");
    }
  }

  public List<User> queryUserByAudit(String audit, String type) throws AjlException
  {
    try {
      this.log.info("查询用户audit[" + audit + "]type[" + type + "]");
      String hql = "FROM User WHERE 1=1";
      if (StringUtil.isNotEmpty(new String[] { audit }))
        hql = hql + " AND audit = '" + audit + "'";

      hql = hql + " AND type='" + type + "' ORDER BY createTime desc";
      return this.userDao.find(hql);
    } catch (Exception e) {
      this.log.error("根据用户名查询用户失败[" + audit + "]type[" + type + "]", e);
      throw AjlException.createErr("5006");
    }
  }

  public PaginationSupport<User> queryUserByAudit(String audit, String type, int pageSize, int pageNo, Long provinceId, Long projectId)
  {
    pageSize = (pageSize < 0) ? 5 : pageSize;
    pageNo = (pageNo < 0) ? 1 : pageNo;
    Map params = new HashMap();
    params.put("type", type);
    if (StringUtil.isNotEmpty(new String[] { audit })) {
      params.put("audit", audit);
    }

    Map paramsLikes = new HashMap();
    if (provinceId != null)
      params.put("province", provinceId);

    if (projectId != null) {
      paramsLikes.put("project", "%," + projectId + ",%");
    }

    return this.userDao.queryPage(params, paramsLikes, new String[] { "createTime" }, pageSize, pageNo);
  }

  public int getTotelAnswerNum(long userId)
  {
    Object[] values = new Object[0];

    String hql = "from Answer a where a.user.id = ?";
    values = ArrayUtils.add(values, Long.valueOf(userId));

    List list = this.answerDao.find(hql, values);
    if ((list != null) && (list.size() > 0)) {
      return list.size();
    }

    return 0;
  }

  public int getTotelAgreeNum(long userId)
  {
    Object[] values = new Object[0];
    String hql = "from Answer a where a.user.id = ?";
    values = ArrayUtils.add(values, Long.valueOf(userId));
    List list = this.answerDao.find(hql, values);

    int totelNum = 0;
    if ((list != null) && (list.size() > 0))
      for (int i = 0; i < list.size(); ++i) {
        Answer answer = (Answer)list.get(i);
        int num = answer.getAgreeNum();
        totelNum += num;
      }


    return totelNum;
  }

  public PaginationSupport<User> queryTopAnswerUser(int pageSize, int pageNo)
  {
    Map params = new HashMap();
    params.put("type", "1");
    return this.userDao.queryPage(params, new String[] { "answerNum" }, pageSize, pageNo);
  }

  @Transactional
  public void delete(String[] ids)
  {
    if (ids != null) {
      List uList = new ArrayList();
      for (String id : ids)
        if (id != null)
          try {
           Long  uid = Long.valueOf(Long.parseLong(id));
            User u = new User();
            u.setId(uid);
            uList.add(u);
          }
          catch (Exception uid) {
          }
      this.userDao.deleteAll(uList);
    }
  }

  public User queryByQQId(String qqId)
  {
    Object[] values = { qqId };
    String hql = "from User where qqOpenId = ? order by id desc";
    List list = this.userDao.find(hql, values);
    if ((list != null) && (list.size() > 0))
      return ((User)list.get(0));

    return null;
  }

  public User queryByWeiBoUid(String uid)
  {
    Object[] values = { uid };
    String hql = "from User where weiboUid = ? order by id desc";
    List list = this.userDao.find(hql, values);
    if ((list != null) && (list.size() > 0))
      return ((User)list.get(0));

    return null;
  }

  public List<User> queryUserByPhone(String phone) throws AjlException
  {
    try {
      this.log.info("查询用户userName=" + phone);
      String hql = "FROM User WHERE phone = '" + phone + "' ORDER BY createTime desc";
      return this.userDao.find(hql);
    } catch (Exception e) {
      this.log.error("根据用户名查询用户失败phone=" + phone, e);
      throw AjlException.createErr("5006");
    }
  }

}