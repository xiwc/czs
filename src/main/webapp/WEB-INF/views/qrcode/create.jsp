<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>二维码发送</title>
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.css" />
<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.js"></script>
<script type="text/javascript">
	jQuery(function($) {

	});
</script>
</head>
<body>
	<!-- Home -->
	<div data-role="page" id="v_business_exists">
		<div id="v001_pageHeader" data-theme="a" data-role="header"
			data-position="fixed">
			<h1 id="v001_heading">餐助手</h1>
		</div>
		<div data-role="content">
			<a href="#">
				<div style="text-align: center">
					<img style="width: 100%;" src="${qrcode.url}">
				</div>
			</a>
			<form action="qrcode/sendMail.do">
				<input type="hidden" name="filePath" value="${qrcode.path}">
				<input type="hidden" name="ticket" value="${qrcode.ticket}">
				<input type="hidden" name="url" value="${qrcode.url}">
				<input type="hidden" name="openId" value="${openId}">
				<div data-role="fieldcontain">
					<label for="textinput5"> E-mail </label> <input name="mail"
						id="textinput5" placeholder="" value="${business.mail}" type="email">
				</div>
				<input type="submit" value="发送到邮箱">
			</form>
		</div>
		<div data-theme="a" data-role="footer" data-position="fixed">
			<h3>餐助手-版权所有</h3>
		</div>
	</div>
</body>
</html>