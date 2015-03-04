package com.kakong.redis.domain;

import java.io.Serializable;

public interface NSObject extends Serializable {
    
    String getKey();

    String getObjectKey();
}