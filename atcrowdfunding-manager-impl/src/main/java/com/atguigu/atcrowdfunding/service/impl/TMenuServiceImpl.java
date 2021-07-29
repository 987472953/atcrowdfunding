package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermissionMenu;
import com.atguigu.atcrowdfunding.bean.TPermissionMenuExample;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMenuMapper;
import com.atguigu.atcrowdfunding.service.TMenuService;

@Service
public class TMenuServiceImpl implements TMenuService {

	Logger log = LoggerFactory.getLogger(TMenuServiceImpl.class);
	@Autowired
	TMenuMapper menuMapper;
	
	@Autowired
	TPermissionMenuMapper permissionMenuMapper;

	@Override
	public List<TMenu> listMenuAll() {
		List<TMenu> menuList = new ArrayList<TMenu>();// 只存放父菜单，但是将children属性赋值
		List<TMenu> allList = menuMapper.selectByExample(null);

		Map<Integer, TMenu> cache = new HashMap<Integer, TMenu>();

		for (TMenu tMenu : allList) {
			if (tMenu.getPid() == 0) {// 父菜单
				menuList.add(tMenu);
				cache.put(tMenu.getId(), tMenu);
			}
		}
		for (TMenu tMenu : allList) {
			if (tMenu.getPid() != 0) {// 父菜单
				Integer pid = tMenu.getPid();
				TMenu parent = cache.get(pid);
				parent.getChildren().add(tMenu);// 根据pid进行添加
			}
		}
		log.debug("菜单={}", menuList);
		return menuList;
	}

	@Override
	public List<TMenu> listTMenuTree() {
		
		List<TMenu> list = menuMapper.selectByExample(null);
		return list;
	}

	@Override
	public String saveTMenu(TMenu menu) {

		menuMapper.insertSelective(menu);
		return "OK";
	}

	@Override
	public TMenu queryTMenuById(Integer id) {
		TMenu menu = menuMapper.selectByPrimaryKey(id);
		return menu;
	}

	@Override
	public String updateTMenu(TMenu menu) {
		menuMapper.updateByPrimaryKeySelective(menu);
		return "ok";
	}

	@Override
	public String deleteTMenuById(Integer id) {
		menuMapper.deleteByPrimaryKey(id);
		return "OK";
	}

	@Override
	public List<Integer> listPermissionIdByMenuId(Integer menuId) {
		List<Integer> menuIdList = permissionMenuMapper.listMenuIdByMenuId(menuId);
		return menuIdList;
	}

	@Override
	public String doAssginPermissionToMenu(Integer menuId, List<Integer> ids) {

		TPermissionMenuExample example = new TPermissionMenuExample();
		example.createCriteria().andMenuidEqualTo(menuId);
		permissionMenuMapper.deleteByExample(example);
		TPermissionMenu rp = new TPermissionMenu();
		rp.setMenuid(menuId);
		for (Integer permissionId : ids) {
			rp.setPermissionid(permissionId);
			permissionMenuMapper.insertSelective(rp);
		}
		return "ok";
	}

}
