package com.kakong.redis.repository;

import java.util.List;

import com.kakong.redis.domain.NSObject;



public interface Repository<V extends NSObject> {

    void put(V obj);

    V get(V key);

    void delete(V key);

    List<V> getObjects();
}
