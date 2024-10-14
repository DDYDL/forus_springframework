package com.forus.service.recruit;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.recruit.RecruitApplyDao;
import com.forus.dao.recruit.RecruitDao;
import com.forus.dto.Recruit_apply;
import com.forus.dto.Recruit_post;
import com.forus.dto.User;

@Service
public class RecruitApplyServiceImpl implements RecruitApplyService {
	
	@Autowired
	private RecruitApplyDao recruitApplyDao;
	@Autowired
	private RecruitDao recruitDao;
	
	@Override
	public void insertRecruit_apply(Recruit_apply apply) throws Exception {
		
		List<Recruit_apply> applys = recruitApplyDao.selectRecruit_apply(apply.getUser_id());
		for(Recruit_apply sapply: applys) {
			if(sapply.getPost_id()==apply.getPost_id()) throw new Exception("이미 지원한 구인글입니다");
		}
		
		// 현재 날짜 구하기
		LocalDateTime now = LocalDateTime.now();
		// 날짜 형식 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		apply.setApply_time(now.format(formatter)); // 등록일 설정
		
		apply.setApply_title(apply.getApply_title());
		apply.setApply_content(apply.getApply_content());
		apply.setApply_status("지원완료");
		
		System.out.println("apply:" + apply);
		recruitApplyDao.insertRecruit_apply(apply);
	}

	@Override
	public List<Recruit_apply> selectRecruit_applyList(Integer post_id) throws Exception {
		List<Recruit_apply> recruit_apply = recruitApplyDao.selectRecruit_applyList(post_id);
		if(recruit_apply==null) throw new Exception("지원자가 없습니다");
		return recruit_apply;
	}

	@Override
	public Recruit_apply selectRecruit_apply(Integer apply_id) throws Exception {
		Recruit_apply recruit_apply = recruitApplyDao.selectRecruit_applyId(apply_id);
		if(recruit_apply==null) throw new Exception("지원자가 없습니다");
		return recruit_apply;
	}

	@Override
	public void updateRecruit_apply_status(Recruit_apply apply) throws Exception {
		recruitApplyDao.updateRecruit_apply_status(apply);
	}
	
	@Override
	public void updateRecruit_post_status(Recruit_post post) throws Exception {
		recruitDao.updateRecruit_post_status(post);
	}

	@Override
	public List<Map<String, Object>> selectApplyListByUserId(Integer user_id) throws Exception {
		return recruitApplyDao.selectApplyListByUserId(user_id);
	}

	@Override
	public void deleteApplyByApplyId(Integer apply_id) throws Exception {
		recruitApplyDao.deleteApplyByApplyId(apply_id);
	}
}
