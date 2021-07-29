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
	
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div> 
        <jsp:include page="/WEB-INF/jsp/commons/top.jsp"></jsp:include>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/commons/sidebar.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
			  
			  
<form id="queryFrom" class="form-inline" role="form" style="float:left;" action="${PATH }/admin/index" method="post">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" name="condition" value="${param.condition }" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" onclick="$('#queryFrom').submit();" class="btn btn-warning" ><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>


<button id="deleteCheckedBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input id="selectAll" type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              
              <tbody>
              <c:forEach items="${page.list }" var="admin" varStatus="status">
              <tr><!-- status.index 迭代索引 status.count 迭代序号 -->
                  <td>${status.count }</td>
				  <td><input adminId="${admin.id }" type="checkbox"></td>
                  <td>${admin.loginacct }</td>
                  <td>${admin.username }</td>
                  <td>${admin.email }</td>
                  <td>
				      <button type="button" class="btn btn-success btn-xs" onclick="window.location.href = '${PATH}/admin/toAssign?id=${admin.id}'"><i class=" glyphicon glyphicon-check"></i></button>
				      <button type="button" class="btn btn-primary btn-xs" onclick="window.location.href = '${PATH}/admin/toUpdate?id=${admin.id}&pageNum=${page.pageNum }';"><i class=" glyphicon glyphicon-pencil"></i></button>
					  <button type="button" adminId="${admin.id }" class="deleteBtn btn btn-danger btn-xs" ><i class=" glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
              
              </c:forEach>
                
               
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
							<c:if test="${page.isFirstPage }">
								<li class="disabled"><a href="#">上一页</a></li>
							</c:if>
							<c:if test="${!page.isFirstPage }">
								<li><a href="${PATH }/admin/index?condition=${param.condition }&pageNum=${page.pageNum-1}">上一页</a></li>
							</c:if>
								
								<c:forEach items="${page.navigatepageNums }" var="i">
								
									<c:if test="${page.pageNum == i}">
										<li class="active"><a href="${PATH}/admin/index?condition=${param.condition }&&pageNum=${i}">${i} <span class="sr-only">(current)</span></a></li>
									</c:if>
									<c:if test="${page.pageNum != i}">
										<li><a href="${PATH}/admin/index?condition=${param.condition }&pageNum=${i}">${i}</a></li>
									</c:if>
								</c:forEach>
								
							<c:if test="${page.isLastPage }">
								<li class="disabled"><a href="#">下一页</a></li>
							</c:if>
							<c:if test="${!page.isLastPage }">
								<li><a href="${PATH }/admin/index?condition=${param.condition }&pageNum=${page.pageNum+1}">下一页</a></li>
							</c:if>
						 </ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
	
    <script src="${PATH }/static/jquery/jquery-2.1.1.min.js"></script>
    <script src="${PATH }/static/jquery/layer/layer.js"></script>	
    <script src="${PATH }/static/bootstrap/js/bootstrap.min.js"></script>
	<script src="${PATH }/static/script/docs.min.js"></script>
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


				$(".deleteBtn").click(function(){
					
					 var id = $(this).attr("adminId");
					 
					layer.confirm('您是否删除？', {
						  btn: ['确定','取消'] //按钮
						}, function(index){
							//这里的this指确定按钮
						 
						window.location.href = "${PATH}/admin/toDelete?id="+id+"&pageNum=${page.pageNum }";
						  layer.close(index);
						}, function(index){

							layer.close(index);
						});
					
				})


				$("#selectAll").click(function(){
					
					//$("tbody :checkbox").attr("checked", this.checked); 适用于自定义属性
					$("tbody :checkbox").prop("checked", this.checked);
				})


				$("#deleteCheckedBtn").click(function(){
					var checkedBoxList = $("tbody :checkbox:checked");
					var ids = "";
					var array = new Array();
					if(checkedBoxList.length==0){
						layer.msg("请选中再删除！");
						return false;
					}

					$.each(checkedBoxList, function(i, e){
						var adminId = $(e).attr("adminId");//获取自定义属性
						array.push(adminId);
					
					})

					ids = array.join(",");
					console.log(ids)

					layer.confirm('您是否删除？', {
						  btn: ['确定','取消'] //按钮
						}, function(index){
							//这里的this指确定按钮
						 
						window.location.href="${PATH}/admin/toDeleteBatch?ids=" + ids + "&pageNum=${page.pageNum }"
						  layer.close(index);
						}, function(index){

							layer.close(index);
						});
					
				})
					
            });

        </script>
  </body>
</html>
