package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.UploadVO;
import com.dgit.domain.UserVO;

@Repository
public class UploadDaoImpl implements UploadDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.UploadMapper";

	@Override
	public void insertImage(String fullname, UserVO vo) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("fullname", fullname);
		paramMap.put("uid", vo.getUid());
		paramMap.put("folder", vo.getFolder());
		session.insert(namespace+".insertImage", paramMap);
	}

	@Override
	public List<String> selectImage(String uid) throws Exception {
		return session.selectList(namespace+".selectImage", uid);
	}
	
	@Override
	public List<String> selectFolder(String uid) throws Exception {
		return session.selectList(namespace+".selectFolder", uid);
	}

	@Override
	public void deleteEachImage(String fullname, String uid) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("fullname", fullname);
		paramMap.put("uid", uid);
		session.delete(namespace+".deleteEachImage", paramMap);
	}

	@Override
	public void deleteAllImage(String uid) throws Exception {
		session.delete(namespace+".deleteAllImage", uid);
	}

	

}
