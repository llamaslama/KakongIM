package com.kakong.netty.example.server;


import io.netty.buffer.ByteBuf;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.socketio.netty.ISession;
import org.socketio.netty.ISocketIOListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;

import com.kakong.spring.KaKongIMSession;
import com.kakong.spring.SpringContextsUtil;


public class EchoSocketIOListener implements ISocketIOListener {
	 
	private static final RabbitTemplate rabbitTemplate = (RabbitTemplate) SpringContextsUtil.getBean("rabbitTemplate");

	private static final KaKongIMSession session = (KaKongIMSession) SpringContextsUtil
			.getBean("kakongimsession");

	private static final Logger log = LoggerFactory
			.getLogger(EchoSocketIOListener.class);

	@Override
	public void onConnect(final ISession client) {
		if (log.isDebugEnabled())
			log.debug("{}/{}: onConnect", client.getSessionId(),
					client.getLocalPort());
		if (client.getSessionId() != null)
			session.getUsers().put(client.getSessionId(), client);
	}

	@Override
	public void onMessage(final ISession client, final ByteBuf message) {
		if (log.isDebugEnabled())
			log.debug("{}/{}: onMessage: {}", client.getSessionId(),
					client.getLocalPort(), message);

		byte[] dest = new byte[message.readableBytes()];
		message.readBytes(dest);
		String ddd = new String(dest);
		System.out.println(ddd);
		rabbitTemplate.convertAndSend("hello", ddd);
	}

	@Override
	public void onDisconnect(final ISession client) {
		if (log.isDebugEnabled())
			log.debug("{}/{}: onDisconnect", client.getSessionId(),
					client.getLocalPort());
		if (client.getSessionId() != null)
			session.getUsers().remove(client.getSessionId());
	}
}
