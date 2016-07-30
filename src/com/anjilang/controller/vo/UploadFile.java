package com.anjilang.controller.vo;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * 上传图片文件域其他字段VO
 * @author xym
 *
 */
public class UploadFile {
	private String name;
	// 此字段名与ckeditor.js中配置的name属性的值相同默认是upload
    private CommonsMultipartFile upload;
    private String filePath;
 
    public CommonsMultipartFile getUpload() {
		return upload;
	}
	public void setUpload(CommonsMultipartFile upload) {
		this.upload = upload;
	}
	public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
