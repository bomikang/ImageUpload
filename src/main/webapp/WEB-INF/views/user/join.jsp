<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	input#uid{width:85% !important;}
	button#checkingId{float:right;}
	.err2, .err{font-size: 12px; color:red; display:none;}
	.ok{font-size:12px; color:#0c961a; display:none;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function emptyCheck($input, $input2){
		var check = true;
		
		$input.each(function(i, obj){
			if($(obj).val() == ""){
				$(obj).parent("p").find(".err").css("display", "block");
				check = false;
			}
		});
		
		$input2.each(function(i, obj){
			if($(obj).val() == ""){
				$(obj).parent("p").find(".err").css("display", "block");
				check = false;
			}
		});
		
		return check;
	}

	$(function(){
		$("#btnSubmit").click(function(){
			if( !emptyCheck( $("input[type='text']"), $("input[type='password']") ) ){
				return false;
			}
			
			if( $("#uid").parent("p").find(".ok").css("display") == "none" ) {
				alert("아이디를 확인해주세요");
				return false;
			}
			if( $("#upw").parent("p").find(".ok").css("display") == "none" ) {
				alert("비밀번호를 확인해주세요");
				return false;
			}
			if( $("#pwdChecking").parent("p").find(".err2").css("display") == "block" ){
				alert("비밀번호 확인이 틀렸습니다");
				return false;
			}
			
			alert("회원가입이 완료되었습니다.");
		});
		
		$("#cancel").click(function(e){
			e.preventDefault();
			location.href = "${pageContext.request.contextPath}/user/login";
		});
		
		$("#checkingId").click(function(e){
			e.preventDefault();
			
			if($("#uid").val() == ""){
				alert("아이디를 입력해주세요!");
				return;
			}
			
			var id = $(this).parent("p").find("input").val();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/user/checkUid",
				type:"post",
				data:{uid : id},
				success:function(result){
					if(result == "exist"){
						$("#checkingId").parent("p").find(".err2").css("display", "block");
						$("#checkingId").parent("p").find(".ok").css("display", "none");
					}else{
						$("#checkingId").parent("p").find(".err2").css("display", "none");
						$("#checkingId").parent("p").find(".ok").css("display", "block");
					}
				}
			});
		});
		
		$("#uid").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
		});
		
		$("#upw").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
			
			if($(this).val().length > 0 && $(this).val().length < 6){
				$(this).parent("p").find(".err2").css("display", "block");
				$(this).parent("p").find(".ok").css("display", "none");
			}else if($(this).val().length == 0){
				$(this).parent("p").find(".err2").css("display", "none");
				$(this).parent("p").find(".ok").css("display", "none");
			}else if($(this).val().length > 5){
				$(this).parent("p").find(".err2").css("display", "none");
				$(this).parent("p").find(".ok").css("display", "block");
			}
			
			if( $("#pwdChecking").val() !="" && $(this).val() != $("#pwdChecking").val() ){
				$("#pwdChecking").parent("p").find(".err2").css("display", "block");
			}else if($("#pwdChecking").val() !="" && $(this).val() == $("#pwdChecking").val()){
				$("#pwdChecking").parent("p").find(".err2").css("display", "none");
			}else if($("#pwdChecking").val() == "" && $(this).val() == ""){
				$("#pwdChecking").parent("p").find(".err2").css("display", "none");
			}
		});
		
		$("#pwdChecking").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
			
			if($(this).val() != $("#upw").val()){
				$(this).parent("p").find(".err2").css("display", "block");
			}else{
				$(this).parent("p").find(".err2").css("display", "none");
			}
		});
		
		$("#uname").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
		});
		
		$("#uemail").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
		});
		
		$("#uphone").keyup(function(){
			$(this).parent("p").find(".err").css("display", "none");
		});
	});
	
</script>
<div class="wrapper">
	<section>
		<form action="join" method="post" id="joinform">
			<fieldset>
				<legend>회원가입</legend>
				<div class="input-box">
					<p>
						<label for="">아이디</label><br />
						<span class="err">아이디를 입력해주세요!</span>
						<span class="err2">이미 존재하는 아이디입니다.</span>
						<span class="ok">사용해도 좋은 아이디입니다.</span>
						<input type="text" name="uid" id="uid" />
						<button id="checkingId">확인</button>
					</p>
					<p>
						<label for="">비밀번호</label><br />
						<span class="err">비밀번호를 입력해주세요!</span>
						<span class="err2">비밀번호가 너무 짧습니다.</span>
						<span class="ok">사용해도 좋은 비밀번호입니다.</span>
						<input type="password" name="upw" id="upw"/>
					</p>
					<p>
						<label for="">비밀번호 확인</label><br />
						<span class="err">비밀번호를 한번 더 확인해주세요!</span>
						<span class="err2">비밀번호가 일치하지 않습니다.</span>
						<input type="password" id="pwdChecking"/>
					</p>
					<p>
						<label for="">이름</label><br />
						<span class="err">이름을 입력해주세요!</span>
						<input type="text" name="uname" id="uname" />
					</p>
					<p>
						<label for="">이메일</label><br />
						<span class="err">이메일을 입력해주세요!</span>
						<input type="text" name="uemail" id="uemail" placeholder="test1@naver.com"/>
					</p>
					<p>
						<label for="">전화번호</label><br />
						<span class="err">전화번호를 입력해주세요!</span>
						<input type="text" name="uphone" id="uphone" placeholder="010-0000-0000"/>
					</p>
					<p class='btn-area'>
						<input type="submit" value="가입" id="btnSubmit"/>
						<button id="cancel">취소</button>
					</p>
				</div>
			</fieldset>
		</form>
	</section>
</div>