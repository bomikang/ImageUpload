<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="wrapper">
	<section>
		<form action="loginPost" method="post">
			<fieldset>
				<legend>로그인</legend>
				<p>
					<label for="">아이디</label>
					<input type="text" name="uid" />
				</p>
				<p>
					<label for="">비밀번호</label>
					<input type="text" name="upw" />
				</p>
				<p>
					<input type="submit" value="로그인" />
				</p>
			</fieldset>
		</form>
	</section>
</div>