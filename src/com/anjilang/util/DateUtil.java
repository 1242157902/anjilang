package com.anjilang.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

/**
 * 
 * 日期工具类
 * 
 * @author xiongyuanming
 * @version premas.1.0
 * @see
 * @since 2014年7月11日
 */
public final class DateUtil {
	private static Logger log = Logger.getLogger(DateUtil.class);

	private DateUtil() {

	}

	/** 时间格式-yyyy-MM-dd HH:mm:ss */
	public final static String FORMMAT_1 = "yyyy-MM-dd HH:mm:ss";
	/** 时间格式-yyyyMMddHHmmss */
	public final static String FORMMAT_2 = "yyyyMMddHHmmss";
	public final static String FORMMAT_2_1 = "000000";
	public final static String FORMMAT_2_2 = "235959";
	/** 时间格式-yyyy-MM-dd */
	public final static String FORMMAT_3 = "yyyy-MM-dd";

	/**
	 * 将d转化为 yyyy-MM-dd HH:mm:ss时间格式
	 * 
	 * @param d
	 *            Date
	 * @return
	 */
	public static String formatDate1(Date d) {
		return formatDate(d, FORMMAT_1);
	}

	/**
	 * 将d转化为 yyyyMMddHHmmss时间格式
	 * 
	 * @param d
	 *            Date
	 * @return
	 */
	public static String formatDate2(Date d) {
		return formatDate(d, FORMMAT_2);
	}

	/**
	 * 将d转化为 yyyy-MM-dd时间格式
	 * 
	 * @param d
	 * @return
	 */
	public static String formatDate3(Date d) {
		return formatDate(d, FORMMAT_3);
	}

	/**
	 * 将时间延后minute分钟
	 * 
	 * @param d
	 *            Date
	 * @param minute
	 *            int
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static void delayMinute(Date d, int minute) {
		d.setMinutes(d.getMinutes() + minute);
	}

	/**
	 * 将时间延后day天
	 * 
	 * @param d
	 * @param day
	 */
	@SuppressWarnings("deprecation")
	public static void delayDate(Date d, int day) {
		d.setDate(d.getDate() + day);
	}

	/**
	 * 将时间按照指定格式进行格式化
	 * 
	 * @param d
	 * @param formmatStr
	 * @return
	 */
	public static String formatDate(Date d, String formmatStr) {
		if (d == null) {
			return "";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(formmatStr);
		try {
			return sdf.format(d);
		} catch (Exception e) {
			log.error("格式时间出错date=" + d + ".formmatStr=" + formmatStr, e);
			return "";
		}
	}

	/**
	 * 将formmatStr格式时间串date格式化为Date时间
	 * 
	 * @param date
	 * @param formmatStr
	 * @return
	 */
	public static Date parseDate(String date, String formmatStr) {
		SimpleDateFormat sdf = new SimpleDateFormat(formmatStr);
		try {
			return sdf.parse(date);
		} catch (Exception e) {
			log.error("格式时间出错date=" + date + ".formmatStr=" + formmatStr, e);
			return null;
		}
	}

	/**
	 * 格式化开始日期
	 * 
	 * @param startDate
	 *            yyyyMMdd
	 * @return
	 * @throws AppException
	 */
	public static Date parseStartDate(String startDate) throws AjlException {
		try {
			return StringUtil.isEmpty(startDate) ? null : DateUtil.parseDate(
					startDate + FORMMAT_2_1, FORMMAT_2);
		} catch (Exception e) {
			log.error("字符串时间2Date失败endDate=" + startDate + ":", e);
			throw AjlException.createErr("5019");
		}
	}

	/**
	 * 格式化开始日期
	 * 
	 * @param startDate
	 *            yyyyMMdd
	 * @return
	 * @throws AppException
	 */
	public static Date parseEndDate(String endDate) throws AjlException {
		try {
			return StringUtil.isEmpty(endDate) ? null : DateUtil.parseDate(
					endDate + FORMMAT_2_2, FORMMAT_2);
		} catch (Exception e) {
			log.error("字符串时间2Date失败endDate=" + endDate + ":", e);
			throw AjlException.createErr("5019");
		}
	}
	
	public static Date parse2Date(String dateStr, String format)
			throws AjlException {
		try {
			return StringUtil.isEmpty(dateStr) ? null : DateUtil.parseDate(
					dateStr, format);
		} catch (Exception e) {
			log.error("字符串时间2Date失败endDate=" + dateStr + ":", e);
			throw AjlException.createErr("5019");
		}
	}
}
