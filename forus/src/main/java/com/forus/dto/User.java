package com.forus.dto;

public class User {
	private Integer id;
	private String email;
	private String password;
	private String name;
	private String nickname;
	private String phone;
	private String birthday;
	private String gender;
	private String address;
	private String picture;
	private Integer ishospital;
	
	public User() {
		super();
	}
	
	public User(String email, String password, String name, String nickname, String phone, String birthday,
			String gender, String address, String picture, Integer ishospital) {
		super();
		this.email = email;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.birthday = birthday;
		this.gender = gender;
		this.address = address;
		this.picture = picture;
		this.ishospital = ishospital;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public Integer getIshospital() {
		return ishospital;
	}
	public void setIshospital(Integer ishospital) {
		this.ishospital = ishospital;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", password=" + password + ", name=" + name + ", nickname="
				+ nickname + ", phone=" + phone + ", birthday=" + birthday + ", gender=" + gender + ", address="
				+ address + ", picture=" + picture + ", ishospital=" + ishospital + "]";
	}
}
