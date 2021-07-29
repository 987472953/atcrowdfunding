package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.atguigu.atcrowdfunding.util.Const;

/**
 * 监听application对象创建和销毁
 * @author 98747
 *
 */
public class SystemUpinitListener implements ServletContextListener {

	Logger log = LoggerFactory.getLogger(SystemUpinitListener.class);
	
	//当application创建时执行初始化方法
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		String contextPath = application.getContextPath();
		application.setAttribute(Const.PATH, contextPath);
		log.debug("PATH={}", contextPath);
	}
	//当application销毁时执行销毁方法
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		log.debug("当前application对象销毁");
	}

}
