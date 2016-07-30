import java.util.HashMap;
import java.util.Map;

import org.junit.Test;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.util.HttpUtils;
import com.anjilang.util.Response;


public class HttpUtilsTest {

	private static final String ECSHOP_URL = "http://www.angelaround.com/shop/user.php?act=act_register&laiyuan=wcm";

	@Test
	public void testPost() {
		Map<String, String> params = new HashMap<String, String>();
		params.put("username", "test");
		params.put("password ", "123456");
		params.put("email", "test@qq.com");
		
		try {
			Response response = HttpUtils.post(ECSHOP_URL, null, null, params);
			String result = response.getResponseBodyAsTrimStr();
			Response response2 =  JSONObject.parseObject(result, Response.class);
			System.out.println("code: " + response2.getCode());
			System.out.println("repsonse info: " + response2.getMessage());
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
	}

}
