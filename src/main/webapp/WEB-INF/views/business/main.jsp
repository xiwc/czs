<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- head common -->
<%@ include file="../common.jsp"%>
<title>餐助手-商家服务</title>
</head>
<body style="margin: 0px; padding: 0px;">

	<!-- 侧边栏 -->
	<%@ include file="../menu.jsp"%>

	<!-- header -->
	<%@ include file="../header.jsp"%>

	<h4 class="ui top attached header" style="margin-top: 45px;">基本信息</h4>
	<div class="ui segment attached" style="min-height: 490px;">
		<div class="ui green button" id="business-update-ui-btn">修改信息</div>
		<div class="ui relaxed celled list">
			<div class="item">
				<i class="user outline icon"></i>
				<div class="content">
					<div class="header">店名</div>
					${business.name}
				</div>
			</div>
			<div class="item">
				<i class="home outline icon"></i>
				<div class="content">
					<div class="header">地址</div>
					${business.address}
				</div>
			</div>
			<div class="item">
				<i class="phone outline icon"></i>
				<div class="content">
					<div class="header">电话</div>
					${business.phoneNumber}
				</div>
			</div>
			<div class="item">
				<i class="mail outline icon"></i>
				<div class="content">
					<div class="header">E-mail</div>
					${business.mail}
					<c:if test="${business.isMailVerify == 0}">
						<a class="ui red label"> 未验证 </a>
					</c:if>
					<c:if test="${business.isMailVerify == 1}">
						<a class="ui green label" onclick="setEmailPasswordHandler()"> 已验证,${(empty business.password)? '设置' : '修改'}登录密码
						</a>
					</c:if>
				</div>
			</div>
			<div class="item">
				<i class="comment outline icon"></i>
				<div class="content">
					<div class="header">介绍</div>
					${business.introduce}
				</div>
			</div>
		</div>
	</div>

	<!-- footer -->
	<%@ include file="../footer.jsp"%>

	<!-- 信息修改modal -->
	<div class="ui small modal" id="business-update-modal">
		<i class="close icon"></i>
		<div class="header">信息修改</div>
		<div class="content" style="padding-top: 0px; padding-bottom: 0px;">
			<form action="business/update.do" id="business-update-form" method="post">
				<input type="hidden" name="openId" value="${business.openId}">
				<div class="ui warning form segment" id='business-update-ui-form' style="height: 380px; overflow: auto;">
					<div class="ui error message" id="add-menu-ui-message"></div>
					<div class="field">
						<label>店名</label> <input placeholder="店名" type="text" name="name" value="${business.name}">
					</div>
					<div class="field">
						<label>地址</label> <input placeholder="地址" type="text" name="address" value="${business.address}">
					</div>
					<div class="field">
						<label>电话</label> <input placeholder="电话" type="text" name="phoneNumber" value="${business.phoneNumber}">
					</div>
					<div class="field">
						<label>E-mail</label> <input placeholder="E-mail" type="text" name="mail" value="${business.mail}"
							autocomplete="off">
					</div>
					<div class="field">
						<label>介绍</label>
						<textarea name="introduce">${business.introduce}</textarea>
					</div>
				</div>
			</form>
		</div>
		<div class="actions">
			<div class="two fluid ui buttons">
				<div class="ui deny labeled icon button">
					<i class="remove icon"></i> 取消
				</div>
				<div class="ui approve right labeled icon button">
					确定 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>
	</div>


	<!-- 密码设置变更modal -->
	<div class="ui small modal czsPassword">
		<i class="close icon"></i>
		<div class="header">${(empty business.password)? '设置' : '修改'}登录密码</div>
		<div class="content" style="padding-top: 0px; padding-bottom: 0px;">
			<form id="password-form" method="post">
				<div class="ui warning form segment">
					<div class="ui error message" id="add-menu-ui-message"></div>

					<c:if test="${! empty business.password}">
						<div class="field">
							<label>原密码</label>
							<div class="ui left labeled icon input">
								<input type="password" name="oldPassword" autocomplete="off"> <i class="lock icon"></i>
								<div class="ui corner label">
									<i class="icon asterisk"></i>
								</div>
							</div>
						</div>
					</c:if>
					<div class="field">
						<label>密码</label>
						<div class="ui left labeled icon input">
							<input type="password" name="password" autocomplete="off"> <i class="lock icon"></i>
							<div class="ui corner label">
								<i class="icon asterisk"></i>
							</div>
						</div>
					</div>
					<div class="field">
						<label>重复密码</label>
						<div class="ui left labeled icon input">
							<input type="password" name="repeatPassword" autocomplete="off"> <i class="lock icon"></i>
							<div class="ui corner label">
								<i class="icon asterisk"></i>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="actions">
			<div class="two fluid ui buttons">
				<div class="ui deny labeled icon button">
					<i class="remove icon"></i> 取消
				</div>
				<div class="ui approve right labeled icon button" onclick="setOrUpdatePwd(true)">
					确定 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function setEmailPasswordHandler() {
			$('.ui.modal.czsPassword').modal('show');
		}

		function setOrUpdatePwd(isUpdate) {

			if (!isUpdate) {
				$.post('business/newPassword.do', $('#password-form').serialize(), function(msg) {
					if (msg.succeed) {
						$.colorbox({
							html : '<h3 class="ui header">设置成功!</h3>'
						});
					} else {
						$.colorbox({
							html : '<h3 class="ui red header">操作失败!<br/>失败信息:' + msg.msg.detail + '</h3>'
						});
					}
				});
			} else {
				$.post('business/updatePassword.do', $('#password-form').serialize(), function(msg) {
					if (msg.succeed) {
						$.colorbox({
							html : '<h3 class="ui header">更新成功!</h3>'
						});
					} else {
						$.colorbox({
							html : '<h3 class="ui red header">操作失败!<br/>失败信息:' + msg.msg.detail + '</h3>'
						});
					}
				});
			}
		}

		jQuery(function($) {

			$('#menu-item-business-main').addClass('active');

			$('#business-update-modal').modal('setting', {
				onApprove : function() {
					$('#business-update-form').submit();
				}
			}).modal('attach events', '#business-update-ui-btn', 'show');

			$('#business-update-ui-form').form({
				name : {
					identifier : 'name',
					rules : [ {
						type : 'empty',
						prompt : '请输入店名!'
					} ]
				},
				address : {
					identifier : 'address',
					rules : [ {
						type : 'empty',
						prompt : '请输入地址!'
					} ]
				},
				phoneNumber : {
					identifier : 'phoneNumber',
					rules : [ {
						type : 'empty',
						prompt : '请输入电话!'
					} ]
				},
				introduce : {
					identifier : 'introduce',
					rules : [ {
						type : 'empty',
						prompt : '请输入介绍!'
					} ]
				}
			});
		});
	</script>
</body>
</html>