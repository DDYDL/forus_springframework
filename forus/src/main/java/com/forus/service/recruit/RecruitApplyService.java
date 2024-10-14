package com.forus.service.recruit;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.forus.dto.Recruit_apply;
import com.forus.dto.Recruit_post;

public interface RecruitApplyService {
	// Recruit_apply 작성하기
	void insertRecruit_apply(Recruit_apply apply) throws Exception;
	// post_id가 같은 Recruit_apply 리스트 가져오기
	List<Recruit_apply> selectRecruit_applyList(Integer post_id) throws Exception;
	// apply_id로 해당하는 Recruit_apply 하나 가져오기
	Recruit_apply selectRecruit_apply(Integer apply_id) throws Exception;
	// Recruit_apply 지원상태 수정하기
	void updateRecruit_apply_status(Recruit_apply apply) throws Exception;
	// Recruit_post 지원상태 수정하기
	void updateRecruit_post_status(Recruit_post post) throws Exception;
	
	// user_id에 해당하는 Recruit_apply 리스트 가져오기
	List<Map<String,Object>> selectApplyListByUserId(Integer user_id) throws Exception;
	// apply_id에 해당하는 Recruit_apply 삭제하기
	void deleteApplyByApplyId(Integer apply_id) throws Exception;
}
