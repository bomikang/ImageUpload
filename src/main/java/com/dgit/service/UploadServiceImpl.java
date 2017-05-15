package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.UploadVO;
import com.dgit.domain.UserVO;
import com.dgit.persistence.UploadDao;

@Service
public class UploadServiceImpl implements UploadService{
	@Autowired
	private UploadDao dao;

	@Override
	public void insertImage(UserVO vo) throws Exception {
		String[] imageFiles = vo.getImageFiles();
		for (String file : imageFiles) {
			dao.insertImage(file, vo);
		}
	}

	@Override
	public List<UploadVO> selectImage(String uid) throws Exception {
		return dao.selectImage(uid);
	}
	
	@Override
	public List<String> selectFolder(String uid) throws Exception {
		return dao.selectFolder(uid);
	}
	
	@Override
	public List<UploadVO> selectImageByFolder(UserVO vo) throws Exception {
		return dao.selectImageByFolder(vo);
	}

	@Override
	public void deleteEachImage(UserVO vo) throws Exception {
		String[] filenames = vo.getImageFiles();
		for (String filename : filenames) {
			dao.deleteEachImage(filename, vo.getUid());
		}
	}

	@Override
	public void deleteAllImage(String uid) throws Exception {
		dao.deleteAllImage(uid);
	}

	@Override
	public void deleteImageByFolder(UserVO vo) throws Exception {
		dao.deleteImageByFolder(vo);
	}
}
