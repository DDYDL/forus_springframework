package com.forus.dao.my;

import com.forus.dto.User;

public interface UserDao {
	void insertUser(User user) throws Exception;
	User selectUser(String email) throws Exception;
	void updateUser(User user) throws Exception;
	void ishospitalstatus (User user) throws Exception;
	User selectUserId(Integer id) throws Exception;
}
