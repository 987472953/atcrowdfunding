package com.atguigu.atcrowdfunding.exception;

//为什么不用Exception
//业务层事务回滚，spring声明事务默认只对RuntimeException类型异常进行事务回滚
public class LoginException extends RuntimeException {

	public LoginException() {}
	
	public LoginException(String message) {
		super(message);
	}
}
