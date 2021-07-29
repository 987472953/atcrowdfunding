package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.bean.TRolePermission;
import com.atguigu.atcrowdfunding.bean.TRolePermissionExample;
import com.atguigu.atcrowdfunding.mapper.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.mapper.TRolePermissionMapper;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.atguigu.atcrowdfunding.util.Datas;
import com.atguigu.atcrowdfunding.util.StringUtil;
import com.github.pagehelper.PageInfo;

@Service
public class TRoleServiceImpl implements TRoleService{

	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TAdminRoleMapper adminRoleMapper;
	
	@Autowired
	TRolePermissionMapper rolePermissionMapper;

	@Override
	public PageInfo<TRole> listRolePage(Map<String, Object> paramMap) {
	
		String conditon = (String) paramMap.get("condition");
		TRoleExample example = null;
		if(!StringUtil.isEmpty(conditon)) {
			example = new TRoleExample();
			example.createCriteria().andNameLike("%"+conditon+"%");
		}
		
		List<TRole> list = roleMapper.selectByExample(example);
		
		PageInfo<TRole> page = new PageInfo<TRole>(list, 5);
		return page;
	}


	@Override
	public String saveTRole(TRole role) {
		
		
		roleMapper.insertSelective(role);

		return "ok";
	}


	@Override
	public TRole getRoleById(Integer id) {

		return roleMapper.selectByPrimaryKey(id);
	}


	@Override
	public String updateTRole(TRole role) {
		
		roleMapper.updateByPrimaryKeySelective(role);
		return "ok";
	}


	@Override
	public String deleteTRoleById(Integer id) {
		roleMapper.deleteByPrimaryKey(id);
		return "ok";
	}


	@Override
	public List<TRole> listAllRole() {
		List<TRole> roleList = roleMapper.selectByExample(null);
		return roleList;
	}


	@Override
	public List<Integer> getRoleIdByAdminId(Integer id) {
		
		
		List<Integer> RoleIdList = adminRoleMapper.getRoleIdByAdminId(id);
//		TAdminRoleExample example = null;
//		example.createCriteria().andAdminidEqualTo(id);
//		List<TAdminRole> adminRoleList = adminRoleMapper.selectByExample(example);
//		return adminRoleList;
		
		return RoleIdList;
	}


	@Override
	public String saveAdminRoleRelationship(Integer[] roleId, Integer adminId) {
		
		adminRoleMapper.saveAdminRoleRelationship(roleId, adminId);
		
		return "ok";
	}


	@Override
	public String deleteAdminRoleRelationship(Integer[] roleId, Integer adminId) {
		adminRoleMapper.deleteAdminRoleRelationship(roleId, adminId);
		return "ok";
	}


	@Override
	public List<Integer> getPermissionIdByRoleId(Integer roleId) {
		List<Integer> permissionList = rolePermissionMapper.getPermissionIdByRoleId(roleId);
		return permissionList;
	}


	@Override
	public String doAssginPermissionToRole(Integer roleId, List<Integer> ids) {
		TRolePermissionExample example = new TRolePermissionExample();
		example.createCriteria().andRoleidEqualTo(roleId);
		rolePermissionMapper.deleteByExample(example);
		TRolePermission rp = new TRolePermission();
		rp.setRoleid(roleId);
		for (Integer permissionId : ids) {
			rp.setPermissionid(permissionId);
			rolePermissionMapper.insertSelective(rp);
		}
		return "ok";
	}
}
