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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单树</h3>
			  </div>
			  <div class="panel-body">
			  	<ul id="treeDemo" class="ztree"></ul>
			  </div>
				
			  </div>
			</div>
        </div>
      </div>

<!-- Modal 添加模态框-->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加菜单</h4>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label for="name">菜单名称</label>
			<input type="hidden" name="pid">
			<input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称" >
		</div>
		<div class="form-group">
			<label for="url">菜单url</label>
			<input type="text" class="form-control" id="url" name="url" placeholder="请输入菜单URL" >
		</div>
		<div class="form-group">
			<label for="icon">菜单图标</label>
			<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入菜单图标" >
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
        <h4 class="modal-title" id="myModalLabel">添加菜单</h4>
      </div>
      <div class="modal-body">
      <div class="form-group">
			<label>菜单id</label>
			<input type="text" class="form-control" id="id" name="id" disabled="disabled">
		</div>
		<div class="form-group">
			<label for="name">菜单名称</label>
			<input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称" >
		</div>
		<div class="form-group">
			<label for="url">菜单url</label>
			<input type="text" class="form-control" id="url" name="url" placeholder="请输入菜单URL" >
		</div>
		<div class="form-group">
			<label for="icon">菜单图标</label>
			<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入菜单图标" >
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 权限模态框-->
<div class="modal fade" id="assginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加菜单</h4>
      </div>
      <div class="modal-body">
     	<div class="form-group">
			<ul id="assginTreeDemo" class="ztree"></ul>
		</div>
      </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="assginUpdateBtn" type="button" class="btn btn-primary">分配</button>
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

			initTree();
        });

        function initTree(){
        	var setting = {
        			data: {
        				simpleData: {
        					enable: true,
        					pIdKey: "pid"
        				}
        			},
        			view: {
						addDiyDom: function(treeId, treeNode){
							$("#"+ treeNode.tId+ "_ico").removeClass()
							$("#"+ treeNode.tId+"_span").before("<span class=' "+treeNode.icon+"'>")
						},
	            		addHoverDom: function(treeId, treeNode){  
							var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
							aObj.attr("href", "javascript:void(0);");
							aObj.removeAttr("target");
							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
							var s = '<span id="btnGroup'+treeNode.tId+'">';
							if ( treeNode.level == 0 ) { //根节点 只能添加
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 1 ) { //分支节点 修改 （删除） 添加
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								if (treeNode.children.length == 0) { 
									s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
								}
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#"  onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 2 ) { //叶子节点 修改 删除 权限赋予
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="assginPermissionBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							}
			
							s += '</span>';
							aObj.after(s);
						},
						removeHoverDom: function(treeId, treeNode){
							$("#btnGroup"+treeNode.tId).remove();
						}
            		}
        		};


        	var json = {};
        	$.get("${PATH}/menu/createTree", json, function(result){//List<TMenu>  ->  json
            	var zNodes = result;
            	zNodes.push({id:0,name:'系统菜单' ,icon:'glyphicon glyphicon-th-list'})

            	$.fn.zTree.init($("#treeDemo"), setting, zNodes);

            	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            	treeObj.expandAll(true);
            })
       		
        }



        //========添加===========
        function addBtn(id){
            $("#addModal").modal({
              show:true,
              backdrop: 'static',
              keyboard: false  
            });
            $("#addModal input[name='pid']").val(id);
        }
        
        $("#saveBtn").click(function(){
        	var pid = $("#addModal input[name='pid']").val();
            var name = $("#addModal input[name='name']").val();
            var url = $("#addModal input[name='url']").val();
            var icon = $("#addModal input[name='icon']").val();

            $.ajax({
              type: "post",
              url: "${PATH}/menu/toAdd",
              data: {
              	pid: pid,
              	name: name,
              	url: url,
              	icon: icon    
              },
              beforeSend: function(){

                  return true;
              },
              success: function(result){
                  if(result.toLowerCase()=="ok"){
                  	layer.msg("添加成功!",{time: 1000}, function(){
                      	$("#addModal").modal("hide");
                     	$("#addModal :text").val("");
                     	initTree();
                    	})	    
                  }else{
                	  layer.msg("添加失败!",{time: 1000})
                  }
              }
            });
        });
        //========修改===========
        function updateBtn(id){

        	$("#updateModal").modal({
            	show:true,
                backdrop: 'static',
                keyboard: false 
            })
            
            $.get("${PATH}/menu/queryMenu",{id:id},function(result){
            	$("#updateModal input[name='id']").val(result.id);
                $("#updateModal input[name='name']").val(result.name);
                $("#updateModal input[name='url']").val(result.url);
                $("#updateModal input[name='icon']").val(result.icon);
            });

            $("#updateBtn").click(function(){
            	var pid = $("#updateModal input[name='id']").val();
                var name = $("#updateModal input[name='name']").val();
                var url = $("#updateModal input[name='url']").val();
                var icon = $("#updateModal input[name='icon']").val();
				$.ajax({
				  type: "post",
				  url: "${PATH}/menu/toUpdate",
				  data: {id:id, name:name, url: url, icon:icon},
				  beforeSend: function(){
	
				  	return true;  
				  },
				  success: function(result){
					if(result.toLowerCase()=="ok"){
		             	layer.msg("修改成功!",{time: 1000}, function(){
		                 	$("#updateModal").modal("hide");
		                	initTree();
		               	})	    
			             }else{
			           	  layer.msg("修改失败!",{time: 1000});
			             } 
				   }
				})  
       		})
            
        }
        
        //========删除===========
		function deleteBtn(id){
			layer.confirm("确定删除？",{btn:["确定", "取消"]}, function(){
				
				$.post("${PATH}/menu/toDelete", {id: id},function(result){
						if(result.toLowerCase()=="ok"){
							layer.msg("删除成功！", {time: 1000})
							initTree();
						}else{
							layer.msg("删除失败！", {time: 1000})
						}
					}
				)
				layer.close(index);
			},function(index){
				layer.close(index);
			})
        }
		//给菜单添加权限=============开始
		var assginSetting = {
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
							$("#"+ treeNode.tId+ "_ico").removeClass()
							$("#"+ treeNode.tId+"_span").before("<span class=' "+treeNode.icon+"'>")
						}
					} 
	  			};
		var menuId = '';
		function assginPermissionBtn(id){
			
			$("#assginModal").modal({
				show:true,
				backdrop: 'static',
				keyboard: false
			});

			menuId = id;
			initAssginTree(id);
		}
		

		function initAssginTree(menuId){
			
			//加载数据
			$.get("${PATH}/permission/createTree", {}, function(result){
		
				
				//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据
		
				var zNodes = result;
				
				$.fn.zTree.init($("#assginTreeDemo"), assginSetting, zNodes);
		
				var treeObj = $.fn.zTree.getZTreeObj("assginTreeDemo");
		    	treeObj.expandAll(true);
		    	
		    	//回显数据
		    	$.get("${PATH}/menu/queryPermissionIdByMenuId", {menuId: menuId}, function(result){
					$.each(result, function(i,e){
						var node = treeObj.getNodeByTId("assginTreeDemo_"+ e);
						treeObj.checkNode(node, true, false);
					})
				})	
			})
			
			
		};
			
		 $("#assginUpdateBtn").click(function(){
			var treeObj = $.fn.zTree.getZTreeObj("assginTreeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			var json = {
					menuId: menuId	
				}
			$.each(nodes, function(i, e){
				var permissionId = e.id;
				json['ids['+i+']']= permissionId;
			})
			 $.ajax({
				type: "post",
				url: "${PATH}/menu/doAssginPermissionToMenu",
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
