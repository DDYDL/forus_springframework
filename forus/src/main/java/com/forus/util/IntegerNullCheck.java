package com.forus.util;
public class IntegerNullCheck {
	/**
	 * 문자열을 Integer로 변환하는 메서드
	 * 변환할 수 없는 경우 null을 반환
	 * @param string 변환할 문자열
	 * @return 변환된 Integer 값 또는 null
	 */
	public static Integer parseInteger(String string) {
		if (StringNullCheck.isNotEmpty(string)) {
			try {
				return Integer.parseInt(string);
			} catch (NumberFormatException e) {
				// 예외 발생 시 null 반환
				return null;
			}
		}
		return null;
	}
}
