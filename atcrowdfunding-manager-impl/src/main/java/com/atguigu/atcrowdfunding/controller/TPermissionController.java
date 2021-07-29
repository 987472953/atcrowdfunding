package com.atguigu.atcrowdfunding.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.TPermissionService;

@Controller
public class TPermissionController {

	@Autowired
	TPermissionService permissionService;
	
	@RequestMapping("/permission/index")
	public String index() {
		return "/permission/index";
	}
	@ResponseBody
	@RequestMapping("/permission/createTree")
	public List<TPermission> createTree() {
		
		List<TPermission> list = permissionService.listTPermissionTree();
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/permission/toAdd")
	public String toAdd(TPermission permission) {
		
		String result = permissionService.addTPermission(permission);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/permission/queryPermission")
	public TPermission queryPermission(Integer id) {
		
		TPermission permission = permissionService.queryPermissionById(id);
		return permission;
	}
	
	@ResponseBody
	@RequestMapping("/permission/toUpdate")
	public String toUpdate(TPermission permission) {
		
		String result = permissionService.updateTPermission(permission);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/permission/toDelete")
	public String toDelete(Integer id) {
		
		String result = permissionService.deleteTPermissionById(id);
		return result;
	}
}
