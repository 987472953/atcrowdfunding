package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;

public interface TMenuService {

	List<TMenu> listMenuAll(); //组合父子关系

	List<TMenu> listTMenuTree(); //不用组合父子关系

	String saveTMenu(TMenu menu);

	TMenu queryTMenuById(Integer id);

	String updateTMenu(TMenu menu);

	String deleteTMenuById(Integer id);

	List<Integer> listPermissionIdByMenuId(Integer menuId);

	String doAssginPermissionToMenu(Integer menuId, List<Integer> ids);

}
