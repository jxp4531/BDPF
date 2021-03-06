<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>系统管理-实验时间设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge，chrome=1">
<meta name="renderer" content="webkit">
<script src="${ctx}/resources/js/system/time/time.js"></script>
</head>
<body >
	<!-- 公共头引入 -->
	<%@ include file="/common/head.jsp"%>
	<!-- /公共头引入 -->
	<!--main(begin)-->
	<article>
		<nav class="com-nav">
			<div class="w1100">
				<span class="fsize14">当前位置：<a class="base-color fsize14"
					href="javascript:void(0);" onclick="cancel()">系统管理</a></span>
			</div>
		</nav>
		<section class="w1100 teachingPlan-content of">
		<div class="et-manage-nav">
		<dl>
			<dt class="et-nav-title">
				<a href="javascript:void(0);">系统管理</a>
			</dt>
			<!-- 公共左菜单引入 -->
			<c:import url="/common/menu.jsp">
				<c:param name="modelId" value="system"></c:param>
				<c:param name="menuId"  value="time"></c:param>
			</c:import>
			</dl>
			</div>
			<div id="content-r" class="et-manage-content">
				<p class="et-manage-title">
					<span>实验时间设置</span>
				</p>
				<div id="message"  class="et-teachingPlan-content">
					<form class="form-inline" id="edit-time-form">
						<div class="form-group">
							<label>最大时间</label>
							<input type="text" class="form-control maxTime"  placeholder="1-10个字符，只可使用数字【单位：分钟】" id="maxTime" name="maxTime" value="${time.maxTime }">
						</div>
						<div class="form-group">
						<input type="hidden" id="Id" name="Id" value="${time.id }" />
							<label>最小时间</label>
							<input type="text" class="form-control minTime" placeholder="1-10个字符，只可使用数字【单位：分钟】" id="minTime" name="minTime"   value="${time.minTime }">
						</div>
						<div class="form-group">
							<label>增加时间</label>
							<input type="text" class="form-control addTime" placeholder="1-10个字符，只可使用数字【单位：分钟】" id="addTime" name="addTime" value="${time.addTime }">
						</div>
						<div class="form-group">
							<label>上限人数</label>
							<input type="text" class="form-control maxNum" placeholder="1-10个字符，只可使用数字" id="maxNumber" name="maxNumber" value="${time.maxNumber }">
						</div>
						<div class="tac">
								<input id="btn-save" name="btn-save" type="submit" class="btn affirm-btn mr40" value="确定" />
								<input id="btn-cancel" name="btn-cancel" type="button" class="btn cancel-btn" value="取消" />
						</div>
					</form>
				</div>
			</div>
		</section>
	</article>
	<!--/main(end)-->
	<!-- 公共尾引入 -->
	<%@ include file="/common/foot.jsp"%>
	<!-- /公共尾引入 -->
</body>
</html>