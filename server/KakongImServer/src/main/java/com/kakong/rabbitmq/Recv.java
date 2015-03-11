package com.kakong.rabbitmq;

import com.kakong.redis.domain.Message;
import com.kakong.redis.domain.SessionUser;
import com.kakong.spring.GsonUtil;
import com.kakong.spring.KaKongIMSession;
import com.kakong.spring.SpringContextsUtil;
import com.rabbitmq.client.ConnectionFactory;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.ConsumerCancelledException;
import com.rabbitmq.client.QueueingConsumer;
import com.rabbitmq.client.ShutdownSignalException;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.socketio.netty.ISession;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * @author: towne
 * @since: 15-2-28 下午2:37
 */
public class Recv implements Runnable {

	private final static String QUEUE_NAME = "hello";

	private static final KaKongIMSession session = (KaKongIMSession) SpringContextsUtil
			.getBean("kakongimsession");

	@SuppressWarnings("unchecked")
	private static final RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextsUtil
			.getBean("redisTemplate");

	private Map msgtype;

	Recv() {
		System.out
				.println("================== RabbitMQ RECV ==================");
		Thread t1 = new Thread(this);
		t1.start();
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			ConnectionFactory factory = new ConnectionFactory();
			factory.setHost("127.0.0.1");
			Connection connection;

			connection = factory.newConnection();
			Channel channel = connection.createChannel();

			channel.queueDeclare(QUEUE_NAME, false, false, false, null);
			System.out.println("Waiting for messages. To exit press CTRL+C");

			QueueingConsumer consumer = new QueueingConsumer(channel);
			channel.basicConsume(QUEUE_NAME, true, consumer);

			while (true) {
				QueueingConsumer.Delivery delivery = consumer.nextDelivery();
				String message = new String(delivery.getBody());
				System.out.println(" [x] Received '" + message + "'");
				System.out.println(session.getUsers());

				msgtype = GsonUtil.jsonToMap(message);
				Integer mode = Integer.parseInt((String) msgtype.get("mode"));

				switch (mode) {
				case 0:
					SessionUser user = (SessionUser) GsonUtil.jsonToModel(
							message, SessionUser.class);
					redisTemplate.opsForHash().put(SessionUser.OBJECT_KEY,
							user.getName(), user);
					List<SessionUser> users = new ArrayList<SessionUser>();
					for (Object o : redisTemplate.opsForHash().values(
							SessionUser.OBJECT_KEY)) {
						users.add((SessionUser) o);
					}
					System.out.println(users);
					break;

				case 1:
					Message x = (Message) GsonUtil.jsonToModel(message,
							Message.class);
					redisTemplate.opsForHash().put(Message.OBJECT_KEY,
							x.getCid(), x);

					// 即时转发消息逻辑
					String touserid = x.getToid();
					SessionUser touser = (SessionUser) redisTemplate
							.opsForHash().get(SessionUser.OBJECT_KEY, touserid);
					System.out.println(touser);
					ISession tosession = session.getUsers().get(touser.getId());
					ByteBuf buf = Unpooled.copiedBuffer(message.getBytes());
					tosession.send(buf);
					break;
				default:
					break;
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ShutdownSignalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ConsumerCancelledException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
