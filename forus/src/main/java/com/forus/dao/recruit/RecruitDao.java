package com.forus.dao.recruit;

import java.util.List;
import java.util.Map;

import com.forus.dto.Recruit_post;

public interface RecruitDao {
	// Recruit_post 데이터베이스에 insert
	void insertRecruit_post(Recruit_post post) throws Exception;
	// Recruit_post 데이터베이스에서 select
	Recruit_post selectRecruit_post(Integer post_id) throws Exception;
	// Recruit_post 수정시 데이터베이스 update
	void updateRecruit_post(Recruit_post post) throws Exception;
	// apply_id에 해당하는 Recruit_post 지원상태 수정하기
	void updateRecruit_post_status(Recruit_post post) throws Exception;
	
	// user_id에 해당하는 Recruit_post 및 신청인원 리스트 select
	List<Map<String,Object>> selectPostListByUserId(Integer user_id) throws Exception;
	// post_id에 해당하는 Recruit_post 삭제
	void deletePostByPostId(String post_id) throws Exception;
}