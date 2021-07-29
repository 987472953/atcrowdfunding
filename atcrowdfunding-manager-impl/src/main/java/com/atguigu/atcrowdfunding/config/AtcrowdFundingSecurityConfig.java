package com.atguigu.atcrowdfunding.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class AtcrowdFundingSecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	UserDetailsService userDetailsService;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//super.configure(auth);
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
		
	}
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//super.configure(http);
		//放行antMatchers其他需要验证
		http.authorizeRequests().antMatchers("/static/**", "/welcome.jsp", "/toLogin").permitAll().anyRequest().authenticated();
		
		//login.jsp == POST 用户登录请求发给Security
		http.formLogin().loginPage("/toLogin")
						.usernameParameter("loginacct")
						.passwordParameter("userpswd")
						.loginProcessingUrl("/login").defaultSuccessUrl("/main")
						.successForwardUrl("/main").
						permitAll();
		
		http.csrf().disable();
		
		http.logout().logoutSuccessUrl("/index");
		
		http.rememberMe();
		
		http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
			@Override
			public void handle(HttpServletRequest request, HttpServletResponse response,
					AccessDeniedException accessDeniedException) throws IOException, ServletException {
				String type = request.getHeader("X-Requested-With");
				
				if("XMLHttpRequest".equals(type)) {//异步
					response.getWriter().print("403"); //403权限不够，访问拒绝
				}else {//同步
					request.getRequestDispatcher("/WEB-INF/jsp/error/error403.jsp").forward(request, response);
				}
				
			
			}
		});
		
		
	}
}
