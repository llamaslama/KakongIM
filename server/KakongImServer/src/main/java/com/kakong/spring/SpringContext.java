package com.kakong.spring;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringContext {

	private static ThreadLocal<SpringContext> sc = new ThreadLocal<SpringContext>();

	private static ConfigurableListableBeanFactory beanFactory;

	private SpringContext() {
	}

	public static SpringContext getInstance() {
		if (sc.get() == null) {
			SpringContext springContext = new SpringContext();
			ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
					"spring.xml");
			beanFactory = context.getBeanFactory();
			sc.set(springContext);
		}
		return sc.get();
	}

	public void autowire(Object bean) {
		beanFactory.autowireBeanProperties(bean,
				AutowireCapableBeanFactory.AUTOWIRE_BY_TYPE, true);
	}
}
