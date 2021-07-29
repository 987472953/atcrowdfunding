package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.service.TMenuService;
import com.atguigu.atcrowdfunding.util.Const;

@Controller
public class DispatcherController {

	Logger log = LoggerFactory.getLogger(DispatcherController.class);
	
	@Autowired
	TAdminService adminService;
	
	@Autowired
	TMenuService menuService;
	
	
	
	@RequestMapping("/main")
	public String main(HttpSession session) {
		log.debug("跳转到登录main主页面！");
		
		if(session==null) {
			return "redirect:/toLogin";
		}
		//存放父菜单
		List<TMenu> menuList = (List<TMenu>) session.getAttribute("menuList");
		if(menuList==null) {
			menuList = menuService.listMenuAll();
			session.setAttribute("menuList", menuList);
		}	
				
		return "main";
	}
	
	@RequestMapping("/index")//<!-- http://localhost:8080/atcrowdfunding-main/ -->
	public String index() {
		log.debug("跳转到系统的主页面！");
		return "index";
	}
	
	@RequestMapping("/toLogin")
	public String login() {
		log.debug("跳转到登录的主页面！");
		return "login";
	}
	
//	@RequestMapping("/logout")
//	public String logout(HttpSession session) {
//		log.debug("退出登录！");
//		if(session!=null) {
//			session.removeAttribute(Const.LOGIN_ADMIN);
//			session.invalidate();
//		}
//		return "redirect:/index";
//	}
	
//	@RequestMapping("/doLogin")
//	public String doLogin(String loginacct, String userpswd, HttpSession session, Model model) {
//		log.debug("开始登陆......");
//		log.debug("loginacct={}", loginacct);
//		log.debug("password={}", userpswd);
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put(Const.LOGIN_ADMIN, loginacct);
//		map.put("password", userpswd);
//		try {
//			TAdmin admin = adminService.getTAdminByPassword(map);
//			session.setAttribute(Const.LOGIN_ADMIN, admin);
//			log.debug("登录成功！");
////			return "main";避免表单重复提交，采用重定向
//			return "redirect:/main";
//		} catch (Exception e) {
//			log.debug("登录失败={}", e.getMessage());
//			model.addAttribute(Const.MESSAGE, e.getMessage());
//			return "login";
//		}
//		
//	}
	
}
