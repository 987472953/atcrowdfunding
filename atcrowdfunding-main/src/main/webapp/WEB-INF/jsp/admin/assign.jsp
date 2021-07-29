<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@ include file="/WEB-INF/jsp/commons/css.jsp"%><!-- 静态包含 -->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select id="leftRoleList" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
						<c:forEach items="${unassginList}" var="unassgin">
							<option value="${unassgin.id }">${unassgin.name }</option>
						</c:forEach>
 
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li id="leftToRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right" ></li>
                            <br>
                            <li id="rightToLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id="rightRoleList" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
						<c:forEach items="${assginList}" var="assgin">
							<option value="${assgin.id }">${assgin.name }</option>
						</c:forEach>
                       
                    </select>
				  </div>
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
    <%@ include file="/WEB-INF/jsp/commons/js.jsp"%>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });

            
            $("#leftToRightBtn").click(function(){
              var leftSelectedRoleList = $("#leftRoleList :selected");
              
              if(leftSelectedRoleList.length === 0){
               	  layer.msg("请选择角色再进行分配！", {icon:5, time:1000}); 
              }
				
              var str = '';
              $.each(leftSelectedRoleList, function(i, e){
                var roleId = e.value;
                str += 'roleId='+roleId+"&";  
              })
              str += 'adminId=${param.id}';
              $.ajax({
                type: "post",
                url: "${PATH}/admin/doAssgin",
                data: str,
                success: function(result){
                	if(result.toLowerCase()=="ok"){
                    	layer.msg("分配成功！", {icon:6, time:1000}, function(){
                    		 $("#rightRoleList").append(leftSelectedRoleList.clone());
                             leftSelectedRoleList.remove();
                       	});	
                  	}else{
                  		layer.msg("分配失败！", {icon:5, time:1000});   	
                    }
                }
                  
              }) 
            });
            $("#rightToLeftBtn").click(function(){
           	    var rightSelectedRoleList = $("#rightRoleList :selected");

                if(rightSelectedRoleList.length === 0){
                 	  layer.msg("请选择角色再进行分配！", {icon:5, time:1000}); 
                }

                var str = '';
                $.each(rightSelectedRoleList, function(i, e){
                  var roleId = e.value;
                  str += 'roleId='+roleId+"&";  
                })
                str += 'adminId=${param.id}';
                $.ajax({
                  type: "post",
                  url: "${PATH}/admin/removeAssgin",
                  data: str,
                  success: function(result){
                  	if(result.toLowerCase()=="ok"){
                      	layer.msg("移除成功！", {icon:6, time:1000}, function(){
                      		 $("#leftRoleList").append(rightSelectedRoleList.clone());
                      		rightSelectedRoleList.remove();
                         	});	
                    	}else{
                    		layer.msg("移除失败！", {icon:5, time:1000});   	
                      }
                  }
                    
                }) 
            });
        </script>
  </body>
</html>
    