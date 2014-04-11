/**
 * UserServiceImpl.java
 */
package com.sizheng.afl.service.impl;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sizheng.afl.base.impl.BaseServiceImpl;
import com.sizheng.afl.component.ApiInvoker;
import com.sizheng.afl.dao.IUserDao;
import com.sizheng.afl.pojo.constant.SysConstant;
import com.sizheng.afl.pojo.entity.BusinessConsumer;
import com.sizheng.afl.pojo.entity.Favorites;
import com.sizheng.afl.pojo.entity.Request;
import com.sizheng.afl.pojo.entity.User;
import com.sizheng.afl.pojo.vo.PageResult;
import com.sizheng.afl.service.IRequestService;
import com.sizheng.afl.service.IUserService;
import com.sizheng.afl.util.DateUtil;
import com.sizheng.afl.util.NumberUtil;
import com.sizheng.afl.util.StringUtil;

/**
 * 【用户】业务逻辑实现.
 * 
 * @creation 2014年03月28日 10:02:03
 * @modification 2014年03月28日 10:02:03
 * @company Skycloud
 * @author xiweicheng
 * @version 1.0
 * 
 */
@Service
@Transactional
public class UserServiceImpl extends BaseServiceImpl implements IUserService {

	private static Logger logger = Logger.getLogger(UserServiceImpl.class);

	@Autowired
	IUserDao userDao;

	@Autowired
	ApiInvoker apiInvoker;

	@Autowired
	IRequestService requestService;

	@Override
	public boolean save(Locale locale, User user) {

		logger.debug("[业务逻辑层]添加【用户】");

		// TODO
		return true;
	}

	@Override
	public boolean delete(Locale locale, User user) {

		logger.debug("[业务逻辑层]删除【用户】");

		// TODO
		return true;
	}

	@Override
	public User get(Locale locale, User user) {

		logger.debug("[业务逻辑层]获取【用户】");

		List list = hibernateTemplate.findByExample(user);

		if (list.size() > 0) {
			return (User) list.get(0);
		} else {
			logger.debug("获取用户不存在!");
		}

		return null;
	}

	@Override
	public boolean update(Locale locale, User user) {

		logger.debug("[业务逻辑层]更新【用户】");

		// TODO
		return true;
	}

	@Override
	public List<User> list(Locale locale) {

		logger.debug("[业务逻辑层]列举【用户】");

		// TODO
		return null;
	}

	@Override
	public List<Map<String, Object>> query(Locale locale, User user) {

		logger.debug("[业务逻辑层]查询【用户】(不分页)");

		// TODO
		return null;
	}

	@Override
	public PageResult paging(Locale locale, User user, Long start, Long limit) {

		logger.debug("[业务逻辑层]查询【用户】(分页)");

		PageResult pageResult = new PageResult();

		// TODO
		return pageResult;
	}

	@Override
	public boolean exists(Locale locale, User user) {

		logger.debug("[业务逻辑层]判断【用户】是否存在");

		// TODO
		return true;
	}

	@Override
	public Double bill(Locale locale, String openId, String consumeCode) {

		User user = new User();
		user.setUserName(openId);

		List list = hibernateTemplate.findByExample(user);

		if (list.size() > 0) {

			User user2 = (User) list.get(0);

			if (StringUtil.isEmpty(user2.getConsumeCode())) {
				return null;
			}

			List<Map<String, Object>> list3 = userDao.queryMenuBill(locale, consumeCode);

			Double val = 0D;

			for (Map<String, Object> map : list3) {

				Double price = NumberUtil.getDouble(map, "price");
				Double privilege = NumberUtil.getDouble(map, "privilege");

				if (privilege != null && privilege < 1 && privilege > 0) {
					val += (price * privilege);
				} else {
					privilege = privilege == null ? 0 : privilege;
					val += (price - privilege);
				}
			}

			user2.setConsumeCode(null);

			hibernateTemplate.update(user2);// 删除关联消费码

			BusinessConsumer businessConsumer = new BusinessConsumer();
			businessConsumer.setConsumeCode(consumeCode);
			businessConsumer.setConsumerId(openId);

			List list2 = hibernateTemplate.findByExample(businessConsumer);

			if (list2.size() > 0) {
				BusinessConsumer businessConsumer2 = (BusinessConsumer) list2.get(0);
				businessConsumer2.setStatus(SysConstant.CONSUME_STATUS_STOP);
				businessConsumer2.setConsumeCode(null);

				hibernateTemplate.update(businessConsumer2);

				return val;
			}
		}

		return null;
	}

	@Override
	public String getBusiness(Locale locale, String openId) {

		User user = new User();
		user.setUserName(openId);

		List list = hibernateTemplate.findByExample(user);

		if (list.size() > 0) {
			String consumeCode = ((User) list.get(0)).getConsumeCode();

			if (consumeCode != null) {
				BusinessConsumer businessConsumer = new BusinessConsumer();
				businessConsumer.setConsumeCode(consumeCode);

				List list2 = hibernateTemplate.findByExample(businessConsumer);

				if (list2.size() > 0) {
					return ((BusinessConsumer) list2.get(0)).getBusinessId();
				} else {
					logger.error("用户消费信息不存在! consumeCode:" + consumeCode);
					return null;
				}
			} else {
				return null;
			}
		} else {
			logger.error("用户不存在! openId:" + openId);
			return null;
		}

	}

	@Override
	public Boolean billReq(Locale locale, String openId, String consumeCode, String type) {

		BusinessConsumer businessConsumer = new BusinessConsumer();
		businessConsumer.setConsumeCode(consumeCode);
		businessConsumer.setStatus((short) 1);
		businessConsumer.setConsumerId(openId);

		List list = hibernateTemplate.findByExample(businessConsumer);

		if (list.size() > 0) {
			BusinessConsumer businessConsumer2 = (BusinessConsumer) list.get(0);

			if (businessConsumer2.getStatus() != 1) {// 只有消费进行中才能申请结账.
				return false;
			}

			if ("own".equals(type)) {
				businessConsumer2.setStatus((short) 3);
				hibernateTemplate.update(businessConsumer2);

				// 顾客实时请求记录
				Request request = new Request();
				request.setBusinessId(businessConsumer2.getBusinessId());
				request.setConsumeCode(businessConsumer2.getConsumeCode());
				request.setConsumerId(businessConsumer2.getConsumerId());
				request.setDateTime(DateUtil.now());
				request.setIsDelete(SysConstant.SHORT_FALSE);
				request.setName("个人结账请求");
				request.setSceneId(Long.valueOf(businessConsumer2.getSceneId()));
				request.setStatus(SysConstant.REQUEST_STATUS_ONGOING);
				request.setType(SysConstant.REQUEST_TYPE_BILL_OWN);

				requestService.save(request);

				return true;

			} else if ("group".equals(type)) {
				businessConsumer2.setStatus((short) 4);
				hibernateTemplate.update(businessConsumer2);

				// 顾客实时请求记录
				Request request = new Request();
				request.setBusinessId(businessConsumer2.getBusinessId());
				request.setConsumeCode(businessConsumer2.getConsumeCode());
				request.setConsumerId(businessConsumer2.getConsumerId());
				request.setDateTime(DateUtil.now());
				request.setIsDelete(SysConstant.SHORT_FALSE);
				request.setName("集体结账请求");
				request.setSceneId(Long.valueOf(businessConsumer2.getSceneId()));
				request.setStatus(SysConstant.REQUEST_STATUS_ONGOING);
				request.setType(SysConstant.REQUEST_TYPE_BILL_GROUP);

				requestService.save(request);

				return true;
			}
		} else {
			logger.error("消费信息不存在!");
		}

		return false;
	}

	@Override
	public boolean store(Locale locale, Favorites favorites) {

		if (SysConstant.FAVORITES_TYPE_BUSINESS_LIKE.equals(favorites.getType())) {
			Favorites favorites2 = new Favorites();
			favorites2.setOpenId(favorites.getOpenId());
			favorites2.setRefId(favorites.getRefId());
			favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_DISLIKE);
			favorites2.setLimitCode(DateUtil.getTodayLimitCode());
			favorites2.setIsDelete(SysConstant.SHORT_FALSE);

			List list2 = hibernateTemplate.findByExample(favorites2);

			if (list2.size() > 0) {
				Favorites favorites3 = (Favorites) list2.get(0);
				favorites3.setType(SysConstant.FAVORITES_TYPE_BUSINESS_LIKE);
				favorites3.setDateTime(DateUtil.now());

				hibernateTemplate.update(favorites3);
			} else {
				favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_LIKE);

				if (hibernateTemplate.findByExample(favorites2).size() > 0) {
					return false;
				}

				favorites2.setDateTime(DateUtil.now());

				hibernateTemplate.save(favorites2);
			}
		} else if (SysConstant.FAVORITES_TYPE_BUSINESS_DISLIKE.equals(favorites.getType())) {
			Favorites favorites2 = new Favorites();
			favorites2.setOpenId(favorites.getOpenId());
			favorites2.setRefId(favorites.getRefId());
			favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_LIKE);
			favorites2.setLimitCode(DateUtil.getTodayLimitCode());
			favorites2.setIsDelete(SysConstant.SHORT_FALSE);

			List list2 = hibernateTemplate.findByExample(favorites2);

			if (list2.size() > 0) {
				Favorites favorites3 = (Favorites) list2.get(0);
				favorites3.setType(SysConstant.FAVORITES_TYPE_BUSINESS_DISLIKE);
				favorites3.setDateTime(DateUtil.now());

				hibernateTemplate.update(favorites3);
			} else {
				favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_DISLIKE);

				if (hibernateTemplate.findByExample(favorites2).size() > 0) {
					return false;
				}

				favorites2.setDateTime(DateUtil.now());

				hibernateTemplate.save(favorites2);
			}
		} else if (SysConstant.FAVORITES_TYPE_BUSINESS.equals(favorites.getType())) {
			Favorites favorites2 = new Favorites();
			favorites2.setOpenId(favorites.getOpenId());
			favorites2.setRefId(favorites.getRefId());
			favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_NOT);
			favorites2.setIsDelete(SysConstant.SHORT_FALSE);

			List list2 = hibernateTemplate.findByExample(favorites2);

			if (list2.size() > 0) {
				Favorites favorites3 = (Favorites) list2.get(0);
				favorites3.setType(SysConstant.FAVORITES_TYPE_BUSINESS);
				favorites3.setDateTime(DateUtil.now());

				hibernateTemplate.update(favorites3);
			} else {
				favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS);

				if (hibernateTemplate.findByExample(favorites2).size() > 0) {
					return false;
				}

				favorites2.setDateTime(DateUtil.now());

				hibernateTemplate.save(favorites2);
			}
		} else if (SysConstant.FAVORITES_TYPE_BUSINESS_NOT.equals(favorites.getType())) {
			Favorites favorites2 = new Favorites();
			favorites2.setOpenId(favorites.getOpenId());
			favorites2.setRefId(favorites.getRefId());
			favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS);
			favorites2.setIsDelete(SysConstant.SHORT_FALSE);

			List list2 = hibernateTemplate.findByExample(favorites2);

			if (list2.size() > 0) {
				Favorites favorites3 = (Favorites) list2.get(0);
				favorites3.setType(SysConstant.FAVORITES_TYPE_BUSINESS_NOT);
				favorites3.setDateTime(DateUtil.now());

				hibernateTemplate.update(favorites3);
			} else {
				favorites2.setType(SysConstant.FAVORITES_TYPE_BUSINESS_NOT);

				if (hibernateTemplate.findByExample(favorites2).size() > 0) {
					return false;
				}

				favorites2.setDateTime(DateUtil.now());

				hibernateTemplate.save(favorites2);
			}
		} else {
			logger.error("不识别收藏类型!");
			return false;
		}

		return true;
	}

	@Override
	public List<Favorites> getFavorites(Locale locale, Favorites favorites) {
		return hibernateTemplate.findByExample(favorites);
	}

	@Override
	public BusinessConsumer getBusinessConsumer(Locale locale, BusinessConsumer businessConsumer) {

		List list = hibernateTemplate.findByExample(businessConsumer);

		return (BusinessConsumer) (list.size() > 0 ? list.get(0) : null);
	}

	@Override
	public long getCount(Locale locale, Favorites favorites) {

		return hibernateTemplate.findByExample(favorites).size();
	}
}