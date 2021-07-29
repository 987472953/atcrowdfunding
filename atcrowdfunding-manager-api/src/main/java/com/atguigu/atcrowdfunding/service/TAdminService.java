package com.atguigu.atcrowdfunding.service;

import java.util.ArrayList;
import java.util.Map;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

public interface TAdminService {

	TAdmin getTAdminByPassword(Map<String, Object> map);

	PageInfo<TAdmin> listAdminPage(Map<String, Object> paramMap);

	void saveTAdmin(TAdmin admin);

	TAdmin getTAdminById(Integer id);

	void updateTAdmin(TAdmin admin);

	void deleteTAdminById(Integer id);

	void deleteBatch(ArrayList<Integer> idList);



}
