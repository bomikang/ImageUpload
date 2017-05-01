package com.dgit.imagemanagementpg;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dgit.domain.UserVO;
import com.dgit.service.UploadService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UploadServiceTest {
	@Autowired
	private UploadService service;
	
//	@Test
//	public void testInsertImage() throws Exception{
//		UserVO vo = new UserVO();
//		vo.setUid("test1");
//		
//		service.insertImage(vo);
//	}
	
	@Test
	public void testSelectImage() throws Exception{
		service.selectImage("test1");
	}
}
