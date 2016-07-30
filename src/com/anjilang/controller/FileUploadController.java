package com.anjilang.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.DateUtil;
import com.anjilang.util.ImageUtils;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.StringUtil;

/**
 * 文件上传
 * 
 * @author xym
 * 
 */
@Controller
@RequestMapping("upload")
public class FileUploadController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "image.do", produces = { Constants.PRODUCES })
	public @ResponseBody
	String image(HttpServletRequest request,//HttpServletResponse response,
			@RequestParam("file") CommonsMultipartFile mFile, String path) {
		//response.setContentType("text");
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]上传图片:dir=" + path);
		String dirPath = "upload/"
				+ ((StringUtil.isEmpty(path)) ? "" : (path + "/"))
				+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");

		@SuppressWarnings("deprecation")
		String dir = request.getRealPath("") + "/";
		dir += dirPath;
		File f = new File(dir);
		if (!f.exists()) { // 如果不存在则创建目录
			f.mkdirs();
		}

		mFile.getSize();// 图片大小
		mFile.getName();//
		// TODO XXX 处理图片大小限制与图片后缀限制

		JSONObject json = new JSONObject();
		try {
			String fileName = flg + ".png";
			ImageUtils.saveFile(mFile.getInputStream(), dir, fileName);
			// 图片相对路径用于存入数据库
			json.put("path", dirPath + fileName);
			// 访问图片地址
			String url = PropertyUtil.newInstans().getValue("url");
			json.put("url", url + dirPath + fileName);
			success(json);
		} catch (AjlException e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, AjlException.createErr("5020"));
		}
		log.info("[" + flg + "]" + json.toJSONString());
		return json.toJSONString();
	}
	@RequestMapping(value = "imageNew.do", produces = { Constants.PRODUCES })
	public 
void  imageNew(HttpServletRequest request,HttpServletResponse response,
			@RequestParam("file") CommonsMultipartFile mFile, String path) {
		 response.setContentType("text/html;charset=utf-8");
		 //response.setContentType("application/json;charset=utf-8");		 
		 
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]上传图片:dir=" + path);
		String dirPath = "upload/"
				+ ((StringUtil.isEmpty(path)) ? "" : (path + "/"))
				+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");
		
		@SuppressWarnings("deprecation")
		String dir = request.getRealPath("") + "/";
		dir += dirPath;
		File f = new File(dir);
		if (!f.exists()) { // 如果不存在则创建目录
			f.mkdirs();
		}
		
		mFile.getSize();// 图片大小
		mFile.getName();//
		// TODO XXX 处理图片大小限制与图片后缀限制
		
		 JSONObject json = new JSONObject(); 
		try {
			String fileName = flg + ".png";
			ImageUtils.saveFile(mFile.getInputStream(), dir, fileName);
			// 图片相对路径用于存入数据库
		 json.put("path", dirPath + fileName); 
			path = dirPath + fileName;
			// 访问图片地址
			String url = PropertyUtil.newInstans().getValue("url");
			json.put("url", url + dirPath + fileName); 
			success(json);
		} catch (AjlException e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, e);
		} catch (Throwable e) {
			log.error("[" + flg + "]保存图片失败", e);
			error(json, AjlException.createErr("5020"));
		}
		log.info("[" + flg + "]" + json.toJSONString());
			System.out.println("-------------------->"+json.toJSONString());
			try {
				response.getWriter().write(json.toJSONString());
			} catch (IOException e) {
				e.printStackTrace();
			}
	/*	return json.toJSONString();*/
		
	}

}
