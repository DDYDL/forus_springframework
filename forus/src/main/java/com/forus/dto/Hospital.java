package com.forus.dto;

import java.time.LocalTime;

import java.time.LocalTime;

public class Hospital {
	private Integer h_id;
	private Integer user_id;
	private String h_exponent_name;
	private Integer h_num;
	private String h_license;
	private String h_name;
	private String h_manager_name;
	private String h_phone;
	private String h_address;
	private String h_longitude;
	private String h_latitude;
	private String h_animal_type;
	private String h_picture;
	private String h_memo;
	private String h_memo_road;
	private String h_pay; //checkbox 전부 분리 
	private String h_sns;
	private Boolean h_parking;
	private Boolean h_isopen;
	private LocalTime h_lunch_time_start;
	private LocalTime h_lunch_time_end;
	private Integer h_interval_time;

	public Hospital() {
	}

	public Integer getH_id() {
		return h_id;
	}

	public void setH_id(Integer h_id) {
		this.h_id = h_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getH_exponent_name() {
		return h_exponent_name;
	}

	public void setH_exponent_name(String h_exponent_name) {
		this.h_exponent_name = h_exponent_name;
	}

	public Integer getH_num() {
		return h_num;
	}

	public void setH_num(Integer h_num) {
		this.h_num = h_num;
	}

	public String getH_license() {
		return h_license;
	}

	public void setH_license(String h_license) {
		this.h_license = h_license;
	}

	public String getH_name() {
		return h_name;
	}

	public void setH_name(String h_name) {
		this.h_name = h_name;
	}

	public String getH_manager_name() {
		return h_manager_name;
	}

	public void setH_manager_name(String h_manager_name) {
		this.h_manager_name = h_manager_name;
	}

	public String getH_phone() {
		return h_phone;
	}

	public void setH_phone(String h_phone) {
		this.h_phone = h_phone;
	}

	public String getH_address() {
		return h_address;
	}

	public void setH_address(String h_address) {
		this.h_address = h_address;
	}

	public String getH_longitude() {
		return h_longitude;
	}

	public void setH_longitude(String h_longitude) {
		this.h_longitude = h_longitude;
	}

	public String getH_latitude() {
		return h_latitude;
	}

	public void setH_latitude(String h_latitude) {
		this.h_latitude = h_latitude;
	}

	public String getH_animal_type() {
		return h_animal_type;
	}

	public void setH_animal_type(String h_animal_type) {
		this.h_animal_type = h_animal_type;
	}

	public String getH_picture() {
		return h_picture;
	}

	public void setH_picture(String h_picture) {
		this.h_picture = h_picture;
	}

	public String getH_memo() {
		return h_memo;
	}

	public void setH_memo(String h_memo) {
		this.h_memo = h_memo;
	}

	public String getH_memo_road() {
		return h_memo_road;
	}

	public void setH_memo_road(String h_memo_road) {
		this.h_memo_road = h_memo_road;
	}

	public String getH_pay() {
		return h_pay;
	}

	public void setH_pay(String h_pay) {
		this.h_pay = h_pay;
	}

	public String getH_sns() {
		return h_sns;
	}

	public void setH_sns(String h_sns) {
		this.h_sns = h_sns;
	}

	public Boolean getH_parking() {
		return h_parking;
	}

	public void setH_parking(Boolean h_parking) {
		this.h_parking = h_parking;
	}

	public Boolean getH_isopen() {
		return h_isopen;
	}

	public void setH_isopen(Boolean h_isopen) {
		this.h_isopen = h_isopen;
	}

	public LocalTime getH_lunch_time_start() {
		return h_lunch_time_start;
	}

	public void setH_lunch_time_start(LocalTime h_lunch_time_start) {
		this.h_lunch_time_start = h_lunch_time_start;
	}

	public LocalTime getH_lunch_time_end() {
		return h_lunch_time_end;
	}

	public void setH_lunch_time_end(LocalTime h_lunch_time_end) {
		this.h_lunch_time_end = h_lunch_time_end;
	}

	public Integer getH_interval_time() {
		return h_interval_time;
	}

	public void setH_interval_time(Integer h_interval_time) {
		this.h_interval_time = h_interval_time;
	}

	// h_id�� user_id瑜� �젣�쇅�븳 �깮�꽦�옄
	public Hospital(String h_exponent_name, Integer h_num, String h_license, String h_name,
		String h_manager_name, String h_phone, String h_address, String h_longitude,
		String h_latitude, String h_animal_type, String h_picture, String h_memo,
		String h_memo_road, String h_pay, String h_sns, Boolean h_parking,
		Boolean h_isopen, LocalTime h_lunch_time_start, LocalTime h_lunch_time_end,
		Integer h_interval_time) {
		this.h_exponent_name = h_exponent_name;
		this.h_num = h_num;
		this.h_license = h_license;
		this.h_name = h_name;
		this.h_manager_name = h_manager_name;
		this.h_phone = h_phone;
		this.h_address = h_address;
		this.h_longitude = h_longitude;
		this.h_latitude = h_latitude;
		this.h_animal_type = h_animal_type;
		this.h_picture = h_picture;
		this.h_memo = h_memo;
		this.h_memo_road = h_memo_road;
		this.h_pay = h_pay;
		this.h_sns = h_sns;
		this.h_parking = h_parking;
		this.h_isopen = h_isopen;
		this.h_lunch_time_start = h_lunch_time_start;
		this.h_lunch_time_end = h_lunch_time_end;
		this.h_interval_time = h_interval_time;
	}

	public java.lang.String toString() {
		return "Hospital{" +
			"h_id=" + h_id +
			", user_id=" + user_id +
			", h_exponent_name='" + h_exponent_name + '\'' +
			", h_num=" + h_num +
			", h_license='" + h_license + '\'' +
			", h_name='" + h_name + '\'' +
			", h_manager_name='" + h_manager_name + '\'' +
			", h_phone='" + h_phone + '\'' +
			", h_address='" + h_address + '\'' +
			", h_longitude=" + h_longitude +
			", h_latitude=" + h_latitude +
			", h_animal_type='" + h_animal_type + '\'' +
			", h_picture='" + h_picture + '\'' +
			", h_memo='" + h_memo + '\'' +
			", h_memo_road='" + h_memo_road + '\'' +
			", h_pay='" + h_pay + '\'' +
			", h_sns='" + h_sns + '\'' +
			", h_parking=" + h_parking +
			", h_isopen=" + h_isopen +
			", h_lunch_time_start=" + h_lunch_time_start +
			", h_lunch_time_end=" + h_lunch_time_end +
			", h_interval_time=" + h_interval_time +
			'}';
	}
}
