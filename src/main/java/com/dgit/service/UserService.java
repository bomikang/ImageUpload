package com.dgit.service;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;

public interface UserService {
	void insertUser(UserVO vo) throws Exception;
	UserVO selectUser(LoginDTO dto) throws Exception;
	int checkExistUser(String uid) throws Exception;
}
