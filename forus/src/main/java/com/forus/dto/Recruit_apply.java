package com.forus.dto;

public class Recruit_apply {
	private Integer apply_id;
	private Integer user_id;
	private Integer	post_id;
	private String apply_time;
	private String apply_title;
	private String apply_content;
	private String apply_status;
	
	public Recruit_apply() {
		super();
	}
	public Recruit_apply(String apply_time, String apply_title, String apply_content, String apply_status) {
		super();
		this.apply_time = apply_time;
		this.apply_title = apply_title;
		this.apply_content = apply_content;
		this.apply_status = apply_status;
	}
	
	public Integer getApply_id() {
		return apply_id;
	}
	public void setApply_id(Integer apply_id) {
		this.apply_id = apply_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getPost_id() {
		return post_id;
	}
	public void setPost_id(Integer post_id) {
		this.post_id = post_id;
	}
	public String getApply_time() {
		return apply_time;
	}
	public void setApply_time(String apply_time) {
		this.apply_time = apply_time;
	}
	public String getApply_title() {
		return apply_title;
	}
	public void setApply_title(String apply_title) {
		this.apply_title = apply_title;
	}
	public String getApply_content() {
		return apply_content;
	}
	public void setApply_content(String apply_content) {
		this.apply_content = apply_content;
	}
	public String getApply_status() {
		return apply_status;
	}
	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}
	
	@Override
	public String toString() {
		return "Recruit_apply [apply_id=" + apply_id + ", user_id=" + user_id + ", post_id=" + post_id + ", apply_time="
				+ apply_time + ", apply_title=" + apply_title + ", apply_content=" + apply_content + ", apply_status="
				+ apply_status + "]";
	}
}
