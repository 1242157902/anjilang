package com.anjilang.controller;

import java.io.File;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.anjilang.controller.vo.UploadFile;
import com.anjilang.service.GroupTopicService;
import com.anjilang.util.DateUtil;
import com.anjilang.util.ImageUtils;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.StringUtil;

/**
 * 编辑器上传文件(图片)
 * 
 * @author xym
 * 
 */
@Controller
@RequestMapping("ckeditor")
public class EditorFileUploadController {
	
	/**
	 * 编辑器上传文件
	 * @param file
	 * @param request
	 * @return
	 */
	

	@RequestMapping(value = "fileUpload.do")
	public @ResponseBody
	String fileUpload(UploadFile file, HttpServletRequest request) {
		String callback = request.getParameter("CKEditorFuncNum");
		try {
//			File uploadFile;
			if (StringUtil.isEmpty(file.getName())) {
				file.setName(UUID.randomUUID().toString() + ".png");
			}
			String dirPath = "upload/"
					+ ((StringUtil.isEmpty(file.getFilePath())) ? "" : (file.getFilePath() + "/"))
					+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");
			@SuppressWarnings("deprecation")
			String dir = request.getRealPath("") + "/";
			dir += dirPath;
			File f = new File(dir);
			
			
			
			
			
			
			if (!f.exists()) { // 如果不存在则创建目录
				f.mkdirs();
			}
			file.getUpload().getSize();// 图片大小
			file.getUpload().getName();//
			// TODO XXX 处理图片大小限制与图片后缀限制

			ImageUtils.saveFile(file.getUpload().getInputStream(), dir, file.getName());

			// String fullPath = path
			// + "/"
			// + file.getName()
			// + "."
			// + file.getUploadFile().getOriginalFilename().split("\\.")[file
			// .getUploadFile().getOriginalFilename().split("\\.").length - 1];
			// uploadFile = new File(Constants.FILEUPLOADADDRESS+fullPath);

			// file.getUploadFile().getFileItem().write(uploadFile);
			if (StringUtil.isNotEmpty(callback)) {
				String url = PropertyUtil.newInstans().getValue("url");
				return "<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
						+ callback + ",'" + url + dirPath + file.getName() + "',''" + ")" + "</script>";
			} else {
				return "{" + file.getUpload().getOriginalFilename() + "}!Success!";
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
}
