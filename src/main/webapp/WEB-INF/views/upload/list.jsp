<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.one-image{display: inline-block; margin:15px; position:relative;text-align: right;}
	.one-image #date{text-align: left; color:gray;}
	.one-image img{height:100px; box-shadow: 3px 3px 2px 1px gray;} 
	.one-image input{position: absolute; margin-top:-96px; margin-left:-15px; visibility: hidden;}
	.one-image .x-button{position: absolute; font-size:18px; width:30px; height:30px; margin:-22px; background:#159b7a; border:2px solid #dedede;
						border-radius: 50%; color:#fff;}
	
	#deleteButtonBox, #whenClickSelDel{display:block; margin-left:17px;}
	#whenClickSelDel{display:none;}
	.modal{width:1200px; position:relative; margin:0 auto; display:none;}
	.modal div{width:80%; height:60%; background:rgba(255,255,255,0.8); margin: 0 auto; z-index:999; position: fixed; top:0; left:0; margin-top:7%; margin-left:10%;
				border-radius: 20px;}
	.modal div #btnClose{position:absolute; border:none; font-size:2em; margin-top:-50px; padding:5px; right:50px; color:#fff; background:rgba(0,0,0,0);}
	.modal div #bigImage{max-width:95%; max-height:600px; text-align: center; margin:0 auto; display:block; padding-top:50px;}
	#cover{width:100%; height:100%; background:rgba(0,0,0,0.6); position:fixed; left:0; top:0; display:none;}
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
							<p id="date"><fmt:formatDate value="${item.regdate}" pattern="yyyy-MM-dd" /></p>
							<img src="displayFile?fileName=${item.fullname}" alt="${item.fullname}" />
							<input type="checkbox" value="${item.fullname}" class="check-del"/>
							<button class='x-button'>X</button>
						</div>
					</c:forEach>
				</div>
			</c:if>
			</fieldset>
		</form>
	</section>
</div>

<div id="cover"></div>

<div class="modal">
	<div>
		<button id="btnClose">CLOSE</button>
		<img src="" alt="" id="bigImage"/>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	/* 각 이미지 클릭 */
	$(".one-image img").click(function(){
		var src = $(this).attr("alt");
		var split = src.split("/");
		var folder = split[1];
		
		var filename = "";
		
		//폴더가 아니면 filename에 folder 저장
		if (folder.indexOf(".jpg") > 0 || folder.indexOf(".png") > 0 || folder.indexOf(".gif") > 0
			|| folder.indexOf(".JPG") > 0 || folder.indexOf(".PNG") > 0 || folder.indexOf(".GIF") > 0) {
			
			filename = folder;
			filename = "/"+filename.replace("s_", "");
		}else{
			filename = split[2];
			filename = "/"+filename.replace("s_", "");
			filename = "/"+folder+filename;
		}

		$("#bigImage").attr("src", "displayFile?fileName="+filename);
		
		$('#bigImage').on("load", function() {
		    $(".modal div").css("height", $(this).height()+100);
		});
		
		$(".modal").fadeIn();
		$("#cover").fadeIn();
	});
	
	$("#btnClose").click(function(){
		$(".modal").fadeOut();
		$("#cover").fadeOut();
	});
	
	
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
		$(".one-image img").unbind("click");
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
