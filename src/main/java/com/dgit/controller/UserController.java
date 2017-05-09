package com.dgit.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService service;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void joinGET() throws Exception{
		logger.info("join GET..........");
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPOST(UserVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("join GET..........");
		
		service.insertUser(vo);
		
		return "redirect:/upload/list";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) throws Exception{
		logger.info("login GET..........");
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public void loginPOST(LoginDTO dto, Model model) throws Exception{
		logger.info("loginPost POST..........");
		
		UserVO user = service.selectUser(dto);
		
		if (user == null) {
			return;
		}
		
		model.addAttribute("userVO", user);
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logoutGET(HttpSession session) throws Exception{
		logger.info("logout GET..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		
		if (vo != null) {
			logger.info(vo.toString());
			session.removeAttribute(LoginInterceptor.LOGIN);
			session.invalidate();
		}
		return "redirect:/user/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/checkUid", method=RequestMethod.POST)
	public ResponseEntity<String> checkExistUser(String uid){
		ResponseEntity<String> entity = null;
		
		try{
			int res = service.checkExistUser(uid);
			if (res == 1) {
				entity = new ResponseEntity<>("exist", HttpStatus.OK);
			}else{
				entity = new ResponseEntity<>("unexist", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}

