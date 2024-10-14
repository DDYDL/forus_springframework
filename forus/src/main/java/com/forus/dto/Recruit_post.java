package com.forus.dto;

public class Recruit_post {
	private Integer post_id;
	private Integer user_id;
	private Integer pet_id;
	private String post_time;
	private String post_title;
	private String post_content;
	private String post_address;
	private String post_form;
	private String post_pay;
	private String post_date;
	private String post_start_time;
	private String post_end_time;
	private String post_status;
	
	public Recruit_post() {
		super();
	}
	public Recruit_post(String post_time, String post_title, String post_content, String post_address, String post_form,
			String post_pay, String post_date, String post_start_time, String post_end_time, String post_status) {
		super();
		this.post_time = post_time;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_address = post_address;
		this.post_form = post_form;
		this.post_pay = post_pay;
		this.post_date = post_date;
		this.post_start_time = post_start_time;
		this.post_end_time = post_end_time;
		this.post_status = post_status;
	}

	public Integer getPost_id() {
		return post_id;
	}
	public void setPost_id(Integer post_id) {
		this.post_id = post_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getPet_id() {
		return pet_id;
	}
	public void setPet_id(Integer pet_id) {
		this.pet_id = pet_id;
	}
	public String getPost_time() {
		return post_time;
	}
	public void setPost_time(String post_time) {
		this.post_time = post_time;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public String getPost_address() {
		return post_address;
	}
	public void setPost_address(String post_address) {
		this.post_address = post_address;
	}
	public String getPost_form() {
		return post_form;
	}
	public void setPost_form(String post_form) {
		this.post_form = post_form;
	}
	public String getPost_pay() {
		return post_pay;
	}
	public void setPost_pay(String post_pay) {
		this.post_pay = post_pay;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	public String getPost_start_time() {
		return post_start_time;
	}
	public void setPost_start_time(String post_start_time) {
		this.post_start_time = post_start_time;
	}
	public String getPost_end_time() {
		return post_end_time;
	}
	public void setPost_end_time(String post_end_time) {
		this.post_end_time = post_end_time;
	}
	public String getPost_status() {
		return post_status;
	}
	public void setPost_status(String post_status) {
		this.post_status = post_status;
	}
	
	@Override
	public String toString() {
		return "Recruit_post [post_id=" + post_id + ", user_id=" + user_id + ", pet_id=" + pet_id + ", post_time="
				+ post_time + ", post_title=" + post_title + ", post_content=" + post_content + ", post_address="
				+ post_address + ", post_form=" + post_form + ", post_pay=" + post_pay + ", post_date=" + post_date
				+ ", post_start_time=" + post_start_time + ", post_end_time=" + post_end_time + ", post_status="
				+ post_status + "]";
	}
}
