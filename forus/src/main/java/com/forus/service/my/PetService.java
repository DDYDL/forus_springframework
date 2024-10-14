package com.forus.service.my;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.forus.dto.Pet;

public interface PetService {
	// 작성한 펫 프로필 데베에 저장
	void insertPet(HttpServletRequest request) throws Exception;

	Integer petModify(HttpServletRequest request) throws Exception;

	Pet petDetail(Integer pet_id) throws Exception;

	List<Pet> selectPetList(Integer user_id) throws Exception;
	
	Integer petDelete(int pet_Id) throws Exception;

}
