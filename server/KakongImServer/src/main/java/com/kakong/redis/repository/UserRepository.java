package com.kakong.redis.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import com.kakong.redis.domain.SessionUser;

public abstract class UserRepository implements Repository<SessionUser> {

	@Autowired
	private RedisTemplate<String, SessionUser> redisTemplate;

	@Override
	public void put(SessionUser user) {
		redisTemplate.opsForHash()
				.put(user.getObjectKey(), user.getKey(), user);
	}

	@Override
	public SessionUser get(SessionUser user) {
		return (SessionUser) redisTemplate.opsForHash().get(
				user.getObjectKey(), user.getKey());
	}

	@Override
	public void delete(SessionUser user) {
		redisTemplate.opsForHash().delete(user.getObjectKey(), user.getKey());
	}

	@Override
	public List<SessionUser> getObjects() {
		List<SessionUser> users = new ArrayList<SessionUser>();
		for (Object user : redisTemplate.opsForHash().values(
				SessionUser.OBJECT_KEY)) {
			users.add((SessionUser) user);
		}
		return users;
	}

	/**
	 * @return the redisTemplate
	 */
	public RedisTemplate<String, SessionUser> getRedisTemplate() {
		return redisTemplate;
	}

	/**
	 * @param redisTemplate
	 *            the redisTemplate to set
	 */
	public void setRedisTemplate(
			RedisTemplate<String, SessionUser> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

}
