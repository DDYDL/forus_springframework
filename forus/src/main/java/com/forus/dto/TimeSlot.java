package com.forus.dto;

import java.time.LocalTime;

public class TimeSlot {
	private LocalTime time;
	private boolean isAvailable;

	public TimeSlot(LocalTime time, boolean isAvailable) {
		this.time = time;
		this.isAvailable = isAvailable;
	}

	public LocalTime getTime() {
		return time;
	}

	public void setTime(LocalTime time) {
		this.time = time;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean available) {
		isAvailable = available;
	}

	@Override
	public String toString() {
		return "TimeSlot{" +
			"time=" + time +
			", isAvailable=" + isAvailable +
			'}';
	}
}
