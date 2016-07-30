package com.anjilang.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.log4j.Logger;


/**
 * 图片工具
 * 
 * @author xiongyuanming
 * @version pre .1.0
 * @see
 * @since 2014年8月18日
 */
public final class ImageUtils {
	private ImageUtils() {
		
	}
	private static final Logger LOGGER = Logger.getLogger(ImageUtils.class);

	/**
	 * 将流转换为图片保存到服务器指定路径上
	 * 
	 * @param in
	 *            - InputStream
	 * @param dir
	 *            - 文件目录
	 * @param fileName
	 *            - 文件名称
	 * @param logFlag
	 *            - 日志标识
	 * @throws AppException 
	 */
	public static void saveFile(InputStream in, String dir, String fileName) throws AjlException {
		FileOutputStream fos = null;
		try {
			File file = new File(dir, fileName);// 可以是任何图片格式.jpg,.png等
			fos = new FileOutputStream(file);

			byte[] b = new byte[1024*10];
			int nRead = 0;
			while ((nRead = in.read(b)) != -1) {
				fos.write(b, 0, nRead);
			}

		} catch (Exception e) {
			LOGGER.error(fileName, e);
			throw AjlException.createErr("5009");
		} finally {
			try {
				if (fos != null) {
					fos.flush();
					fos.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException e) {
				LOGGER.error("关闭写文件流异常", e);
			}
		}
	}
}
