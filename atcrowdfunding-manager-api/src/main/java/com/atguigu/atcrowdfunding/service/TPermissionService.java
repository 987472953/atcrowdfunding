package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TPermission;

public interface TPermissionService {

	List<TPermission> listTPermissionTree();

	String addTPermission(TPermission permission);

	String updateTPermission(TPermission permission);

	TPermission queryPermissionById(Integer id);

	String deleteTPermissionById(Integer id);

	
}
