<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh_CN">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">

		<link rel="stylesheet" href="${PATH }/static/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${PATH }/static/css/font-awesome.min.css">
		<link rel="stylesheet" href="${PATH }/static/css/main.css">
		<link rel="stylesheet" href="${PATH }/static/css/doc.min.css">
		<style>
			.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
	</head>

	<body>

		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
				</div>
				<jsp:include page="/WEB-INF/jsp/commons/top.jsp"></jsp:include>
			</div>
		</nav>

		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/WEB-INF/jsp/commons/sidebar.jsp"></jsp:include>


				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<ol class="breadcrumb">
						<li><a href="#">首页</a></li>
						<li><a href="#">数据列表</a></li>
						<li class="active">新增</li>
					</ol>
					<div class="panel panel-default">
						<div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
								 class="glyphicon glyphicon-question-sign"></i></div>
						</div>
						<div class="panel-body">
							<form role="form" action="${PATH }/admin/doAdd" method="post" id="addFrom">
								<div class="form-group">
									<label for="exampleInputPassword1">登陆账号</label>
									<input type="text" class="form-control" name="loginacct" placeholder="请输入登陆账号">
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">用户名称</label>
									<input type="text" class="form-control" name="username" placeholder="请输入用户名称">
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">邮箱地址</label>
									<input type="email" class="form-control" name="email" placeholder="请输入邮箱地址">
									<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
								</div>
								<button type="button" class="btn btn-success" id="saveBut"><i class="glyphicon glyphicon-plus"></i> 新增</button>
								<button type="button" class="btn btn-danger" id="reset"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
							</form>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						<h4 class="modal-title" id="myModalLabel">帮助</h4>
					</div>
					<div class="modal-body">
						<div class="bs-callout bs-callout-info">
							<h4>测试标题1</h4>
							<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
						</div>
						<div class="bs-callout bs-callout-info">
							<h4>测试标题2</h4>
							<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
						</div>
					</div>
					<!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
				</div>
			</div>
		</div>
		<script src="${PATH }/static/jquery/jquery-2.1.1.min.js"></script>
		<script src="${PATH }/static/bootstrap/js/bootstrap.min.js"></script>
		<script src="${PATH }/static/script/docs.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$(".list-group-item").click(function() {
					if ($(this).find("ul")) {
						$(this).toggleClass("tree-closed");
						if ($(this).hasClass("tree-closed")) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});


				$("#saveBut").click(function(){
					$("#addFrom").submit();
				});

				$("#reset").click(function(){
					$("#addFrom :input").val("");
				});
			});

			
		</script>
	</body>
</html>
