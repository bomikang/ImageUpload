<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Bominem Photos Home</title>
<style>
	*{margin:0; padding:0;}
	body{background:#dedede; font-family:"맑은 고딕"}
	a{text-decoration: none;}
	a:HOVER{font-weight: bold;}
	.wrapper{width: 1200px; margin: 0 auto;}
	.wrapper header{background:#fff; height:80px;}
	.wrapper header #left-btn{display: inline-block; width:80px;}
	.wrapper header #left-btn img{width:40px; padding:20px;}
	.wrapper header #title-btn{display: inline-block; width:250px;position:relative; top:-38px; font-size: 23px;}
	.wrapper header #right-btn{display: inline-block; width:850px; text-align: right; top:-35px; position:relative;}
	.wrapper header #right-btn a{margin:0 20px;}
	.wrapper section {background:#f5f5f5; padding:10px; min-height:500px;}
	.wrapper .left-menu{width:200px; background:#fff; position:absolute; top:-80px; z-index:1000;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>
	$(function(){
		$("#left-btn").find("a").click(function(e){
			e.preventDefault();
			
			$(".left-menu").html("<a href='${pageContext.request.contextPath}/upload/list'>전체보기</a><br />");
			
			$.ajax({
				url:"${pageContext.request.contextPath}/upload/menu",
				type:"get",
				success:function(result){
					console.log(result);
					
					for(var i = 0; i < result.length; i++){
						var $a = "<a href='${pageContext.request.contextPath}/upload/list?folder="+result[i]+"'>"+result[i]+"</a><br />";
						$(".left-menu").append($a);
					}

					var top = $(".left-menu").css("top");
					
					if(top == "-80px"){
						$(".left-menu").animate({"top":"80px"}, "slow");
					}else{
						$(".left-menu").animate({"top":"-80px"}, "slow");
					}
				},
				error:function(result){
					alert("로그인을 먼저 해주세요!");
				}
			});
			
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<header>
			<div id="left-btn">
				<a href=""><img src="${pageContext.request.contextPath}/resources/images/list.png" alt="" /></a>
			</div>
			<div id="title-btn">
				<b><a href="${pageContext.request.contextPath}">Bominem Photos</a></b>
			</div>
			<div id="right-btn">
				<a href="${pageContext.request.contextPath}/upload/list">사진보기</a>
				<a href="${pageContext.request.contextPath}/upload/upload">등록</a>
				<c:if test="${!empty login}">
					<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
				</c:if>
				<c:if test="${empty login}">
					<a href="${pageContext.request.contextPath}/user/login">로그인</a>
					<a href="${pageContext.request.contextPath}/user/join">회원가입</a>
				</c:if>
			</div>
		</header>
		
		<div class="left-menu"></div>
	</div>
</body>
</html>