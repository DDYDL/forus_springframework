package com.forus.dto;

import java.time.LocalDateTime;

public class Hospital_qna {
	private Integer qna_id;


	private Integer user_id;
	private Integer h_id;
	private String q_writer;
	private String q_title;
	private String q_time;
	private String a_title;
	private LocalDateTime a_time;

	public Hospital_qna() {
		super();
	}

	public Hospital_qna(String q_title, String q_time, String a_title, LocalDateTime a_time) {
		super();
		this.q_title = q_title;
		this.q_time = q_time;
		this.a_title = a_title;
		this.a_time = a_time;
	}



	public Integer getQna_id() {
		return qna_id;
	}

	public void setQna_id(Integer qna_id) {
		this.qna_id = qna_id;
	}
	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getQ_writer() {
		return q_writer;
	}

	public void setQ_writer(String q_writer) {
		this.q_writer = q_writer;
	}

	public Integer getH_id() {
		return h_id;
	}

	public void setH_id(Integer h_id) {
		this.h_id = h_id;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_time() {
		return q_time;
	}

	public void setQ_time(String q_time) {
		this.q_time = q_time;
	}

	public String getA_title() {
		return a_title;
	}

	public void setA_title(String a_title) {
		this.a_title = a_title;
	}

	public LocalDateTime getA_time() {
		return a_time;
	}

	public void setA_time(LocalDateTime a_time) {
		this.a_time = a_time;
	}

	@Override
	public String toString() {
		return "Hospital_qna{" +
			"qna_id=" + qna_id +
			", user_id=" + user_id +
			", h_id=" + h_id +
			", q_writer='" + q_writer + '\'' +
			", q_title='" + q_title + '\'' +
			", q_time='" + q_time + '\'' +
			", a_title='" + a_title + '\'' +
			", a_time=" + a_time +
			'}';
	}
}
