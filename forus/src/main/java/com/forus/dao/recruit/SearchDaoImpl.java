package com.forus.dao.recruit;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forus.dto.Recruit_post;

@Repository
public class SearchDaoImpl implements SearchDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Recruit_post> selectRecruit_postList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("mapper.search.selectRecruit_postList", map);
	}

	@Override
	public Integer selectListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("mapper.search.selectListCount", map);
	}

}
