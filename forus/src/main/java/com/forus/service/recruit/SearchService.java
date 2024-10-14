package com.forus.service.recruit;

import java.util.List;

import com.forus.dto.Recruit_post;

public interface SearchService {
	// 현재 페이지 수, 최대 페이지 수, 검색 조건 등을 고려하여 Recruit_post 리스트 가져오기
	List<Recruit_post> getRecruit_postList(List<String> areas, List<String> species, Integer page) throws Exception;
	// 검색 조건을 반영한 최대 페이지 수와 전체 post 수 가져오기
	List<Integer> getMaxPage(List<String> areas, List<String> species) throws Exception;
}
