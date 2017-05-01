package com.dgit.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtil {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtil.class);
	
	/*썸네일 이미지 만들기*/
	public static String makeThumbnail(String uploadPath, String filename) throws IOException{
		String thumbnailName = "";
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, filename));
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		thumbnailName = uploadPath + "/" + "s_" + filename;
		File newFile = new File(thumbnailName);
		
		String format = filename.substring(filename.lastIndexOf(".")+1);
		
		ImageIO.write(destImg, format, newFile);
		
		return "s_" + filename;
	}//makeThumbnail
	
	public static String uploadFile(String uploadPath, String directory, String originalName, byte[] fileData) throws IOException{
		/*c:z_image_management폴더에 생성*/
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		String savedPath = "";
		
		if (directory != null) {
			makeDir(uploadPath, directory);
			savedPath = "/"+directory;
		}
		
		File target = new File(uploadPath+savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		
		String thumbFile = UploadFileUtil.makeThumbnail(uploadPath+savedPath, savedName);
		
		return savedPath+ "/" + thumbFile;
	}
	
	private static void makeDir(String uploadPath, String directory){
		File dirPath = new File(uploadPath, directory);
		if ( !dirPath.exists() ) {
			dirPath.mkdir();
		}
	}
}
