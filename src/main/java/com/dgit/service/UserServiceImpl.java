package com.dgit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;
import com.dgit.persistence.UserDao;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao dao;

	@Override
	public void insertUser(UserVO vo) throws Exception {
		dao.insertUser(vo);
	}

	@Override
	public UserVO selectUser(LoginDTO dto) throws Exception {
		return dao.selectUser(dto);
	}

	@Override
	public int checkExistUser(String uid) throws Exception {
		return dao.checkExistUser(uid);
	}
}
