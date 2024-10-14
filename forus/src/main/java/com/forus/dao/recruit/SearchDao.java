package com.forus.dao.recruit;

import java.util.List;
import java.util.Map;

import com.forus.dto.Recruit_post;

public interface SearchDao {
	// 지역, 동물 배열로 리스트 선택
	List<Recruit_post> selectRecruit_postList(Map<String,Object> map) throws Exception;
	// 선택된 리스트의 수 가져오기
	Integer selectListCount(Map<String,Object> map) throws Exception;
}
