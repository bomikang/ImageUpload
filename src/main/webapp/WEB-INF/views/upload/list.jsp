<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.one-image{display: inline-block; margin:15px; position:relative;text-align: right;}
	.one-image img{height:100px; box-shadow: 2px 2px 1px 1px gray;}
	.one-image input{position: absolute; margin-top:-96px; margin-left:-15px; visibility: hidden;}
	.one-image button{position: absolute; font-size: 20px; width:30px; margin:-33px;}
	#whenClickSelDel{display:none;}
</style>
<div class="wrapper">
	<section>
		<form action="" method="post" id="form1">
		<fieldset>
			<legend>${folder}</legend>
			<input type="hidden" name="folder" value="${folder}"/>
			<input type="hidden" name="fullname" id="deleteEach" />
			<span id="selCheckName">
				<!-- 삭제할 이미지들 -->
			</span>
			
			<c:if test="${!empty error}">
				<p>등록된 사진이 없습니다.</p>
			</c:if>
			<c:if test="${imageList.size() < 1}">
				<p>등록된 사진이 없습니다.</p>
			</c:if>
			<c:if test="${imageList.size() >= 1}">
				<span id="deleteButtonBox">
					<button id="btnAllDel">전체삭제</button>
					<button id="btnSelectDel">선택삭제</button>
				</span>
				<span id="whenClickSelDel">
					<button id="btnDelOk">삭제</button>
					<button id="btnDelCancel">취소</button>
				</span>
				
				<div>
					<c:forEach var="item" items="${imageList}">
						<div class="one-image">
							<img src="displayFile?fileName=${item}" alt="${item}" />
							<input type="checkbox" value="${item}" class="check-del"/>
							<button class='x-button'>X</button>
						</div>
					</c:forEach>
				</div>
			</c:if>
			</fieldset>
		</form>
	</section>
</div>
<script>
	/* 전체삭제 */
	$("#btnAllDel").click(function(){
		var check = confirm("모든 이미지를 삭제하시겠습니까?");
		if(!check){
			return false;
		}
		
		$("#form1").attr("action", "deleteAll");
		$("#form1").submit();
	});
	
	/* 선택삭제버튼을 클릭하면 삭제와 취소 버튼 나타남 */
	$("#btnSelectDel").click(function(e){
		e.preventDefault();
		$("#deleteButtonBox").css("display", "none");
		$("#whenClickSelDel").css("display", "block");
		$(".check-del").css("visibility", "visible");
		$(".x-button").css("visibility", "hidden");
	});
	
	/* 선택삭제버튼을 클릭 후 나타난 취소버튼을 클릭했을 때 */
	$("#btnDelCancel").click(function(e){
		e.preventDefault();
		$("#deleteButtonBox").css("display", "block");
		$("#whenClickSelDel").css("display", "none");
		$(".check-del").css("visibility", "hidden");
		$(".check-del").prop("checked", false);
		$(".x-button").css("visibility", "visible");
	});
	
	/* 선택삭제버튼을 클릭 후 나타난 삭제버튼을 클릭했을 때 */
	$("#btnDelOk").click(function(e){
		e.preventDefault();
		
		$("#selCheckName").html("");
		
		var count = 0;
		for(var i = 0; i < $(".check-del").length; i++){
			if( $(".check-del").eq(i).prop("checked") == true ){
				count++;
				
				var $input = "<input type='hidden' name='selectedFiles' value='" + $(".check-del").eq(i).val() + "'>";
				$("#selCheckName").append($input);
			}
		}
		
		if(count < 1){
			alert("삭제할 사진을 선택해주세요!");
			return false;
		}
		
		var check = confirm(count+" 개의 파일을 삭제하시겠습니까?")
		if(!check){
			return false;
		}
		
		$("#form1").attr("action", "deleteSelected");
		$("#form1").submit();
	});

	/* 각각 X버튼 클릭 */
	$(".one-image button").each(function(i, obj){
		$(obj).click(function(){
			var filename = $(obj).parent(".one-image").find("img").attr("alt");
			
			var check = confirm("정말 삭제하시겠습니까?")
			if(!check){
				return false;
			}
			
			//input hidden으로 매개변수 전달
			$("#deleteEach").val(filename);
			$("#form1").attr("action", "deleteEach");
			$("#form1").submit();
		});
	});
</script>
