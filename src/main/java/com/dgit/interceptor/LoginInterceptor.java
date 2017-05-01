package com.dgit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	public static final String LOGIN = "login";
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("preHandle.........");
		
		/*session안의 "login" 정보 삭제*/
		HttpSession session = request.getSession();
		if (session.getAttribute(LOGIN) != null) {
			logger.info("clear login data from preHandler");
			session.removeAttribute(LOGIN);
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		logger.info("postHandle.........");
		
		/*세션에 넣기
		 * 가입되지 않은 회원이면, loginPost에서는 list로 간다(jsp에서 처리함)
		 * servlet-context에서 interceptor연결*/
		HttpSession session = request.getSession();
		Object userVO = modelAndView.getModel().get("userVO");
		
		if (userVO != null) {
			logger.info("new id login success");
			session.setAttribute(LOGIN, userVO);
			
			response.sendRedirect(request.getContextPath()+"/upload/list");
		}
	}
}
