package com.kakong.netty.example.server;

import io.netty.util.internal.logging.InternalLoggerFactory;
import io.netty.util.internal.logging.Slf4JLoggerFactory;
import org.socketio.netty.ServerConfiguration;
import org.socketio.netty.SocketIOServer;

import com.kakong.spring.SpringSupport;

public class ServerLauncher extends SpringSupport {

	private static final int SOCKETIO_PORT = 4810;
	// private static final int HEARTBEAT_INTERVAL = 25;
	private static final int HEARTBEAT_INTERVAL = 1;
	private static final int HEARTBEAT_TIMEOUT = 60;
	private static final int CLOSE_TIMEOUT = 60;
	private static final String SOCKETIO_TRANSPORTS = "websocket,flashsocket,xhr-polling,jsonp-polling";

	public void start() {
	
		InternalLoggerFactory.setDefaultFactory(new Slf4JLoggerFactory());
		ServerConfiguration.Builder configurationBuilder = new ServerConfiguration.Builder();
		configurationBuilder.setPort(SOCKETIO_PORT)
				.setTransports(SOCKETIO_TRANSPORTS)
				.setHeartbeatInterval(HEARTBEAT_INTERVAL)
				.setHeartbeatTimeout(HEARTBEAT_TIMEOUT)
				.setCloseTimeout(CLOSE_TIMEOUT).setEventExecutorEnabled(true);

		SocketIOServer socketioServer = new SocketIOServer(
				configurationBuilder.build());
		socketioServer.setListener(new EchoSocketIOListener());

		socketioServer.start();
	}

	public static void main(String[] args) {
		ServerLauncher appMain = new ServerLauncher();
		appMain.start();
	}

}
