package com.forus.service.reserv;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.reserv.ReservationDao;
import com.forus.dto.Hospital;
import com.forus.dto.Hospital_time;
import com.forus.dto.Pet;
import com.forus.dto.Reservation;
import com.forus.dto.TimeSlot;
import com.forus.dto.User;
import com.forus.util.IntegerNullCheck;
import com.forus.util.PageInfo;
import com.forus.util.StringNullCheck;


@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDao reservationDao;
	
	@Override
	public Map<String, Object> getAvailableTimeSlots(int hospitalId, String date) {
		Map<String, Object> result = new HashMap<>();

		Map<String, Object> params = new HashMap<>();
		params.put("hospitalId", hospitalId);
		params.put("date", date);

		List<Hospital_time> hospitalTimes = reservationDao.findHospitalTimeByHospitalId(params);
		Hospital hospital = reservationDao.findHospitalLunchTimeAndIntervalByHospitalId(hospitalId);
		List<LocalTime> reservedTimes = reservationDao.findReservedTimesByDate(params);

		LocalDate reservationDate = LocalDate.parse(date);

		List<TimeSlot> availableTimeSlots = calculateAvailableTimeSlots(hospitalTimes, reservedTimes, hospital, reservationDate);

		result.put("availableTimeSlots", availableTimeSlots);
		return result;

	}


	private List<TimeSlot> calculateAvailableTimeSlots(
		List<Hospital_time> hospitalTimes, List<LocalTime> reservedTimes, Hospital hospital, LocalDate reservationDate) {

		LocalTime lunchStartTime = hospital.getH_lunch_time_start();
		LocalTime lunchEndTime = hospital.getH_lunch_time_end();

		int intervalMinutes = hospital.getH_interval_time();

		List<TimeSlot> availableTimeSlots = new ArrayList<>();
		LocalTime nowTime = LocalTime.now();
		LocalDate today = LocalDate.now();

		LocalTime openingTime = null;
		LocalTime closingTime = null;

		for (Hospital_time time : hospitalTimes) {
			openingTime = time.getHtime_opening();
			closingTime = time.getHtime_closing();

			if (openingTime == null || closingTime == null) {
				availableTimeSlots.add(new TimeSlot(LocalTime.of(0, 0), false));
				continue;
			}

			//시간대 별로 예약 가능한 시간을 계산
			validateAvailableTimeSlots(
				reservedTimes,
				reservationDate,
				openingTime,
				closingTime,
				intervalMinutes,
				lunchStartTime,
				lunchEndTime,
				today,
				nowTime,
				availableTimeSlots);
		}
			return availableTimeSlots;
		}

	private  void validateAvailableTimeSlots(List<LocalTime> reservedTimes, LocalDate reservationDate, LocalTime openingTime,
		LocalTime closingTime, int intervalMinutes, LocalTime lunchStartTime, LocalTime lunchEndTime, LocalDate today,
		LocalTime nowTime, List<TimeSlot> availableTimeSlots) {

		for (LocalTime currentTime = openingTime; isBeforeClosingTime(closingTime, currentTime); currentTime = currentTime.plusMinutes(intervalMinutes)) {
			boolean isReserved = reservedTimes.contains(currentTime);
			boolean isLunchTime = isDuringLunchTime(currentTime, lunchStartTime, lunchEndTime);
			boolean isPastTime = reservationDate.equals(today) && currentTime.isBefore(nowTime);
			boolean isAvailable = !isReserved && !isLunchTime && !isPastTime;

			if (isAvailable) {
				availableTimeSlots.add(new TimeSlot(currentTime, true));
			} else {
				availableTimeSlots.add(new TimeSlot(currentTime, false));
			}

		}
	}

	private static boolean isBeforeClosingTime(LocalTime closingTime, LocalTime currentTime) {
		return !currentTime.isAfter(closingTime);
	}

	private static boolean isDuringLunchTime(LocalTime currentTime, LocalTime lunchStartTime, LocalTime lunchEndTime) {
		return currentTime.isAfter(lunchStartTime.minusMinutes(1)) && currentTime.isBefore(
			lunchEndTime.plusMinutes(1));
	}


	@Override
	public Reservation createReservation(String selectedDate, String selectedTime, String reservationContent,
		String customContent, String userId, String petId, String hospitalId) {

		if ("기타".equals(reservationContent) && StringNullCheck.isNotEmpty(customContent)) {
			reservationContent = customContent;
		}

		if(StringNullCheck.isEmpty(hospitalId)) {
			throw new IllegalArgumentException("병원 ID가 없습니다.");
		}

		if(StringNullCheck.isEmpty(userId)) {
			throw new IllegalArgumentException("사용자 ID가 없습니다.");
		}

		if(StringNullCheck.isEmpty(petId)) {
			throw new IllegalArgumentException("펫 ID가 없습니다.");
		}

		Integer parsedHospitalId = IntegerNullCheck.parseInteger(hospitalId);
		Integer parsedUserId = IntegerNullCheck.parseInteger(userId);
		Integer parsedPetId = IntegerNullCheck.parseInteger(petId);


		LocalDate reservationDate = LocalDate.parse(selectedDate);
		LocalTime reservationTime = LocalTime.parse(selectedTime);

		Reservation reservation = new Reservation();
		reservation.sethId(parsedHospitalId);
		reservation.setUserId(parsedUserId);
		reservation.setPetId(parsedPetId);
		reservation.setReservDate(reservationDate);
		reservation.setReservTime(reservationTime);
		reservation.setReservContent(reservationContent);
		reservation.setReservStatus("예약");


		return reservation;
	}

	@Override
	public User getUserInfo(Integer userId) {
		return reservationDao.findUserInfoByUserId(userId);
	}

	@Override
	public List<Pet> getPetsInfo(Integer userId) {
		return reservationDao.findPetsByUserId(userId);
	}

	@Override
	public void insertReservation(Reservation reservation) {
		reservationDao.insertReservation(reservation);
	}

	@Override
	public List<Map<String, Object>> myAfterReservList(Integer id) throws Exception {
		return reservationDao.selectMyAfterReservList(id);
	}
	
	@Override
	public Integer selectMyBeforeReservCount(Integer id, Integer pet_id, String startDate, String endDate,
			boolean isConsult) throws Exception {
		return reservationDao.selectMyBeforeReservCount(id, pet_id, startDate, endDate, isConsult);
	}
	
	@Override
	public List<Map<String, Object>> selectMyBeforeReservList(Integer id, Integer pet_id, String startDate, String endDate, boolean isConsult, PageInfo pageInfo) throws Exception {
		Integer allCount = reservationDao.selectMyBeforeReservCount(id, pet_id, startDate, endDate, isConsult);

		Integer allPage = (int)Math.ceil((double)allCount/10);
		//startPage : 1~10 => 1, 11~20 => 11
		Integer startPage = (pageInfo.getCurPage()-1)/10*10+1;
		Integer endPage = startPage+10-1;
		if(endPage>allPage) endPage = allPage;	
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
			
		Integer row = (pageInfo.getCurPage()-1)*10+1;
		return reservationDao.selectMyBeforeReservList(id, pet_id, startDate, endDate, isConsult, row-1);
	}
	
	@Override
	public Map<String, Object> selectReservByReservId(Integer reserv_id) throws Exception {
		return reservationDao.selectReservByReservId(reserv_id);
	}

	@Override
	public Integer deleteReservation(int reserv_id) throws Exception {
		return reservationDao.deleteReserv(reserv_id);
	}


}
