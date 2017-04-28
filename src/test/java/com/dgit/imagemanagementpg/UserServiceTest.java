package com.dgit.imagemanagementpg;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;
import com.dgit.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserServiceTest {
	@Inject
	private UserService service;
	
//	@Test
//	public void insertTest() throws Exception {
//		UserVO vo = new UserVO();
//		vo.setUid("test1");
//		vo.setUpw("test1");
//		vo.setUname("test1");
//		vo.setUemail("test1@test.com");
//		vo.setUphone("01025252525");
//		
//		service.insertUser(vo);
//	}
	
	@Test
	public void selectTest() throws Exception {
		LoginDTO dto = new LoginDTO();
		dto.setUid("test1");
		dto.setUpw("test1");
		service.selectUser(dto);
	}
}
