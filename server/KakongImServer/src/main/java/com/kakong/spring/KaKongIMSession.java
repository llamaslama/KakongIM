package com.kakong.spring;

import java.util.HashMap;

import org.socketio.netty.ISession;

public class KaKongIMSession {

	public static final HashMap<String, ISession> users;

	static {
		users = new HashMap<String, ISession>();
	}

	public HashMap<String, ISession> getUsers() {
		return users;
	}

	public ISession getSesson(String SessionId) {

		return users.get(SessionId);
	}
}
