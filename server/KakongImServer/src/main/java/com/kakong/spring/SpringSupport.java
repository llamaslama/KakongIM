package com.kakong.spring;

public class SpringSupport {

	public SpringSupport() {

		SpringContext.getInstance().autowire(this);

	}
}
