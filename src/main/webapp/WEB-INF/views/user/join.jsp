<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="wrapper">
	<section>
		<form action="join" method="post">
			<fieldset>
				<legend>회원가입</legend>
				<p>
					<label for="">아이디</label>
					<input type="text" name="uid" />
					<button>확인</button>
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
					<input type="tel" name="uphone"/>
				</p>
				<p>
					<input type="submit" value="가입"/>
					<button>취소</button>
				</p>
			</fieldset>
		</form>
	</section>
</div>