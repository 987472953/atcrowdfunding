package com.atguigu.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TAdminController {

	Logger log = LoggerFactory.getLogger(TAdminController.class);
	
	@Autowired
	TAdminService adminService;
	
	@Autowired
	TRoleService roleService;
	
	@RequestMapping("/admin/index")//分页
	public String index(@RequestParam(value="pageNum", required = false, defaultValue = "1")Integer pageNum, 
						@RequestParam(value="pageSize", required = false, defaultValue = "5")Integer pageSize,
						Model model,
						@RequestParam(value="condition", required = false, defaultValue = "")String condition) {
		
		log.debug("conditon={}", condition);
		
		PageHelper.startPage(pageNum, pageSize);//线程绑定
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("condition", condition);
		
		PageInfo<TAdmin> page = adminService.listAdminPage(paramMap);
		
		model.addAttribute("page", page);
		model.addAttribute("condition", condition);
		
		
		return "admin/index";
	}
	
	@RequestMapping("/admin/toAdd")
	public String toAdd() {
		
		return "/admin/add";	
	}
	
	@PreAuthorize("hasRole('PM - 项目经理')")
	@RequestMapping("/admin/doAdd")
	public String doAdd(TAdmin admin) {
		
		adminService.saveTAdmin(admin);
		
		return "redirect:/admin/index?pageNum=" + Integer.MAX_VALUE;	
	}
	
	
	
	@RequestMapping("/admin/toUpdate")
	public String toUpData(Integer id, Model model) {
		
		TAdmin admin = adminService.getTAdminById(id);
		model.addAttribute("admin", admin);
		System.out.println(admin);
		return "admin/update";	
	}
	
	@RequestMapping("admin/doUpdate")
	public String doUpdate(TAdmin admin, Integer pageNum) {
		
		adminService.updateTAdmin(admin);
		
		return "redirect:/admin/index?pageNum=" + pageNum;	
	}
	
	
	@RequestMapping("admin/toDelete")
	public String toDelete(Integer id, Integer pageNum) {
		
		adminService.deleteTAdminById(id);
		
		return "redirect:/admin/index?pageNum=" + pageNum;	
	}
	
	@RequestMapping("admin/toDeleteBatch")
	public String toDeleteBatch(String ids, Integer pageNum) {
		
		String[] split = ids.split(",");
		ArrayList<Integer> idList = new ArrayList<Integer>();
		for (String idStr : split) {
			int id = Integer.parseInt(idStr);
			idList.add(id);
		}
		adminService.deleteBatch(idList);
		
		return "redirect:/admin/index?pageNum=" + pageNum;	
	}
	
	@RequestMapping("/admin/toAssign")
	public String toAssign(Integer id, Model model) {
		
//		1、查询所有角色
		List<TRole> allList = roleService.listAllRole();
//		2、根据用户id查询已经拥有的角色id
		List<Integer> roleIdList = roleService.getRoleIdByAdminId(id);
//		3、将所有角色，进行划分
		
		List<TRole> assginList = new ArrayList<TRole>();
		List<TRole> unassginList = new ArrayList<TRole>();
		
		model.addAttribute("assginList", assginList);
		model.addAttribute("unassginList", unassginList);
		
		for (TRole role : allList) {
			if(roleIdList.contains(role.getId())) {//4、已分配角色集合
				assginList.add(role);
			}else {//5、未分配角色集合
				unassginList.add(role);
			}
		}

		return "/admin/assign";	
	}
	
	@ResponseBody
	@RequestMapping("/admin/doAssgin")
	public String doAssgin(Integer[] roleId, Integer adminId){
		
		String result = roleService.saveAdminRoleRelationship(roleId, adminId);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/admin/removeAssgin")
	public String removeAssgin(Integer[] roleId, Integer adminId){
		
		String result = roleService.deleteAdminRoleRelationship(roleId, adminId);
		return result;
	}
	
}
