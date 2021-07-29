package com.atguigu.atcrowdfunding.service;

import java.util.List;
import java.util.Map;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface TRoleService {

	PageInfo<TRole> listRolePage(Map<String, Object> paramMap);

	String saveTRole(TRole role);

	TRole getRoleById(Integer id);

	String updateTRole(TRole role);

	String deleteTRoleById(Integer id);

	List<TRole> listAllRole();

	List<Integer> getRoleIdByAdminId(Integer id);

	String saveAdminRoleRelationship(Integer[] roleId, Integer adminId);

	String deleteAdminRoleRelationship(Integer[] roleId, Integer adminId);

	List<Integer> getPermissionIdByRoleId(Integer roleId);

	String doAssginPermissionToRole(Integer roleId, List<Integer> ids);


}
