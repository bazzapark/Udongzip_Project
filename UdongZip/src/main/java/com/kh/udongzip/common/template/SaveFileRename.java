package com.kh.udongzip.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public class SaveFileRename {
	
	/**
	* 업체회원 증빙서류 업로드용 메소드
	* 업체명 + 업로드 시간 + 확장자명으로 rename 후 /resources/agentDocumens 폴더에 저장
	*
	* @version 1.0
	* @author 박민규
	* @param String agentName
	* @param MultipartFile upfile 업로드 하려는 파일
	* @return 저장경로 + 변경된 이름
	*
	*/
	public String saveDocument(int agentNo,
							   MultipartFile upfile,
							   HttpSession session) {
		
		// 1. 원본 파일명 가져오기
		String originName = upfile.getOriginalFilename();
					
		// 2. 시간 형식을 문자열로 가져오기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
					
		// 3. 확장자명 가져오기
		String ext = originName.substring(originName.lastIndexOf("."));
					
		// 4. 합치기
		String changeName = agentNo + "_" + currentTime + ext;
					
		// 5. 업로드 하고자 하는 물리적인 경로 가져오기
		String savePath = session.getServletContext().getRealPath("/resources/images/agentDocuments/");
					
		// 6. 경로와 수정파일명을 합체시킨 후 저장
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return "resources/images/agentDocuments/" + changeName;
		
	}
	
	/**
	* 매물 사진 업로드용 메소드
	* 매물번호 + 업로드 시간 + 확장자명으로 rename 후 /resources/agentDocumens 폴더에 저장
	*
	* @version 1.0
	* @author 박민규
	* @param int houseNo 매물 번호
	* @param MultipartFile upfile 업로드 하려는 파일
	* @return 저장경로 + 변경된 이름
	*
	*/
	public String saveHouseImg(int houseNo,
							   MultipartFile upfile,
							   HttpSession session) {
		
		// 1. 원본 파일명 가져오기
		String originName = upfile.getOriginalFilename();
					
		// 2. 시간 형식을 문자열로 가져오기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
					
		// 3. 확장자명 가져오기
		String ext = originName.substring(originName.lastIndexOf("."));
					
		// 4. 합치기
		String changeName = houseNo + "_" + currentTime + ext;
					
		// 5. 업로드 하고자 하는 물리적인 경로 가져오기
		String savePath = session.getServletContext().getRealPath("/resources/images/houseImges/");
					
		// 6. 경로와 수정파일명을 합체시킨 후 저장
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return "resources/images/houseImgses/" + changeName;
		
	}

}
