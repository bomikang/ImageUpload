<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	input#uid{width:85% !important;}
	button#checkingId{float:right;}
</style>
<div class="wrapper">
	<section>
		<form action="join" method="post">
			<fieldset>
				<legend>회원가입</legend>
				<div class="input-box">
					<p>
						<label for="">아이디</label>
						<input type="text" name="uid" id="uid" />
						<button id="checkingId">확인</button>
					</p>
					<p>
						<label for="">비밀번호</label>
						<input type="password" name="upw" />
					</p>
					<p>
						<label for="">비밀번호 확인</label>
						<input type="password"/>
					</p>
					<p>
						<label for="">이름</label>
						<input type="text" name="uname"/>
					</p>
					<p>
						<label for="">이메일</label>
						<input type="text" name="uemail"/>
					</p>
					<p>
						<label for="">전화번호</label>
						<input type="text" name="uphone"/>
					</p>
					<p class='btn-area'>
						<input type="submit" value="가입"/>
						<button>취소</button>
					</p>
				</div>
			</fieldset>
		</form>
	</section>
</div>