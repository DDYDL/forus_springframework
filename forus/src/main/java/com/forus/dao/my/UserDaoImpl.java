package com.forus.dao.my;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.forus.dto.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertUser(User user) throws Exception {
		User suser = selectUser(user.getEmail());
		if(suser!=null) throw new Exception("아이디 중복 오류");
		sqlSession.insert("mapper.user.insertUser", user);
	}

	@Override
	public User selectUser(String email) throws Exception {
		return sqlSession.selectOne("mapper.user.selectUser",email);
	}

	@Override
	public void updateUser(User user) throws Exception {
		sqlSession.update("mapper.user.updateUser",user);
	}

	@Override
	public User selectUserId(Integer id) throws Exception {
		return sqlSession.selectOne("mapper.user.selectUserId", id);
	}

	@Override
	public void ishospitalstatus(User user) throws Exception {
		sqlSession.update("mapper.user.ishospitalstatus",user);
	}
}
