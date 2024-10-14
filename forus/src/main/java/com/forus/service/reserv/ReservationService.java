package com.forus.service.reserv;

import java.util.List;
import java.util.Map;

import com.forus.dto.Pet;
import com.forus.dto.Reservation;
import com.forus.dto.User;
import com.forus.util.PageInfo;

public interface ReservationService {

	Map<String,Object> getAvailableTimeSlots(int hospitalId, String date);

	User getUserInfo(Integer userId);
	List<Pet> getPetsInfo(Integer petId);

	void insertReservation(Reservation reservation);

	public Reservation createReservation(String selectedDate, String selectedTime, String reservationContent,
		String customContent, String userId, String petId, String hId);

	List<Map<String, Object>> myAfterReservList(Integer id) throws Exception;
	List<Map<String, Object>> selectMyBeforeReservList(Integer id, Integer pet_id, String startDate, String endDate, boolean isConsult, PageInfo pageInfo) throws Exception;
	
	Integer selectMyBeforeReservCount(Integer id, Integer pet_id, String startDate, String endDate, boolean isConsult) throws Exception;
	// reserv_id에 해당하는 reservation 정보 select (h_name 등도 있어 Map으로 받음)
	Map<String, Object> selectReservByReservId(Integer reserv_id) throws  Exception;
	
	Integer deleteReservation(int reserv_id)throws Exception;
}
