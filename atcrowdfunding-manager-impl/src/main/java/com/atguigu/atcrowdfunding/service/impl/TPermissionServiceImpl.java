package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService {

	@Autowired
	TPermissionMapper permissionMapper;

	@Override
	public List<TPermission> listTPermissionTree() {
		List<TPermission> list = permissionMapper.selectByExample(null);
		return list;
	}

	@Override
	public String addTPermission(TPermission permission) {
		permissionMapper.insertSelective(permission);
		return "ok";
	}

	@Override
	public String updateTPermission(TPermission permission) {
		
		permissionMapper.updateByPrimaryKeySelective(permission);
		return "OK";
	}

	@Override
	public TPermission queryPermissionById(Integer id) {
		
		TPermission permission = permissionMapper.selectByPrimaryKey(id);
		return permission;
	}

	@Override
	public String deleteTPermissionById(Integer id) {
		permissionMapper.deleteByPrimaryKey(id);
		return "ok";
	}
}
