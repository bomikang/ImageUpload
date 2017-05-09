<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	fieldset .input-box{width:40%; margin:0 auto; }
	.input-box p{margin:15px auto; width:80%;}
	.input-box p.btn-area{text-align: center;}
	.input-box label{display:inline-block; width:50%; padding:5px 0; font-size:18px;  color:#804040;}
	.input-box input[type='text'],.input-box input[type='password']{width:100%; font-size:16px; color:#804040; background:#d9b3b3; color:#fff; padding:3px; border:1px solid gray;}
</style>
<div class="wrapper">
	<section>
		<form action="loginPost" method="post">
			<fieldset>
				<legend>로그인</legend>
				<div class="input-box">
					<p>
						<label for="">아&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;디</label><br />
						<input type="text" name="uid" />
					</p>
					<p>
						<label for="">비 밀 번 호</label><br />
						<input type="password" name="upw" />
					</p>
					<p class="btn-area">
						<input type="submit" value="로그인" id="login"/>
					</p>
				</div>
			</fieldset>
		</form>
	</section>
</div>