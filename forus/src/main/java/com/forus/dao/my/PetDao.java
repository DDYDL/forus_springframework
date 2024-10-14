package com.forus.dao.my;

import java.util.List;

import com.forus.dto.Pet;

public interface PetDao {
	//pet 데이터베이스에 insert
	void insertPet(Pet pet) throws Exception;
	
	//pet 불러오기
	Pet selectPet(Integer pet_id) throws Exception;

	void updatePet(Pet pet) throws Exception;
	
	// user_id에 해당하는 Pet 리스트 가져오기
	List<Pet> selectPetList(Integer user_id) throws Exception;
	
	Integer deletePet(Integer pet_Id)throws Exception;

	int updateReservationStatusToCancelledByPetId(int petId);
}
