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
						<input type="file" name="files"  multiple="multiple"/>
					</p>
					<p class='btn-area'>
						<input type="submit" value="등록"/>
					</p>
				</div>
			</fieldset>
		</form>
	</section>
</div>