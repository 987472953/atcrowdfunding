<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@ include file="/WEB-INF/jsp/commons/css.jsp"%><!-- 静态包含 -->
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" id="queryBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<security:authorize access="hasRole('PM - 项目经理')">
	<button type="button" id="addBtn" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
</security:authorize>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>

              </tbody>
			  <tfoot>
					<tr>
						<td colspan="6" align="center">
							<ul class="pagination">

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

<!-- Modal 添加模态框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加角色</h4>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label for="roleName">roleName</label>
			<input type="text" class="form-control" id="roleName" placeholder="请输入角色名字" >
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="saveBtn" type="button" class="btn btn-primary">添加</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 修改模态框-->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改角色</h4>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label for="roleName2">roleName</label>
			<input type="hidden" id="roleId2" name="id">
			<input type="text" class="form-control" id="roleName2" placeholder="请输入角色名字" >
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal 修改角色权限模态框-->
<div class="modal fade" id="assginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改角色</h4>
      </div>
      <div class="modal-body">
		<ul id="treeDemo" class="ztree"></ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="updateAssginBtn" type="button" class="btn btn-primary">分配</button>
      </div>
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
			    initData(1);
            });

            var json = {
                    pageNum: 1,
                    pageSize: 5
              	};
          	
            function initData(pageNum){
                //1.发起Ajax请求，获取分页数据

                json.pageNum = pageNum;
              	var index= -1;
                $.ajax({
                    type: "post",
                    url: "${PATH}/role/loadData",
                    data: json,
                    beforeSend: function(){
                        //一般进行表单校验
                        index = layer.load(0,{time:10*1000});
						return true;
                    },
                    success: function(result){
						layer.close(index);

						initShow(result);

						initNavg(result);
                    },
                    
                }) 
            }
        	 //2、展示数据
	        	 
           function initShow(result){
               //拼字符串
               var list = result.list;
               var content = '';
               $('tbody').empty();
               $.each(list,function(i, e){
            	   var tr = $('<tr></tr>')
            	   
            	   tr.append('<td>'+ (i+1) +'</td>')
            	   tr.append('<td><input type="checkbox"></td>')
            	   tr.append('<td>'+ e.name +'</td>')
            	   
            	   var td = $('<td></td>')
            	   td.append('<button type="button" roleId='+e.id+' class="assginPermissionClass btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>')
            	   td.append('<button type="button" roleId='+e.id+' class="updateClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>')
            	   td.append('<button type="button" roleId='+e.id+' class="deleteClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>')
            	   tr.append(td)
            	   tr.appendTo($('tbody'))
               })

           }
           //3、展示分页条
           function initNavg(result) {
        	   	$('ul.pagination').empty();

				var navigetpageNums = result.navigatepageNums;
				if (result.isFirstPage) {
					$("ul.pagination").append('<li class="disabled"><a href="#">上一页</a></li>')
				} else {
					$("ul.pagination").append('<li><a onclick="initData('+(result.pageNum-1) +')">上一页</a></li>')
				}



				$.each(navigetpageNums, function(i, num) {
					if (num == result.pageNum) {
						$("ul.pagination").append('<li class="active"><a href="#">' + num +
							'<span class="sr-only">(current)</span></a></li>')
					} else {
						$("ul.pagination").append('<li><a onclick="initData('+num +')">' + num + '</a></li>')
					}
			
				})

				if (result.isLastPage) {
					$("ul.pagination").append('<li class="disabled"><a href="#">下一页</a></li>')
				} else {
					$("ul.pagination").append('<li><a onclick="initData('+(result.pageNum+1) +')">下一页</a></li>')
				}
			}


			$("#queryBtn").click(function(){

				
				var condition = $("#condition").val();
				json.condition = condition;
				initData(1);

				
				})
			
				
			//添加======开始
			$("#addBtn").click(function(){
				$("#myModal").modal({
					show: true,
					backdrop: 'static',
					keyboard: false
				})	
			})
			
			$("#myModal #saveBtn").click(function(){
				var roleName = $("#myModal input[id='roleName']").val();
				console.log(roleName)
				$.ajax({
					type: "post",
					url: "${PATH}/role/toAdd",
					data: {
						name: roleName
					},
					beforeSend: function(){
						if(roleName==""){
							layer.msg("角色名称不能为空！", {time: 1000})
							return false;
						}
						return true;
					},
					success: function(result){
						console.log(result.toLowerCase())
						if(result.toLowerCase()=="ok"){
							layer.msg("保存成功！", {time:1000, icon:4})
							$("#myModal").modal('hide');
							$("#myModal #roleName").val("");
							initData(1)
						}else if("403"==result){
							layer.msg("你的权限不足！", {time:1000, icon:5})

						}else{
							layer.msg("保存失败！", {time:1000, icon:5})	
						}
					}
				})
			})
			//添加======结束
			
			
			
			//修改========开始
			 /* $(".updateClass").click(function(){
				$(this).hide();
			})  */
			 $('tbody').on('click', '.updateClass', function(){
				//var roleId = this.roleId; //this DOM对象， dom对象不能获取自定义属性
				var roleId = $(this).attr('roleId');
				
				$("#updateModal").modal({
					show: true,
					backdrop: 'static',
					keyboard: false
					})	
				
				
				$.get('${PATH}/role/queryRole',{id:roleId}, function(result){
						console.log(result)
					//绑定弹出模态框
					
					$('#updateModal :hidden').val(result.id);
					$('#updateModal #roleName2').val(result.name);
					

				});
				
			}) 
			
			$("#updateBtn").click(function(){
				var name = $("#roleName2").val();
				var id = $("#roleId2").val();
				console.log(id + name + " :update")

				$.ajax({
					type: "post",
					url: "${PATH}/role/toUpdate",
					data: {
						id: id,
						name: name
						
					},
					beforeSend: function(){
						if(roleName==""){
							layer.msg("角色名称不能为空！", {time: 1000})
							return false;
						}
						return true;
					},
					success: function(result){
						console.log(result.toLowerCase())
						if(result.toLowerCase()=="ok"){
							layer.msg("修改成功！", {time: 1000})
							$("#updateModal").modal('hide');
							$("#updateModal #roleName2").val("");
							initData(json.pageNum)
						}else{
							layer.msg("修改失败！", {time: 1000})

						}
						
					}
				
				})
			})
			
			//删除=========开始
			
			$('tbody').on('click', '.deleteClass', function(index){
				var id = $(this).attr('roleId');

				layer.confirm("确定删除？",{btn:["确定", "取消"]}, function(){
					
				
					$.post("${PATH}/role/toDelete", {id: id},function(result){
							if(result.toLowerCase()=="ok"){
								layer.msg("删除成功！", {time: 1000})
								initData(json.pageNum)
							}else{
								layer.msg("删除失败！", {time: 1000})
							}
						}
					)
					layer.close(index);
				},function(index){
					layer.close(index);
				})
			})
			
			//分配角色权限====================开始
			
			var setting = {
				check: {
					enable: true
				},
				data: {
					simpleData: {
						enable: true,
       					pIdKey: "pid",
       					
					},
					key: {
						name: "title"	
					}
					
				},
				view: {
					selectedMulti: false,
					addDiyDom: function(treeId, treeNode){
						/* var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
						if ( treeNode.icon ) {
							icoObj.removeClass().addClass(treeNode.icon).css("background","");
						} */
						$("#"+ treeNode.tId+ "_ico").removeClass()
						$("#"+ treeNode.tId+"_span").before("<span class=' "+treeNode.icon+"'>")
					}
				} 
  			};

			var roleId = '';
			$("tbody").on("click", ".assginPermissionClass", function(){
				$("#assginModal").modal({
					show:true,
					backdrop: 'static',
					keyboard: false
				});

				roleId = $(this).attr("roleId");
				initTree();
				
			});
			
			
			function initTree(){
				//加载数据
				$.get("${PATH}/permission/createTree", {}, function(result){
			
					
					//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据
			
					var zNodes = result;
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			    	treeObj.expandAll(true);
			    	
			    	//回显数据
			    	$.get("${PATH}/role/queryPermissionIdByRoleId", {roleId: roleId}, function(result){
						$.each(result, function(i,e){
							var node = treeObj.getNodeByTId("treeDemo_"+ e);
							treeObj.checkNode(node, true, false);
						})
					})	
				})
				
				
			};
			
			$("#updateAssginBtn").click(function(){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				var json = {
						roleId: roleId	
					}
				$.each(nodes, function(i, e){
					var permissionId = e.id;
					json['ids['+i+']']= permissionId;
				})
				 $.ajax({
					type: "post",
					url: "${PATH}/role/doAssginPermissionToRole",
					data: json,
					success: function(result){
						if(result.toLowerCase()=="ok"){
							layer.msg("修改成功！", {time: 1000})
							
						}else{
							layer.msg("修改失败！", {time: 1000})
						}
						$("#assginModal").modal("hide");
					}
						
				})  
	
			});
        </script>
  </body>
</html>
