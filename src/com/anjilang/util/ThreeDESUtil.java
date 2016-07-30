package com.anjilang.util;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.Security;
import java.util.Arrays;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

/**
 * DES加密模块
 * 
 * @author majun
 * 
 */
public final class ThreeDESUtil {
	private ThreeDESUtil() {

	}

	static {
		Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	}

	private static final String ALGORITHM = "DESede"; // 定义
														// 加密算法,可用'DES','DESede','Blowfish'

	/**
	 * 3DES加密数据
	 * 
	 * @param keyStr
	 * @param srcStr
	 * @return
	 * @throws Exception
	 */
	public static String encryptData(String keyStr, String srcStr) throws Exception {
//		byte[] key = StringUtil.hex2byte(keyStr);
		// key 16bytes
		byte[] key = keyStr.getBytes(Constants.ENCODE);
		// 需要对源数据进行补齐
		byte[] src = srcStr.getBytes(Constants.ENCODE);
		int len = src.length;
		// 补齐为8的整数倍
		int paddingLen = (len % 8 == 0) ? 0 : (8 - (len % 8));

		byte[] srcPad = new byte[len + paddingLen];
		// 补齐内容为0x0
		Arrays.fill(srcPad, (byte) 0x0);
		// 将加密数据拷贝到加密数组中
		System.arraycopy(src, 0, srcPad, 0, len);

		byte[] result = encryptData(key, srcPad);
		return StringUtil.byte2hex(result);

	}

	/**
	 * 3DES解密数据
	 * 
	 * @param keyStr
	 *            - hex字符串
	 * @param chiperStr
	 *            - hex字符串
	 * @return
	 * @throws Exception
	 */
	public static String decryptData(String keyStr, String chiperStr) throws Exception {
//		byte[] key = StringUtil.hex2byte(keyStr);
		// key 16bytes
		byte[] key = keyStr.getBytes(Constants.ENCODE);
		byte[] chiper = StringUtil.hex2byte(chiperStr);

		byte[] decrypt = decryptData(key, chiper);
		return new String(decrypt, Constants.ENCODE);
	}

	/**
	 * encrypt data by 3des
	 * 
	 * @param key
	 * @param src
	 * @return
	 * @throws NoSuchPaddingException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws BadPaddingException
	 * @throws IllegalBlockSizeException
	 */
	public static byte[] encryptData(byte[] key, byte[] src) throws NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		// 生成密钥
		SecretKey deskey = new SecretKeySpec(key, ALGORITHM);
		// 加密
		Cipher c1 = Cipher.getInstance(ALGORITHM + "/ECB/NoPadding");
		c1.init(Cipher.ENCRYPT_MODE, deskey);
		return c1.doFinal(src);
	}

	/**
	 * decrypt data by 3des
	 * 
	 * @param key
	 * @param src
	 * @return
	 * @throws NoSuchPaddingException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws BadPaddingException
	 * @throws IllegalBlockSizeException
	 */
	public static byte[] decryptData(byte[] key, byte[] src) throws NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		// 生成密钥
		SecretKey deskey = new SecretKeySpec(key, ALGORITHM);
		// 解密
		Cipher c1 = Cipher.getInstance(ALGORITHM + "/ECB/NoPadding");
		c1.init(Cipher.DECRYPT_MODE, deskey);
		return c1.doFinal(src);
	}
}
