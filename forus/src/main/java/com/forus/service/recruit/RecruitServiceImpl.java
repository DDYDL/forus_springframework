package com.forus.service.recruit;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.my.PetDao;
import com.forus.dao.my.UserDao;
import com.forus.dao.recruit.RecruitDao;
import com.forus.dto.Pet;
import com.forus.dto.Recruit_post;
import com.forus.dto.User;

@Service
public class RecruitServiceImpl implements RecruitService {
	
	@Autowired
	private RecruitDao recruitDao;
	@Autowired
	private PetDao petDao;
	@Autowired
	private UserDao userDao;

	@Override
	public void recruit_postWrite(Recruit_post post) throws Exception {

		// 현재 날짜 구하기
		LocalDateTime now = LocalDateTime.now();
		// 날짜 형식 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		post.setPost_time(now.format(formatter)); // 등록일 설정
		
		post.setPost_title(post.getPost_title());
		post.setPost_content(post.getPost_content());
		post.setPost_address(post.getPost_address());
		post.setPost_form(post.getPost_form());
		post.setPost_pay(post.getPost_pay());
		post.setPost_date(post.getPost_date());
		post.setPost_start_time(post.getPost_start_time());
		post.setPost_end_time(post.getPost_end_time());
		post.setPost_status("게시중");
		
		System.out.println("post:"+post);
		recruitDao.insertRecruit_post(post);
	}

	@Override
	public Recruit_post recruit_postDatail(Integer post_id) throws Exception {
		Recruit_post post = recruitDao.selectRecruit_post(post_id);
		if(post==null) throw new Exception("구인 글 없음");
		return post;
	}

	@Override
	public boolean checkModify(Integer user_id, Integer post_id) throws Exception {
		Recruit_post post = recruitDao.selectRecruit_post(post_id);
		if(post==null) throw new Exception("구인 글 없음");
		
		// 현재 recruit_post와 user id가 같으면 수정하기 버튼 활성화
		if(post.getUser_id().equals(user_id)) return true;
		return false;
	}
	
	@Override
	public Integer recruit_postModify(Recruit_post post) throws Exception {
		
		post.setPost_id(post.getPost_id());
		post.setPost_title(post.getPost_title());
		post.setPost_content(post.getPost_content());
		post.setPost_address(post.getPost_address());
		post.setPost_form(post.getPost_form());
		post.setPost_pay(post.getPost_pay());
		post.setPost_date(post.getPost_date());
		post.setPost_start_time(post.getPost_start_time());
		post.setPost_end_time(post.getPost_end_time());
		System.out.println("post:"+post);
		recruitDao.updateRecruit_post(post);
		return post.getPost_id();
	}

	@Override
	public List<Pet> getPetList(Integer user_id) throws Exception {
		List<Pet> pets = petDao.selectPetList(user_id);
		if(pets==null) throw new Exception("애완동물 없음");
		return pets;
	}

	@Override
	public User selectUserId(Integer user_id) throws Exception {
		User user = userDao.selectUserId(user_id);
		if(user==null) throw new Exception("사용자 없음");
		return user;
	}

	@Override
	public List<Map<String,Object>> selectPostListByUserId(Integer user_id) throws Exception {
		return recruitDao.selectPostListByUserId(user_id);
	}

	@Override
	public void deletePostByPostId(String post_id) throws Exception {
		recruitDao.deletePostByPostId(post_id);
	}
	
	
}
