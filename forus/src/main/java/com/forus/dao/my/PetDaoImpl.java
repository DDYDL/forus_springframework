package com.forus.dao.my;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forus.dto.Pet;

@Repository
public class PetDaoImpl implements PetDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertPet(Pet pet) throws Exception {
		sqlSession.insert("mapper.pet.insertPet", pet);
	}

	@Override
	public Pet selectPet(Integer pet_id) throws Exception {
		return sqlSession.selectOne("mapper.pet.selectPet", pet_id);
	}

	@Override
	public void updatePet(Pet pet) throws Exception {
		sqlSession.update("mapper.pet.updatePet", pet);
	}

	@Override
	public List<Pet> selectPetList(Integer user_id) throws Exception {
		return sqlSession.selectList("mapper.pet.selectPetList", user_id);
	}

	@Override
	public Integer deletePet(Integer pet_Id) throws Exception {
		return sqlSession.delete("mapper.pet.deletePet", pet_Id);
	}

	@Override
	public int updateReservationStatusToCancelledByPetId(int petId) {
		return sqlSession.update("mapper.reservation.updateReservationStatusToCancelledByPetId", petId);
	}
}
