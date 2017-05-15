<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="wrapper">
	<section>
		<form action="upload" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>사진 등록</legend>
				<div class="input-box">
					<p>
						<label for="">폴더 이름</label>
						<input type="text" name="directory"/>
					</p>
					<p>
						<input type="file" name="files"  multiple="multiple" id="uploadFile"/>
					</p>
					<p class='btn-area'>
						<input type="submit" value="등록"/>
					</p>
				</div>
			</fieldset>
		</form>
	</section>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>
	$(function(){
		$(".btn-area input").click(function(e){
			e.preventDefault();
			if ($("#uploadFile").val() == "") {
				alert("파일을 선택해주세요!");
			}else{
				$("form").submit();
			}
		});
	});
</script>