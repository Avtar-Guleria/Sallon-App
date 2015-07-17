package com.parser;
import org.json.JSONObject;
import org.json.JSONArray;
public class BaseParser {
	protected static String getString(JSONObject jsonObject, String key) {
		String value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getString(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	protected static Double getDouble(JSONObject jsonObject, String key) {
		Double value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getDouble(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	protected static Long getLong(JSONObject jsonObject, String key) {
		Long value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getLong(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	protected static Boolean getBoolean(JSONObject jsonObject, String key) {
		Boolean value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getBoolean(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	protected static JSONObject getJSONObject(JSONObject jsonObject, String key) {
		JSONObject value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getJSONObject(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	protected static JSONArray getJSONArray(JSONObject jsonObject, String key) {
		JSONArray value = null;
		try {
			if(jsonObject!=null&&jsonObject.has(key))
			{
				value=jsonObject.getJSONArray(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
}
