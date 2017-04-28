<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("존재하지 않는 아이디입니다.");
	self.location = "${pageContext.request.contextPath}/user/login";
</script>
</body>
</html>