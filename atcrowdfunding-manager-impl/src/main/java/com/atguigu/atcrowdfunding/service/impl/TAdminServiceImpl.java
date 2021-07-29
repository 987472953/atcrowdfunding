package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atguigu.atcrowdfunding.exception.LoginException;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.util.AppDateUtils;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;

@Service
public class TAdminServiceImpl implements TAdminService {

	@Autowired
	TAdminMapper adminMapper;

	@Override
	public TAdmin getTAdminByPassword(Map<String, Object> map) {

		// 密码加密

//		// 查询用户
//		String username = (String) map.get(Const.LOGIN_ADMIN);
//		String password = (String) map.get("password");
//		// 判断用户是否存在
//		TAdminExample example = new TAdminExample();
//
//		example.createCriteria().andLoginacctEqualTo(username);
//		List<TAdmin> list = adminMapper.selectByExample(example);
//		if (list != null && list.size() == 1) {
//			TAdmin admin = list.get(0);
//			// 判断密码
//			if (admin.getUserpswd().equals(password)) {
//				return admin;
//			} else {
//				throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
//			}
//		}else {
//			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
//		}

		// 查询用户
		String username = (String) map.get(Const.LOGIN_ADMIN);
		String password = (String) map.get("password");
		// 判断用户是否存在
		TAdminExample example = new TAdminExample();

		example.createCriteria().andLoginacctEqualTo(username);
		
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		if (list == null || list.size() == 0) {
			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
		}
		TAdmin admin = list.get(0);
		if(!admin.getUserpswd().equals(MD5Util.digest(password))) {
			System.out.println(password);
			System.out.println(MD5Util.digest(password));
			throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
		}
		
		return admin;

	}

	@Override
	public PageInfo<TAdmin> listAdminPage(Map<String, Object> paramMap) {
		
		
		TAdminExample example = new TAdminExample();
		
		String condition = (String) paramMap.get("condition");
		
		if(!"".equals(condition)) {
			example.createCriteria().andLoginacctLike("%" + condition + "%");
			
			Criteria criteria2 = example.createCriteria();
			criteria2.andUsernameLike("%" + condition + "%");
			
			Criteria criteria3 = example.createCriteria(); 
			criteria3.andEmailLike("%" + condition + "%");
			
			example.or(criteria2);
			example.or(criteria3);
		}
		
		
		
		//example.setOrderByClause("createtime desc");
		
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		PageInfo<TAdmin> page = new PageInfo<TAdmin>(list, 5);
		return page;
	}

	@Override
	public void saveTAdmin(TAdmin admin) {
		
		System.out.println(admin);
		//默认密码
		admin.setUserpswd(Const.DEFAULT_USERPSWD);
		admin.setCreatetime(AppDateUtils.getFormatTime());
		//insert into t_admin(loginacct, username, email) values (?, ?, ?)
		adminMapper.insertSelective(admin);//动态sql，有选择性保存
		
	}

	@Override
	public TAdmin getTAdminById(Integer id) {

		TAdmin admin = adminMapper.selectByPrimaryKey(id);
		return admin;
	}

	@Override
	public void updateTAdmin(TAdmin admin) {
		adminMapper.updateByPrimaryKeySelective(admin);
		
	}

	@Override
	public void deleteTAdminById(Integer id) {
		int deleteByPrimaryKey = adminMapper.deleteByPrimaryKey(id);
		
		
	}

	@Override
	public void deleteBatch(ArrayList<Integer> idList) {
		
		adminMapper.deleteBatch(idList);
		
	}

}
