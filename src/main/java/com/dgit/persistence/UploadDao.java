package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.UploadVO;
import com.dgit.domain.UserVO;

public interface UploadDao {
	void insertImage(String fullname, UserVO vo) throws Exception;
	List<UploadVO> selectImage(String uid)  throws Exception;
	List<String> selectFolder(String uid) throws Exception;
	List<UploadVO> selectImageByFolder(UserVO vo) throws Exception;
	void deleteEachImage(String fullname, String uid) throws Exception;
	void deleteAllImage(String uid) throws Exception;
	void deleteImageByFolder(UserVO vo) throws Exception;
}
