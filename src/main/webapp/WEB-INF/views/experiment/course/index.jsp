<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>课程资源管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge，chrome=1">
<meta name="renderer" content="webkit">
<script src="${ctx}/resources/js/experiment/course/course.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
</head>
<body class="ly-bg">
	<!-- 公共头引入 -->
	<%@ include file="/common/head.jsp"%>
	<!-- /公共头引入 -->
	<!--main(begin)-->
	<article>
		<nav class="com-nav">
			<div class="w1100">
				<span class="fsize14">当前位置：
					<a class="base-color fsize14"	href="javascript:void(0);">实验管理-课程资源管理</a>
				</span>
			</div>
		</nav>
		<section class="w1100 teachingPlan-content of">
			<div class="et-manage-nav">
				<dl>
					<dt class="et-nav-title">
						<a href="javascript:void(0);">实验管理</a>
					</dt>
			<!-- 公共左菜单引入 -->
			<c:import url="/common/menu.jsp">
				<c:param name="modelId" value="experiment"></c:param>
				<c:param name="menuId"  value="course"></c:param>
			</c:import>
				</dl>
			</div>
			<div id="content-r" class="et-manage-content">
				<p class="et-manage-title">
					<span>课程资源管理</span>
				</p>
				<div class="et-manage-operate">
					<div class="VMware-operate">
						<div class="fl ml20">
							<a href="javascript:void(0);" id="addbtn" class="btn open-btn mr5">添加</a> 
							<a href="javascript:void(0);"	id="delebtn" class="btn close-btn mr5">删除</a>
						</div>
						<div class="fr">
							<div class="VMware-search-box fl mt10">
								<input type="text" id="keywords" placeholder="请输入课程资源名称">
							</div>
							<a href="javascript:void(0);" id="search" class="btn search-btn">搜索</a>
						</div>
					</div>
					<div class="VMware-list mt30">
						<div class="table-responsive com-table">
							<table class="table" border="0">
							<thead>
								<tr>
									<th>
										<p class="checkbox_box">
											<input class="checkBox" id="check-all-list" type="checkbox" onchange="toggleCheck(this,'list-tbody')">
											<span class="checkBox"></span>
										</p>
									</th>
									<th>名称</th>
									<th>资源类型</th>
									<th>模板名称</th>
									<!-- <th>描述</th> -->
									<th style="width:10%;">创建人</th>
									<!-- <th>创建时间</th> -->
									<th style="width:10%;">操作</th>
								</tr>
							</thead>
							<tbody id="list-tbody">
								<tr>
									<td colspan="8">对不起，暂时没有您所需要的数据！</td>
								</tr>
							</tbody>
						</table>
						<!--分页-->
						<div id="paginator-tool" style="margin: auto;"></div>
						<script type="text/javascript">
							/*表格行间隔色*/
							$('.table-list tbody tr:odd').addClass('odd');
						</script>
					</div>
					</div>
				</div>
			</div>
		</section>
	</article>
	<%@ include file="/common/foot.jsp"%>
	<!--/main(end)-->
	<!--loading-->
 <div class="cd-mask">
	<img src="${ctx}/resources/images/loading.gif" alt="">
</div> 
</body>
</html>