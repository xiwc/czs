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
 * Qrcode generated by hbm2java
 */
@Entity
@Table(name = "qrcode", catalog = "czs")
public class Qrcode implements java.io.Serializable {

	private Long id;
	private String openId;
	private Long sceneId;
	private Long useLimit;
	private Long useTimes;
	private Long categoryId;
	private String ticket;
	private String url;
	private String filePath;
	private String type;
	private String myUrl;
	private String description;
	private Date dateTime;
	private Short status;
	private Short isDelete;

	public Qrcode() {
	}

	public Qrcode(String openId, Long sceneId, Long useLimit, Long useTimes, Long categoryId, String ticket,
			String url, String filePath, String type, String myUrl, String description, Date dateTime, Short status,
			Short isDelete) {
		this.openId = openId;
		this.sceneId = sceneId;
		this.useLimit = useLimit;
		this.useTimes = useTimes;
		this.categoryId = categoryId;
		this.ticket = ticket;
		this.url = url;
		this.filePath = filePath;
		this.type = type;
		this.myUrl = myUrl;
		this.description = description;
		this.dateTime = dateTime;
		this.status = status;
		this.isDelete = isDelete;
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

	@Column(name = "open_id")
	public String getOpenId() {
		return this.openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	@Column(name = "scene_id")
	public Long getSceneId() {
		return this.sceneId;
	}

	public void setSceneId(Long sceneId) {
		this.sceneId = sceneId;
	}

	@Column(name = "use_limit")
	public Long getUseLimit() {
		return this.useLimit;
	}

	public void setUseLimit(Long useLimit) {
		this.useLimit = useLimit;
	}

	@Column(name = "use_times")
	public Long getUseTimes() {
		return this.useTimes;
	}

	public void setUseTimes(Long useTimes) {
		this.useTimes = useTimes;
	}

	@Column(name = "category_id")
	public Long getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	@Column(name = "ticket", length = 1000)
	public String getTicket() {
		return this.ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	@Column(name = "url", length = 1000)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "file_path", length = 1000)
	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	@Column(name = "type", length = 50)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "my_url", length = 1000)
	public String getMyUrl() {
		return this.myUrl;
	}

	public void setMyUrl(String myUrl) {
		this.myUrl = myUrl;
	}

	@Column(name = "description", length = 1000)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_time", length = 19)
	public Date getDateTime() {
		return this.dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
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

}
