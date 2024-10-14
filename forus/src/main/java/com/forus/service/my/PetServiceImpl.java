package com.forus.service.my;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.my.PetDao;
import com.forus.dto.Pet;
import com.forus.dto.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Service
public class PetServiceImpl implements PetService {

	@Autowired
	private PetDao petDao;
	
	@Override
	public void insertPet(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String path = request.getServletContext().getRealPath("upload" + File.separator + "pet");
		int size = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		Pet pet = new Pet();
		pet.setPet_id(pet.getPet_id());

		request.setCharacterEncoding("utf-8");
		// 파일 수정
		if (multi.getFile("file") != null) {
			pet.setPet_picture(multi.getFilesystemName("file"));
		}
		// request session의 인자 user
		User user = (User) request.getSession().getAttribute("user");
		// RecruitWriting에서 파라미터로 넘어온 value들을 지정
		pet.setUser_id(user.getId());

		pet.setPet_name(multi.getParameter("pet_name"));
		pet.setPet_species(multi.getParameter("pet_species"));
		pet.setPet_breed(multi.getParameter("pet_breed"));
		pet.setPet_num(multi.getParameter("pet_num"));
		pet.setPet_gender(multi.getParameter("pet_gender"));
		pet.setPet_age(Integer.parseInt(multi.getParameter("pet_age")));
		pet.setPet_neutering(Boolean.parseBoolean(multi.getParameter("pet_neutering")));
		pet.setPet_memo(multi.getParameter("pet_memo"));
		System.out.println(pet);
		petDao.insertPet(pet);

	}

	@Override

	public Integer petModify(HttpServletRequest request) throws Exception {
		String path = request.getServletContext().getRealPath("upload" + File.separator + "pet");
		int size = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		Pet pet = new Pet();
		pet.setPet_id(Integer.parseInt(multi.getParameter("pet_id")));
		pet.setPet_name(multi.getParameter("pet_name"));
		pet.setPet_species(multi.getParameter("pet_species"));
		pet.setPet_breed(multi.getParameter("pet_breed"));
		pet.setPet_num(multi.getParameter("pet_num"));
		pet.setPet_gender(multi.getParameter("pet_gender"));
		pet.setPet_age(Integer.parseInt(multi.getParameter("pet_age")));

		if (multi.getParameterValues("pet_neutering") != null) {
			pet.setPet_neutering(true);
		} else {
			pet.setPet_neutering(false);
		}

		pet.setPet_memo(multi.getParameter("pet_memo"));

		System.out.println(multi.getParameterValues("pet_neutering"));
		if (multi.getParameterValues("pet_neutering") != null) {
			pet.setPet_neutering(true);
		} else {
			pet.setPet_neutering(false);
		}

		// 파일 수정
		if (multi.getFile("file") != null) {
			pet.setPet_picture(multi.getFilesystemName("file"));
		}

		petDao.updatePet(pet);
		return pet.getPet_id();
	}

	@Override
	public Pet petDetail(Integer pet_id) throws Exception {
		Pet pet = petDao.selectPet(pet_id);
		if (pet == null)
			throw new Exception("펫 아이디 오류");
		return pet;
	}

	public List<Pet> selectPetList(Integer user_id) throws Exception {
		return petDao.selectPetList(user_id);
	}

	// @Override
	// public Integer petDelete(int pet_Id) throws Exception {
	// return petDao.deletePet(pet_Id);
	//
	// }

	@Override
	public Integer petDelete(int pet_Id) throws Exception {
		// 해당 펫의 예약 상태를 "예약취소"로 업데이트

		int updatedReservations = petDao.updateReservationStatusToCancelledByPetId(pet_Id);

		/*
		 * if (updatedReservations == 0) { throw new Exception("삭제 중 오류가 발생했습니다."); }
		 */

		// 펫 삭제
		int deleteCount = petDao.deletePet(pet_Id);

		// 로그 기록 (선택)
		System.out.println("예약 상태 취소된 수: " + updatedReservations);

		return deleteCount;
	}

}
