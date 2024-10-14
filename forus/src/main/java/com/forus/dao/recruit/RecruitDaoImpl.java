package com.forus.dao.recruit;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forus.dto.Recruit_post;

@Repository
public class RecruitDaoImpl implements RecruitDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertRecruit_post(Recruit_post post) throws Exception {
		sqlSession.insert("mapper.recruit_post.insertRecruit_post", post);
	}

	@Override
	public Recruit_post selectRecruit_post(Integer post_id) throws Exception {
		return sqlSession.selectOne("mapper.recruit_post.selectRecruit_post", post_id);
	}

	@Override
	public void updateRecruit_post(Recruit_post post) throws Exception {
		sqlSession.update("mapper.recruit_post.updateRecruit_post", post);
	}
	
	@Override
	public void updateRecruit_post_status(Recruit_post post) throws Exception {
		sqlSession.update("mapper.recruit_post.updateRecruit_post_status", post);
	}

	@Override
	public List<Map<String,Object>> selectPostListByUserId(Integer user_id) throws Exception {
		return sqlSession.selectList("mapper.recruit_post.selectPostListByUserId", user_id);
	}

	@Override
	public void deletePostByPostId(String post_id) throws Exception {
		sqlSession.delete("mapper.recruit_post.deletePostByPostId", post_id);
	}
}
