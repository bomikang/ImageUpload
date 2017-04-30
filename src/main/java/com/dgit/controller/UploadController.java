package com.dgit.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/upload/*")
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@RequestMapping(value="upload", method=RequestMethod.GET)
	public void uploadGET(){
		logger.info("upload GET..........");
	}
}
