package com.forus.service.my;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.dao.my.UserDao;
import com.forus.dto.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;


	@Override
	public void join(User user) throws Exception {
		System.out.println(user.toString());
		User suser = userDao.selectUser(user.getEmail());
		if (suser != null)
			throw new Exception("이메일 중복 오류");
		userDao.insertUser(user);
	}

	@Override
	public User login(String email, String password) throws Exception {
		User suser = userDao.selectUser(email);
		if (suser == null)
			throw new Exception("아이디 오류");
		if (!password.equals(suser.getPassword()))
			throw new Exception("비밀번호 오류");
		return suser;
	}

	@Override
	public boolean checkDoubleEmail(String email) throws Exception {
		User suser = userDao.selectUser(email);
		if (suser == null)
			return false;
		return true;
	}

	@Override
	public User userDetail(Integer id) throws Exception {
		User user = userDao.selectUserId(id);
		if (user == null)
			throw new Exception("유저 조회 오류");
		return user;
	}

	@Override
	public Integer userModify(HttpServletRequest request) throws Exception {
		String path = request.getServletContext().getRealPath("upload" + File.separator + "user");
		int size = 10 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		User user = new User();
		user.setId(Integer.parseInt(multi.getParameter("id")));
		user.setName(multi.getParameter("name"));
		user.setNickname(multi.getParameter("nickname"));
		user.setEmail((String) request.getSession().getAttribute("email"));
		user.setPassword(multi.getParameter("password"));
		user.setPhone(multi.getParameter("phone"));
		user.setBirthday(multi.getParameter("birthday"));
		user.setAddress(multi.getParameter("address"));

		// 파일 수정
		if (multi.getFile("file") != null) {
			user.setPicture(multi.getFilesystemName("file"));
		}

		System.out.println("1"+user);
		userDao.updateUser(user);
		User suser = userDao.selectUserId(user.getId());
		System.out.println("2"+suser);
		return user.getId();
	}

}
