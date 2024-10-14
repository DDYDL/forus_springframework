package com.forus.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class Reservation {
	private Integer reservId;
	private Integer userId;
	private Integer petId;
	private Integer hId;
	private LocalDate reservDate;
	private LocalTime reservTime;
	private String reservApplyTime;
	private String reservContent;
	private String reservStatus;
	private String reservMemo;

	public Reservation() {
		super();
	}

	// 생성자에서 자동 생성 또는 외부에서 가져오는 필드 제거
	public Reservation(LocalDate reservDate, LocalTime reservTime, String reservApplyTime,
		String reservContent, String reservStatus, String reservMemo) {
		this.reservDate = reservDate;
		this.reservTime = reservTime;
		this.reservApplyTime = reservApplyTime;
		this.reservContent = reservContent;
		this.reservStatus = reservStatus;
		this.reservMemo = reservMemo;
	}


	public Integer getReservId() {
		return reservId;
	}

	public void setReservId(Integer reservId) {
		this.reservId = reservId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getPetId() {
		return petId;
	}

	public void setPetId(Integer petId) {
		this.petId = petId;
	}

	public Integer gethId() {
		return hId;
	}

	public void sethId(Integer hId) {
		this.hId = hId;
	}

	public LocalDate getReservDate() {
		return reservDate;
	}

	public void setReservDate(LocalDate reservDate) {
		this.reservDate = reservDate;
	}

	public LocalTime getReservTime() {
		return reservTime;
	}

	public void setReservTime(LocalTime reservTime) {
		this.reservTime = reservTime;
	}

	public String getReservApplyTime() {
		return reservApplyTime;
	}

	public void setReservApplyTime(String reservApplyTime) {
		this.reservApplyTime = reservApplyTime;
	}

	public String getReservContent() {
		return reservContent;
	}

	public void setReservContent(String reservContent) {
		this.reservContent = reservContent;
	}

	public String getReservStatus() {
		return reservStatus;
	}

	public void setReservStatus(String reservStatus) {
		this.reservStatus = reservStatus;
	}

	public String getReservMemo() {
		return reservMemo;
	}

	public void setReservMemo(String reservMemo) {
		this.reservMemo = reservMemo;
	}

	public java.lang.String toString() {
		return "Reservation{" +
			"reservId=" + reservId +
			", userId=" + userId +
			", petId=" + petId +
			", hId=" + hId +
			", reservDate=" + reservDate +
			", reservTime=" + reservTime +
			", reservApplyTime='" + reservApplyTime + '\'' +
			", reservContent='" + reservContent + '\'' +
			", reservStatus='" + reservStatus + '\'' +
			", reservMemo='" + reservMemo + '\'' +
			'}';
	}
}
