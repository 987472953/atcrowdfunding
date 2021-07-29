package com.atguigu.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.TMenuService;
import com.atguigu.atcrowdfunding.util.Datas;

@Controller
public class TMenuController {

	@Autowired
	TMenuService menuService;
	
	@RequestMapping("/menu/index")
	public String index() {
		return "menu/index";
	}
	
	@ResponseBody
	@RequestMapping("/menu/createTree")
	public List<TMenu> createTree() {
		
		List<TMenu> list = menuService.listTMenuTree();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/menu/toAdd")
	public String toAdd(TMenu menu) {
		
		String result = menuService.saveTMenu(menu);
		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/menu/queryMenu")
	public TMenu queryMenu(@RequestParam(value = "id", required = false, defaultValue = "0") Integer id) {
		
		TMenu menu = menuService.queryTMenuById(id);
		
		return menu;
	}
	
	@ResponseBody
	@RequestMapping("/menu/toUpdate")
	public String toUpdate(TMenu menu) {
		
		String result = menuService.updateTMenu(menu);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/menu/toDelete")
	public String toDelete(Integer id) {
		
		String result = menuService.deleteTMenuById(id);
		
		return result;
	}
	@ResponseBody
	@RequestMapping("/menu/queryPermissionIdByMenuId")
	public List<Integer> queryPermissionIdByMenuId(Integer menuId) {
		
		List<Integer> muneList = menuService.listPermissionIdByMenuId(menuId);
		
		return muneList;
	}
	
	@ResponseBody
	@RequestMapping("/menu/doAssginPermissionToMenu")
	public String doAssginPermissionToMenu(Integer menuId, Datas ds) {
		
		String result = menuService.doAssginPermissionToMenu(menuId, ds.getIds());
		
		return result;
	}
}
