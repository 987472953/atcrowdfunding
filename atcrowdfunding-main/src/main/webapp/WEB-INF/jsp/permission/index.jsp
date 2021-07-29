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
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
           <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/commons/top.jsp"></jsp:include>
      </div>
    </nav>
    <div class="container-fluid">
      <div class="row">
       <jsp:include page="/WEB-INF/jsp/commons/sidebar.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

			<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 许可权限管理 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
                  <ul id="treeDemo" class="ztree"></ul>
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
				<h4>没有默认类</h4>
				<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>没有默认类</h4>
				<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
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
	
	<!-- Modal 添加模态框-->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加许可</h4>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label for="name">许可名称</label>
			<input type="hidden" name="pid">
			<input type="text" class="form-control" id="name" name="name" placeholder="例：许可" >
		</div>
		<div class="form-group">
			<label for="title">许可title</label>
			<input type="text" class="form-control" id="title" name="title" placeholder="请输入权限title" >
		</div>
		<div class="form-group">
			<label for="icon">许可图标</label>
			<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入权限图标" >
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
        <h4 class="modal-title" id="myModalLabel">修改许可</h4>
      </div>
      <div class="modal-body">
      <div class="form-group">
			<label>许可id</label>
			<input type="text" class="form-control" id="id" name="id" disabled="disabled">
		</div>
		<div class="form-group">
			<label for="name">许可名称</label>
			<input type="text" class="form-control" id="name" name="name" placeholder="请输入许可名称" >
		</div>
		<div class="form-group">
			<label for="title">许可title</label>
			<input type="text" class="form-control" id="title" name="title" placeholder="请输入许可title" >
		</div>
		<div class="form-group">
			<label for="icon">许可图标</label>
			<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入许可图标" >
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
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
				initTree();
            });


            function initTree(){

           	var setting = {
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
   						},
   						addHoverDom: function(treeId, treeNode){  
   							var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
   							aObj.attr("href", "javascript:void(0);");
							aObj.removeAttr("target");
   							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
   							var s = '<span id="btnGroup'+treeNode.tId+'">';
   							if ( treeNode.level == 0 ) {
   								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
   							} else if ( treeNode.level == 1 ) {
   								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
   								if (!treeNode.children) {
   									s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg"></i></a>';
   								}
   								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
   							} else if ( treeNode.level == 2 ) {
   								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
   								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
   							}
   			
   							s += '</span>';
   							aObj.after(s);
   						},
   						removeHoverDom: function(treeId, treeNode){
   							$("#btnGroup"+treeNode.tId).remove();
   						}
   					} 
   				};

			
            	$.get("${PATH}/permission/createTree", {}, function(result){

    				
    				//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据

    				var zNodes = result;
    				zNodes.push({id:0,title:'权限管理' ,icon:'glyphicon glyphicon-th-list'})
    				
    				$.fn.zTree.init($("#treeDemo"), setting, zNodes);

    				
    				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                	treeObj.expandAll(true);
    			
    			})
            
            }


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
			var title = $("#addModal input[name='title']").val();
			var icon = $("#addModal input[name='icon']").val();
			
			$.post("${PATH}/permission/toAdd",{
				pid: pid,
				name: name,
				title: title,
				icon: icon,
					
			}, function(result){
                 if(result.toLowerCase()=="ok"){
                 	layer.msg("添加成功!",{time: 1000}, function(){
                     	$("#addModal").modal("hide");
                    	$("#addModal :text").val("");
                    	initTree();
                   	})	    
                 }else{
               	  layer.msg("添加失败!",{time: 1000})
                 }
             })	
		})
		function updateBtn(id){
			$("#updateModal").modal({
            	show:true,
                backdrop: 'static',
                keyboard: false 
            })
            
            $.get("${PATH}/permission/queryPermission",{id:id},function(result){
            	$("#updateModal input[name='id']").val(result.id);
                $("#updateModal input[name='name']").val(result.name);
                $("#updateModal input[name='title']").val(result.title);
                $("#updateModal input[name='icon']").val(result.icon);
            });	
		}
			

            $("#updateBtn").click(function(){
            	var id = $("#updateModal input[name='id']").val();
                var name = $("#updateModal input[name='name']").val();
                var title = $("#updateModal input[name='title']").val();
                var icon = $("#updateModal input[name='icon']").val();
                console.log(id+name+title+icon)
				$.ajax({
				  type: "post",
				  url: "${PATH}/permission/toUpdate",
				  data: {id:id, name:name, title: title, icon:icon},
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
		
		function deleteBtn(id){
            	layer.confirm("确定删除？",{btn:["确定", "取消"]}, function(){
    				
    				$.post("${PATH}/permission/toDelete", {id: id},function(result){
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
        </script>
  </body>
</html>
