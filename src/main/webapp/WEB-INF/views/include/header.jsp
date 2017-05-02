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
	a{text-decoration: none;  color:#804040; }
	a:HOVER{font-weight: bold;}
	button, input[type='submit']{border:1px solid #804040; background:#fff; font-size:15px; padding:3px 7px; color:#804040; font-weight: bold;}
	button:hover, input[type='submit']:hover{background:#804040; color:#fff;} 
	
	.wrapper{width: 1200px; margin: 0 auto;}
	.wrapper header{background:#fff; height:80px;}
	.wrapper header #left-btn{display: inline-block; width:80px;}
	.wrapper header #left-btn img{width:40px; padding:20px;}
	.wrapper header #title-btn{display: inline-block; width:320px;position:relative; top:-28px; font-size: 33px;}
	.wrapper header #right-btn{display: inline-block; width:775px; text-align: right; top:-35px; position:relative;}
	.wrapper header #right-btn a{margin:0 20px;}
	.wrapper section {background:#f5f5f5; padding:10px; min-height:500px;}
	.wrapper .left-menu{width:200px; background:#fff; position:absolute; top:-800px; z-index:1000; word-break:break-all;}
	.wrapper .left-menu a#allMenu{color:#464646;}
	.wrapper .left-menu a{font-size:20px; margin:10px; padding-bottom:3px; display:block;border-bottom:2px dotted #dedede;}
	
	fieldset{background:#fff; border: none; margin:15px; padding:10px;}
	legend{color:#464646; font-size:25px; text-align: center; background:#f5f5f5; padding:0 50px 15px; color:#804040; }
	
	fieldset .input-box{width:40%; margin:0 auto; }
	fieldset .input-box p{margin:15px auto; width:80%;}
	fieldset .input-box p.btn-area{text-align: center;}
	fieldset .input-box label{display:inline-block; width:50%; padding:5px 0; font-size:18px;  color:#804040;}
	fieldset .input-box input[type='text']{width:100%; font-size:16px; color:#804040; background:#ead5d5; color:#804040; padding:3px; border:1px solid gray;}
	fieldset .input-box input[type='password']{width:100%; font-size:16px; color:#804040; background:#ead5d5; color:#804040; padding:3px; border:1px solid gray;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>
	$(function(){
		$("#left-btn").find("a").click(function(e){
			e.preventDefault();
			
			$(".left-menu").html("<a href='${pageContext.request.contextPath}/upload/list' id='allMenu'>전체보기</a>");
			
			$.ajax({
				url:"${pageContext.request.contextPath}/upload/menu",
				type:"get",
				success:function(result){
					console.log(result);
					
					for(var i = 0; i < result.length; i++){
						var $a = "<a href='${pageContext.request.contextPath}/upload/list?folder="+result[i]+"'>"+result[i]+"</a>";
						$(".left-menu").append($a);
					}

					var top = $(".left-menu").css("top");
					
					if(top == "-800px"){
						$(".left-menu").animate({"top":"80px"}, "slow");
					}else{
						$(".left-menu").animate({"top":"-800px"}, "slow");
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
				<b><a href="${pageContext.request.contextPath}/upload/list">BOMINEM PHOTOS</a></b>
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