/**
 * ServiceDaoImpl.java
 */
package com.sizheng.afl.dao.impl;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sizheng.afl.base.impl.BaseDaoImpl;
import com.sizheng.afl.dao.IServiceDao;
import com.sizheng.afl.pojo.entity.Service;

/**
 * 【呼叫服务】持久化实现层.
 * 
 * @creation 2014年04月23日 08:28:44
 * @modification 2014年04月23日 08:28:44
 * @company Skycloud
 * @author xiweicheng
 * @version 1.0
 * 
 */
@Repository
@Transactional
public class ServiceDaoImpl extends BaseDaoImpl implements IServiceDao {

	@Override
	public List<Map<String, Object>> query(Locale locale, Service service, Long start, Long limit) {
		
		// TODO
		
		return null;
	}

	@Override
	public long queryCount(Locale locale, Service service) {
	
		// TODO
	
		return 0L;
	}
	
}