package com.canzs.czs.pojo.entity;

// Generated 2014-5-12 20:25:46 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Service generated by hbm2java
 */
@Entity
@Table(name = "service", catalog = "czs")
public class Service implements java.io.Serializable {

	private Long id;
	private String consumerId;
	private String businessId;
	private Date dateTime;
	private Short type;
	private Short status;
	private Short isDelete;
	private String handler;
	private Short appraise;
	private Long sceneId;
	private Date handleDateTime;

	public Service() {
	}

	public Service(String consumerId, String businessId, Date dateTime, Short type, Short status, Short isDelete,
			String handler, Short appraise, Long sceneId, Date handleDateTime) {
		this.consumerId = consumerId;
		this.businessId = businessId;
		this.dateTime = dateTime;
		this.type = type;
		this.status = status;
		this.isDelete = isDelete;
		this.handler = handler;
		this.appraise = appraise;
		this.sceneId = sceneId;
		this.handleDateTime = handleDateTime;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "consumer_id")
	public String getConsumerId() {
		return this.consumerId;
	}

	public void setConsumerId(String consumerId) {
		this.consumerId = consumerId;
	}

	@Column(name = "business_id")
	public String getBusinessId() {
		return this.businessId;
	}

	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_time", length = 19)
	public Date getDateTime() {
		return this.dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	@Column(name = "type")
	public Short getType() {
		return this.type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	@Column(name = "status")
	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	@Column(name = "is_delete")
	public Short getIsDelete() {
		return this.isDelete;
	}

	public void setIsDelete(Short isDelete) {
		this.isDelete = isDelete;
	}

	@Column(name = "handler")
	public String getHandler() {
		return this.handler;
	}

	public void setHandler(String handler) {
		this.handler = handler;
	}

	@Column(name = "appraise")
	public Short getAppraise() {
		return this.appraise;
	}

	public void setAppraise(Short appraise) {
		this.appraise = appraise;
	}

	@Column(name = "scene_id")
	public Long getSceneId() {
		return this.sceneId;
	}

	public void setSceneId(Long sceneId) {
		this.sceneId = sceneId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "handle_date_time", length = 19)
	public Date getHandleDateTime() {
		return this.handleDateTime;
	}

	public void setHandleDateTime(Date handleDateTime) {
		this.handleDateTime = handleDateTime;
	}

}
