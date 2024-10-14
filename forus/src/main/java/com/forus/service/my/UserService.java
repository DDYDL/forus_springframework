package com.forus.service.my;

import javax.servlet.http.HttpServletRequest;

import com.forus.dto.User;

public interface UserService {
	void join(User user) throws Exception;

	User login(String email, String password) throws Exception;

	boolean checkDoubleEmail(String email) throws Exception;

	User userDetail(Integer id) throws Exception;

	Integer userModify(HttpServletRequest request) throws Exception;
	
//	User selectUser(Integer id) throws Exception;
}
