package com.forus.dao.reserv;

import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import com.forus.dto.Hospital;
import com.forus.dto.Hospital_time;
import com.forus.dto.Pet;
import com.forus.dto.Reservation;
import com.forus.dto.User;

public interface ReservationDao {
	List<Hospital_time> findHospitalTimeByHospitalId(Map<String, Object> params);
	Hospital findHospitalLunchTimeAndIntervalByHospitalId(Integer hospitalId);
	List<LocalTime> findReservedTimesByDate(Map<String, Object> params);

	//findUserInfByUserId
	User findUserInfoByUserId(Integer userId);


	List<Pet> findPetsByUserId(Integer userId);

	void insertReservation(Reservation reservation);
	
	// 오늘 이후, 지난 예약 조회
	List<Map<String, Object>> selectMyAfterReservList(Integer id) throws Exception;
	List<Map<String, Object>> selectMyBeforeReservList(Integer userId, Integer pet_id, String startDate, String endDate, boolean isConsult, Integer row) throws Exception;
	Integer selectMyBeforeReservCount (Integer userId, Integer pet_id, String startDate, String endDate, boolean isConsult) throws Exception;
	
	// reserv_id에 해당하는 reservation 정보 select
	Map<String, Object> selectReservByReservId(Integer reserv_id) throws Exception;
	
	Integer deleteReserv(int reserv_id) throws Exception;
	

}