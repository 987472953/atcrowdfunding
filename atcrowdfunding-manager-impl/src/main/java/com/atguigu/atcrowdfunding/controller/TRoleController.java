package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.atguigu.atcrowdfunding.util.Datas;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TRoleController {

	@Autowired
	TRoleService roleService;

	@RequestMapping("/role/index")
	public String index() {

		return "role/index";
	}

	/*
	 * 启用消息转换器：HttpMessageConverter
	 * 
	 * 如果返回结果为对象类型（Entity Class，List，Map。。），启用这个转换器：
	 * MappingJackson2HttpMessageConverter 使用jkson组件
	 * 如果返回结果为String对象类型，启用这个转换器：StringHttpMessageConverter 将字符串原样输出
	 * 
	 */
	@ResponseBody // 将java对象转为json格式的数据
	@RequestMapping("/role/loadData")
	public PageInfo<TRole> loadData(
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
			@RequestParam(value = "pageSize", required = false, defaultValue = "5") Integer pageSize,
			@RequestParam(value = "condition", required = false, defaultValue = "") String condition) {

		PageHelper.startPage(pageNum, pageSize);
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("condition", condition);
		PageInfo<TRole> page = roleService.listRolePage(paramMap);

		return page;// 转换为json串返回
	}
	
	@PreAuthorize("hasRole('PM - 项目经理')")
	@ResponseBody
	@RequestMapping("/role/toAdd")
	public String toAdd(TRole role) {

		String result = roleService.saveTRole(role);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/role/queryRole")
	public TRole queryRole(@RequestParam(value="id", required = false, defaultValue = "0")Integer id) {

		TRole role = roleService.getRoleById(id);
		
		return role;
	}
	
	@ResponseBody
	@RequestMapping("/role/toUpdate")
	public String updateRole(TRole role) {

		String result = roleService.updateTRole(role);
		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/role/toDelete")
	public String toDelete(Integer id) {

		String result = roleService.deleteTRoleById(id);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/role/queryPermissionIdByRoleId")
	public List<Integer> queryPermissionIdByRoleId(Integer roleId){
		List<Integer> permissionList = roleService.getPermissionIdByRoleId(roleId);
		return permissionList;
	}
	
	@ResponseBody
	@RequestMapping("/role/doAssginPermissionToRole")
	public String doAssginPermissionToRole(Integer roleId, Datas ds) {

		String result = roleService.doAssginPermissionToRole(roleId, ds.getIds());
		
		return result;
	}

}
