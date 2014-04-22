/**
 * BusinessDaoImpl.java
 */
package com.sizheng.afl.dao.impl;

import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sizheng.afl.base.impl.BaseDaoImpl;
import com.sizheng.afl.dao.IBusinessDao;
import com.sizheng.afl.pojo.entity.Business;
import com.sizheng.afl.pojo.entity.BusinessConsumer;
import com.sizheng.afl.pojo.entity.BusinessRole;
import com.sizheng.afl.util.DateUtil;
import com.sizheng.afl.util.NumberUtil;
import com.sizheng.afl.util.SqlUtil;
import com.sizheng.afl.util.StringUtil;

/**
 * 【商家】持久化实现层.
 * 
 * @creation 2014年03月25日 02:46:32
 * @modification 2014年03月25日 02:46:32
 * @company Skycloud
 * @author xiweicheng
 * @version 1.0
 * 
 */
@Repository
@Transactional
public class BusinessDaoImpl extends BaseDaoImpl implements IBusinessDao {

	@Override
	public List<Map<String, Object>> query(Locale locale, Business business, Long start, Long limit) {

		// TODO

		return null;
	}

	@Override
	public long queryCount(Locale locale, Business business) {

		// TODO

		return 0L;
	}

	@Override
	public List<Map<String, Object>> listCustomer(Locale locale, Business business, String status, Boolean filterOver) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	business_consumer.consumer_id,\n");
		sqlSb.append("	business_consumer.consume_times,\n");
		sqlSb.append("	DATE_FORMAT(business_consumer.last_consume_time,  '%Y/%m/%d %H:%i:%s') as last_consume_time,\n");
		sqlSb.append("	TIMESTAMPDIFF(SECOND,business_consumer.last_consume_time,NOW()) as sec_diff,\n");
		sqlSb.append("	business_consumer.scene_id,\n");
		sqlSb.append("	business_consumer.consume_code,\n");
		sqlSb.append("	business_consumer.`status`,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	subscriber.sex,\n");
		sqlSb.append("	subscriber.headimgurl,\n");
		sqlSb.append("	subscriber.city,\n");
		sqlSb.append("	subscriber.country,\n");
		sqlSb.append("	subscriber.province,\n");
		sqlSb.append("	subscriber.`language`,\n");
		sqlSb.append("	qrcode.description\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	business_consumer\n");
		sqlSb.append("LEFT JOIN qrcode ON business_consumer.scene_id = qrcode.scene_id\n");
		sqlSb.append("LEFT JOIN subscriber ON business_consumer.consumer_id = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	business_consumer.business_id = ?\n");

		sqlSb.append(SqlUtil.replaceIfNotEmpty("AND business_consumer.`status` = {?1}\n", status));

		if (filterOver != null && filterOver) {
			sqlSb.append("AND business_consumer.`status` <> 0\n");
		}

		return getMapList(sqlSb, business.getOpenId());
	}

	@Override
	public List<Map<String, Object>> queryGroupInfo(Locale locale, BusinessConsumer businessConsumer) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	business_consumer.consumer_id,\n");
		sqlSb.append("	business_consumer.consume_times,\n");
		sqlSb.append("	DATE_FORMAT(business_consumer.last_consume_time,  '%Y/%m/%d %H:%i:%s') as last_consume_time,\n");
		sqlSb.append("	TIMESTAMPDIFF(SECOND,business_consumer.last_consume_time,NOW()) as sec_diff,\n");
		sqlSb.append("	business_consumer.consume_code,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	IF(subscriber.sex = 1, '男', IF(subscriber.sex = 2, '女', '未知')) as sex,\n");
		sqlSb.append("	subscriber.city,\n");
		sqlSb.append("	subscriber.country,\n");
		sqlSb.append("	subscriber.province,\n");
		sqlSb.append("	subscriber.headimgurl\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	business_consumer\n");
		sqlSb.append("INNER JOIN subscriber ON business_consumer.consumer_id = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	business_consumer.scene_id = ?\n");
		sqlSb.append("AND business_consumer.`status` In (1,3,4)\n");

		return getMapList(sqlSb, businessConsumer.getSceneId());
	}

	@Override
	public double getConsume(Locale locale, String consumeCode) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	menu_bill.copies,\n");
		sqlSb.append("	menu.price,\n");
		sqlSb.append("	menu.privilege\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	menu_bill\n");
		sqlSb.append("INNER JOIN menu ON menu_bill.menu_id = menu.id\n");
		sqlSb.append("INNER JOIN user ON menu_bill.consume_code = user.consume_code\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	menu_bill.consume_code = ?\n");
		sqlSb.append("AND menu_bill.`status` IN (1,3)\n");

		List<Map<String, Object>> mapList = getMapList(sqlSb, consumeCode);
		double val = 0;

		for (Map<String, Object> map : mapList) {
			Double price = NumberUtil.getDouble(map, "price");
			Double privilege = NumberUtil.getDouble(map, "privilege");
			Double copies = NumberUtil.getDouble(map, "copies");

			if (privilege != null && privilege > 0) {
				if (privilege >= 1) {
					val += (price - privilege) * copies;
				} else {
					val += (price * privilege) * copies;
				}
			} else {
				val += (price) * copies;
			}
		}

		return val;
	}

	@Override
	public double getTotalConsume(Locale locale, String sceneId) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	menu_bill.copies,\n");
		sqlSb.append("	menu.price,\n");
		sqlSb.append("	menu.privilege\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	menu_bill\n");
		sqlSb.append("INNER JOIN menu ON menu_bill.menu_id = menu.id\n");
		sqlSb.append("INNER JOIN user ON menu_bill.consume_code = user.consume_code\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	menu_bill.consume_code IN (SELECT business_consumer.consume_code FROM `business_consumer` WHERE business_consumer.scene_id = ?)\n");
		sqlSb.append("AND menu_bill.`status` IN (1,3)\n");

		List<Map<String, Object>> mapList = getMapList(sqlSb, sceneId);
		double val = 0;

		for (Map<String, Object> map : mapList) {
			Double price = NumberUtil.getDouble(map, "price");
			Double privilege = NumberUtil.getDouble(map, "privilege");
			Double copies = NumberUtil.getDouble(map, "copies");

			if (privilege != null && privilege > 0) {
				if (privilege >= 1) {
					val += (price - privilege) * copies;
				} else {
					val += (price * privilege) * copies;
				}
			} else {
				val += (price) * copies;
			}
		}

		return val;
	}

	@Override
	public long getGroupSize(Locale locale, String consumeCode) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	COUNT(*) AS cnt\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	business_consumer\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	scene_id = (\n");
		sqlSb.append("		SELECT\n");
		sqlSb.append("			business_consumer.scene_id\n");
		sqlSb.append("		FROM\n");
		sqlSb.append("			`business_consumer`\n");
		sqlSb.append("		WHERE\n");
		sqlSb.append("			business_consumer.consume_code = ?\n");
		sqlSb.append("	)\n");

		return getCount(sqlSb, consumeCode);
	}

	@Override
	public Map<String, Object> getConsumer(Locale locale, String openId) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	subscriber.id,\n");
		sqlSb.append("	subscriber.user_name,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	IF(subscriber.sex = 1, '男', IF(subscriber.sex = 2, '女', '未知')) as sex,\n");
		sqlSb.append("	subscriber.city,\n");
		sqlSb.append("	subscriber.country,\n");
		sqlSb.append("	subscriber.province,\n");
		sqlSb.append("	subscriber.`language`,\n");
		sqlSb.append("	subscriber.headimgurl,\n");
		sqlSb.append("	business_consumer.consume_times,\n");
		sqlSb.append("	DATE_FORMAT(business_consumer.last_consume_time,  '%Y/%m/%d %H:%i:%s') as last_consume_time,\n");
		sqlSb.append("	business_consumer.`status`,\n");
		sqlSb.append("	business_consumer.consume_code,\n");
		sqlSb.append("	qrcode.description\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	subscriber\n");
		sqlSb.append("INNER JOIN business_consumer ON subscriber.user_name = business_consumer.consumer_id\n");
		sqlSb.append("LEFT JOIN qrcode ON business_consumer.scene_id = qrcode.scene_id\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	subscriber.user_name = ?\n");

		return getMap(sqlSb, openId);
	}

	@Override
	public List<Map<String, Object>> queryRequest(Locale locale, String openId) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	request.id,\n");
		sqlSb.append("	request.`name`,\n");
		sqlSb.append("	request.consumer_id,\n");
		sqlSb.append("	request.business_id,\n");
		sqlSb.append("	request.consume_code,\n");
		sqlSb.append("	request.scene_id,\n");
		sqlSb.append("	request.type,\n");
		sqlSb.append("	DATE_FORMAT(request.date_time,'%Y/%m/%d %H:%i:%s') AS date_time,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	IF (subscriber.sex = 1,'男',IF (subscriber.sex = 2,'女','未知')) AS sex,\n");
		sqlSb.append(" subscriber.headimgurl,\n");
		sqlSb.append(" request.`status`\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	request\n");
		sqlSb.append("LEFT JOIN subscriber ON request.consumer_id = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	request.`status` = 1\n");
		sqlSb.append("AND request.is_delete = 0\n");
		sqlSb.append("AND request.business_id = ?\n");
		sqlSb.append("ORDER BY request.date_time DESC\n");

		return getMapList(sqlSb, openId);
	}

	@Override
	public List<Map<String, Object>> listMgrRoles(Locale locale, BusinessRole businessRole) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	business_role.id,\n");
		sqlSb.append("	business_role.business_id,\n");
		sqlSb.append("	business_role.open_id,\n");
		sqlSb.append("	business_role.type,\n");
		sqlSb.append("	business_role.is_delete,\n");
		sqlSb.append("  DATE_FORMAT(business_role.date_time,  '%Y/%m/%d %H:%i:%s') as date_time,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	IF(subscriber.sex = 1, '男', IF(subscriber.sex = 2, '女', '未知')) as sex,\n");
		sqlSb.append("	subscriber.city,\n");
		sqlSb.append("	subscriber.country,\n");
		sqlSb.append("	subscriber.province,\n");
		sqlSb.append("	subscriber.headimgurl\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	business_role\n");
		sqlSb.append("LEFT JOIN subscriber ON business_role.open_id = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	business_role.business_id = ?\n");
		sqlSb.append("AND business_role.is_delete = 0\n");

		sqlSb.append(SqlUtil.replaceIfNotEmpty("AND business_role.type = {?1}\n", businessRole.getType()));

		return getMapList(sqlSb, businessRole.getBusinessId());
	}

	@Override
	public List<Map<String, Object>> menuGraph(Locale locale, String openId) {
		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	menu.id,\n");
		sqlSb.append("	menu.`name`,\n");
		sqlSb.append("	menu.order_times\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	menu\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	menu.`owner` = ?\n");
		sqlSb.append("AND menu.is_delete = 0\n");

		return getMapList(sqlSb, openId);
	}

	@Override
	public List<Map<String, Object>> menuDayGraph(Locale locale, String openId, String menuId) {
		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	menu.`name`,\n");
		sqlSb.append("	date(menu_bill.date_time) AS date,\n");
		sqlSb.append("	SUM(copies) AS copies\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	menu\n");
		sqlSb.append("INNER JOIN menu_bill ON menu.id = menu_bill.menu_id\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	menu.`owner` = ?\n");
		sqlSb.append("AND menu_bill.`status` = 3\n");
		sqlSb.append("AND menu.id = ?\n");
		sqlSb.append("GROUP BY\n");
		sqlSb.append("	date\n");

		return getMapList(sqlSb, openId, menuId);
	}

	@Override
	public List<Map<String, Object>> billDayGraph(Locale locale, String openId) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	date(date_time) AS date,\n");
		sqlSb.append("	sum(amount) AS num\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	bill\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	bill.business_id = ?\n");
		sqlSb.append("GROUP BY\n");
		sqlSb.append("	date(date_time)\n");

		return getMapList(sqlSb, openId);
	}

	@Override
	public List<Map<String, Object>> volumeDayGraph(String openId, String date) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	price,\n");
		sqlSb.append("	`name`,\n");
		sqlSb.append("	menu_bill.menu_id,\n");
		sqlSb.append("	SUM(copies) copies,\n");
		sqlSb.append("	price * SUM(copies) AS total\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	menu_bill\n");
		sqlSb.append("INNER JOIN menu ON menu_bill.menu_id = menu.id\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	menu.`owner` = ?\n");
		sqlSb.append("AND DATE(menu_bill.date_time) = ?\n");
		sqlSb.append("GROUP BY\n");
		sqlSb.append("	menu_id\n");

		return getMapList(sqlSb, openId, date);
	}

	@Override
	public List<Map<String, Object>> serviceGraph(String openId) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	DATE(service.date_time) AS date,\n");
		sqlSb.append("	COUNT(*) AS cnt\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	service\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	service.business_id = ?\n");
		sqlSb.append("AND service.`status` = 0\n");
		sqlSb.append("AND service.is_delete = 0\n");
		sqlSb.append("GROUP BY\n");
		sqlSb.append("	date\n");

		return getMapList(sqlSb, openId);
	}

	@Override
	public List<Map<String, Object>> serviceDayGraph(String openId, String date) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	Count(*) AS total,\n");
		sqlSb.append("	subscriber.nickname as name\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	service\n");
		sqlSb.append("LEFT JOIN subscriber ON service.`handler` = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	service.business_id = ?\n");
		sqlSb.append("AND service.`status` = 0\n");
		sqlSb.append("AND service.is_delete = 0\n");
		sqlSb.append("AND DATE(service.date_time) = ?\n");
		sqlSb.append("GROUP BY\n");
		sqlSb.append("	`handler`\n");

		return getMapList(sqlSb, openId, date);
	}

	@Override
	public List<Map<String, Object>> queryCustomerMsg(Locale locale, String openId, Date sDate, Date eDate,
			String... status) {

		StringBuffer sqlSb = new StringBuffer();
		sqlSb.append("SELECT\n");
		sqlSb.append("	message.id,\n");
		sqlSb.append("	message.from_user_name,\n");
		sqlSb.append("	message.msg_type,\n");
		sqlSb.append("	message.content,\n");
		sqlSb.append("	message.msg_id,\n");
		sqlSb.append("	message.pic_url,\n");
		sqlSb.append("	DATE_FORMAT(message.date_time,  '%Y/%m/%d %H:%i:%s') as date_time,\n");
		sqlSb.append("	TIMESTAMPDIFF(SECOND,message.date_time,NOW()) as sec_diff,\n");
		sqlSb.append("	message.`status`,\n");
		sqlSb.append("	subscriber.nickname,\n");
		sqlSb.append("	IF(subscriber.sex = 1, '男', IF(subscriber.sex = 2, '女', '未知')) as sex,\n");
		sqlSb.append("	subscriber.headimgurl\n");
		sqlSb.append("FROM\n");
		sqlSb.append("	message\n");
		sqlSb.append("INNER JOIN subscriber ON message.from_user_name = subscriber.user_name\n");
		sqlSb.append("WHERE\n");
		sqlSb.append("	message.to_open_id = ?\n");

		sqlSb.append(SqlUtil.replaceIfNotEmpty("AND message.`status` IN ({?1})\n", SqlUtil.joinAsIntIn2(status)));

		sqlSb.append("AND (\n");
		sqlSb.append("	msg_type = 'text'\n");
		sqlSb.append("	OR msg_type = 'image'\n");
		sqlSb.append(")\n");

		if (sDate != null && eDate != null) {
			sqlSb.append(StringUtil.replace("AND (message.date_time between '{?1}' and '{?2}')\n",
					DateUtil.format(sDate, DateUtil.FORMAT1), DateUtil.format(eDate, DateUtil.FORMAT1)));
		}

		return getMapList(sqlSb, openId);
	}
}
