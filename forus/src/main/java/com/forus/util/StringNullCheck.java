package com.forus.util;

public class StringNullCheck {
	/**
	 * 문자열이 null이 아니고, 비어있지 않은지 검사하는 메서드
	 * @param string 검사할 문자열
	 * @return 문자열이 null 또는 빈 문자열이 아닌 경우 true 반환
	 */
	public static boolean isNotEmpty(String string) {
		return string != null && !string.trim().isEmpty();
	}


	/**
	 * 문자열이 null이거나, 비어있는지 검사하는 메서드
	 * @param string 검사할 문자열
	 * @return 문자열이 null 또는 빈 문자열인 경우 true 반환
	 */
	public static boolean isEmpty(String string) {
		return string == null || string.trim().isEmpty();
	}
}
