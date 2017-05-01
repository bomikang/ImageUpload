package com.dgit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("preHandler..........");
		
		/*session에 들어있는 login 정보를 받아서 존재하면 계속 진행 
		 * 존재하지않으면 로그인화면으로 이동*/
		HttpSession session = request.getSession();
		Object login = session.getAttribute(LoginInterceptor.LOGIN);
		
//		로그인이 안된 상태
		if (login == null) {
			logger.info("have to login");
			response.sendRedirect(request.getContextPath()+"/user/login"); //로그인 화면으로 이동
			return false;
		}
		return true;
	}
}
