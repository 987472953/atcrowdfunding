package com.atguigu.atcrowdfunding.component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;

@Service
public class SecurityUserDetailServiceImpl implements UserDetailsService {

	Logger log = LoggerFactory.getLogger(SecurityUserDetailServiceImpl.class);
	@Autowired
	TAdminMapper adminMapper;

	@Autowired
	TRoleMapper roleMapper;

	@Autowired
	TPermissionMapper permissionMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		//查询用户对象
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		//查询用户角色集合
		if(list!=null && list.size()==1) {
			TAdmin admin =list.get(0);
			Integer adminId = admin.getId();
			List<TRole> roleList = roleMapper.listRoleIdByAdminId(adminId);
			log.debug("用户信息={}", admin);
			//查询用户权限集合
			List<TPermission> permissionList = permissionMapper.listPermissionIdByAdminId(adminId);
			
			//构建用户角色与权限的集合=>(ROLE_角色， 权限)
			Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
			log.debug("用户权限信息={}", permissionList);
			log.debug("用户角色信息={}", roleList);
			for (TRole role : roleList) {
				authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
			}
			for (TPermission permission : permissionList) {
				authorities.add(new SimpleGrantedAuthority(permission.getName()));
			}
			log.debug("整合={}", authorities);
			//return new User(admin.getLoginacct(), admin.getUserpswd(), authorities);
			return new TSecurityAdmin(admin, authorities);
		}else {
			return null;
		}
	}

}
