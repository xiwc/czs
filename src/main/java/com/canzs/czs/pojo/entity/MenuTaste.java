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
 * MenuTaste generated by hbm2java
 */
@Entity
@Table(name = "menu_taste", catalog = "czs")
public class MenuTaste implements java.io.Serializable {

	private Long id;
	private String name;
	private String owner;
	private Short isDelete;
	private Date dateTime;

	public MenuTaste() {
	}

	public MenuTaste(String name, String owner, Short isDelete, Date dateTime) {
		this.name = name;
		this.owner = owner;
		this.isDelete = isDelete;
		this.dateTime = dateTime;
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

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "owner")
	public String getOwner() {
		return this.owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	@Column(name = "is_delete")
	public Short getIsDelete() {
		return this.isDelete;
	}

	public void setIsDelete(Short isDelete) {
		this.isDelete = isDelete;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_time", length = 19)
	public Date getDateTime() {
		return this.dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

}
