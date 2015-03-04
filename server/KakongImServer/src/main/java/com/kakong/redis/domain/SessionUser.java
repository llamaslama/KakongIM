package com.kakong.redis.domain;

public class SessionUser implements NSObject {

	private static final long serialVersionUID = -139599858072744855L;

	public static final String OBJECT_KEY = "SESSIONUSER";

	private String id;

	private String name;

	private String mode;

	@Override
	public String getKey() {
		// TODO Auto-generated method stub
		return "SESSIONUSER";
	}

	@Override
	public String getObjectKey() {
		// TODO Auto-generated method stub
		return getName();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

}
