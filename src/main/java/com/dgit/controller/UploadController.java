package com.dgit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dgit.domain.UploadVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.UploadService;
import com.dgit.util.MediaUtils;
import com.dgit.util.UploadFileUtil;

@Controller
@RequestMapping("/upload/*")
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Inject
	private UploadService service;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value="upload", method=RequestMethod.GET)
	public void uploadGET(){
		logger.info("upload GET..........");
	}
	
	@RequestMapping(value="upload", method=RequestMethod.POST)
	public String uploadPOST(List<MultipartFile> files, String directory, HttpSession session) throws Exception{
		logger.info("upload POST..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		
		ArrayList<String> filenames = new ArrayList<>();
		for (MultipartFile file : files) {
			logger.info("original name : " + file.getOriginalFilename());
			logger.info("size : "+file.getSize());
			logger.info("contentType : "+file.getContentType());
			
			if (directory == null || directory.trim().equals("")) {
				directory = null;
				logger.info("directory is null");
			}
			
			String savedName = UploadFileUtil.uploadFile(uploadPath, directory, file.getOriginalFilename(), file.getBytes());
			
			filenames.add(savedName);
		}
		
		String[] imageFiles = filenames.toArray(new String[filenames.size()]);
		vo.setFolder(directory);
		vo.setImageFiles(imageFiles);
		
		service.insertImage(vo);
		
		return "redirect:/upload/list";
	}
	
	/*전체보기*/
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void listGET(String folder, HttpSession session, Model model) throws Exception{
		logger.info("list GET..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		List<String> list = service.selectImage(vo.getUid());
		
		if (folder != null && !folder.trim().equals("")) {
			vo.setFolder(folder);
			logger.info(folder+"----------------------------------");
			list = service.selectImageByFolder(vo);
		}
		if (folder == null || folder.trim().equals("")) {
			folder = "전체보기";
		}
		
		if (list == null) {
			model.addAttribute("error");
		}else{
			model.addAttribute("imageList", list);
			model.addAttribute("folder", folder);
		}
	}
	
	@ResponseBody
	@RequestMapping(value="menu", method=RequestMethod.GET)
	public ResponseEntity<List<String>> getFolder(HttpSession session){
		ResponseEntity<List<String>> entity = null;
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		
		try{
			List<String> list = service.selectFolder(vo.getUid());
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="deleteEach", method=RequestMethod.POST)
	public String deleteEachPOST(HttpSession session, String fullname, String folder) throws Exception{
		logger.info("deleteEach POST..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		vo.setImageFiles(new String[]{fullname});
		
		if ( folder.trim().equals("전체보기") ) {
			folder = null;
		}
		
		deleteFile(folder, fullname); //실제파일삭제
		service.deleteEachImage(vo);
		
		if (folder != null && service.selectImageByFolder(vo).size() > 0) {
			return "redirect:/upload/list?folder="+folder;
		}
		
		return "redirect:/upload/list";
	}
	
	@RequestMapping(value="deleteSelected", method=RequestMethod.POST)
	public String deleteSelectedPOST(HttpSession session, String[] selectedFiles, String folder) throws Exception{
		logger.info("deleteSelected POST..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		vo.setImageFiles(selectedFiles);
		
		if ( folder.trim().equals("전체보기") ) {
			folder = null;
			String directory = null;
			
			for (String file : selectedFiles) {
				String[] catchFolder = file.split("/"); 
				if (catchFolder.length > 2) {
					directory = catchFolder[1]; //폴더명
				}
				deleteFile(directory, file); //각각 폴더명의 실제파일삭제
			}
		}else{
			vo.setFolder(folder);
			deleteFile(folder, selectedFiles);
		}
		
		service.deleteEachImage(vo);
		
		if (folder != null && service.selectImageByFolder(vo).size() > 0) {
			return "redirect:/upload/list?folder="+folder;
		}
		return "redirect:/upload/list";
	}
	
	@RequestMapping(value="deleteAll", method=RequestMethod.POST)
	public String deleteAllPOST(HttpSession session, String folder) throws Exception{
		logger.info("deleteAll POST..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		
		List<String> imageList = service.selectImage(vo.getUid());
		String[] filenames = imageList.toArray(new String[imageList.size()]);
		
		if ( folder.trim().equals("전체보기") ) {
			folder = null;
			String directory = null;
			
			for (String file : filenames) {
				String[] catchFolder = file.split("/"); 
				if (catchFolder.length > 2) {
					directory = catchFolder[1]; //폴더명
				}
				deleteFile(directory, file); //각각 폴더명의 실제파일삭제
			}
			
			service.deleteAllImage(vo.getUid());
		}else{
			vo.setFolder(folder);
			imageList = service.selectImageByFolder(vo);
			filenames = imageList.toArray(new String[imageList.size()]);
			deleteFile(folder, filenames);
			
			service.deleteImageByFolder(vo);
		}
		
		if (folder != null && service.selectImageByFolder(vo).size() > 0) {
			return "redirect:/upload/list?folder="+folder;
		}
		return "redirect:/upload/list";
	}
	
	/* 실제 이미지 파일 지우기*/
	public void deleteFile(String directory, String ...filenames){
		
//		현재파일(썸네일파일) : /directory/s_xxx.png
		for (String filename : filenames) {
			logger.info("delete file name : " + filename);
			
			if ( directory == null || directory.trim().equals("") ) {
				String realName = filename.substring(3);
				new File(uploadPath + "/" +realName).delete();
				new File(uploadPath + filename).delete();
			}
			
//			directory 존재시
			if ( directory != null && !directory.trim().equals("") ) {
//				원본지우기
				String dir = filename.substring(0, directory.length()+2); // /directory/
				String realName = filename.substring(directory.length()+4); // xxx.png
				new File(uploadPath + dir + realName).delete();
				
//				썸네일지우기
				new File(uploadPath + filename).delete();
			}
		}
		
	}//deleteFile
	
	/*외부 이미지 파일 보이도록 하는 메소드*/
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName){
		InputStream inS = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("[displayFile] fileName : "+fileName);
		
//		파일확장자만 뽑기
		String format = fileName.substring(fileName.lastIndexOf(".")+1);
		
//		패키지 com.dgit.util의 메소드를 불러와 
//		HttpHeaders에 주입
		MediaType mType = MediaUtils.getMediaType(format);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(mType); //png, jpg, gif ...
		
		try {
			inS = new FileInputStream(uploadPath + "/" + fileName);
			
//			IOUtils.toByteArray(inS); : 바이트배열로 만들어주는 메소드
			entity = new ResponseEntity<>(IOUtils.toByteArray(inS), headers, HttpStatus.CREATED);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				inS.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
}
