package com.forus.service.recruit;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.recruit.SearchDao;
import com.forus.dto.Recruit_post;

@Service
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private SearchDao searchDao;

	@Override
	public List<Recruit_post> getRecruit_postList(List<String> areas, List<String> species, Integer page) throws Exception {
		// 현재 페이지수가 최대 페이지수보다 크면 null return
		if(page>getMaxPage(areas,species).get(0)) return null;
		// 현재 페이지에 해당하는 열 숫자 계산
		int row = (page-1)*10;
		Map<String,Object> map = new HashMap<>();
		map.put("areas", areas);
		map.put("species", species);
		map.put("row", row);
		System.out.println("map:"+map);
		return searchDao.selectRecruit_postList(map);
	}

	@Override
	public List<Integer> getMaxPage(List<String> areas, List<String> species) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("areas", areas);
		map.put("species", species);
		int maxCount = searchDao.selectListCount(map);
		System.out.println("map:"+map);
		System.out.println("maxCount:"+maxCount);
		
		List<Integer> count = new ArrayList<>();
		// 최대 페이지 수 올림으로 계산
		count.add((int)Math.ceil((double)maxCount/10));
		count.add(maxCount);
		return count;
	}

}
