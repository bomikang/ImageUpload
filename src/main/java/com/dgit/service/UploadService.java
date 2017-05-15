package com.dgit.service;

import java.util.List;

import com.dgit.domain.UploadVO;
import com.dgit.domain.UserVO;

public interface UploadService {
	void insertImage(UserVO vo) throws Exception;
	List<UploadVO> selectImage(String uid)  throws Exception;
	List<String> selectFolder(String uid) throws Exception;
	List<UploadVO> selectImageByFolder(UserVO vo) throws Exception;
	void deleteEachImage(UserVO vo) throws Exception;
	void deleteAllImage(String uid) throws Exception;
	void deleteImageByFolder(UserVO vo) throws Exception;
}
