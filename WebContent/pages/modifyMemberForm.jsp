<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="vo.*, dao.*"%>
<jsp:useBean id="memberInfo" class="vo.MemberInfoBean" />
<%
	request.setCharacterEncoding("UTF-8");
	CustomerVO vo = (CustomerVO)request.getAttribute("member");
%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쇼핑몰 클론 프로젝트</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/a99df0f94f.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
    
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/underscore@1.11.0/underscore-min.js"></script>
<style>
/* https://github.com/twbs/bootstrap-sass/blob/v3.4.1/assets/stylesheets/bootstrap/_variables.scss#L66 */
.container {
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
	line-height: normal;
	padding: 0;
	margin: 0;
}

p {
	font-size: 16px;
	line-height: normal;
	padding-bottom: 0;
}

img, a {
	padding: 0;
	margin: 0;
}

.contents-wrapper {
	margin-top: 8em;
}

.header-filter-box {
	display: none;
}

.header-menu-list p {
	font-size: 11px;
}

.header-popup-container {
    display: flex;
    justify-content: center;
    align-items: center;
}

.header-menu-list > .menu {
	margin-right: 0.5em;
}

.jumbotron {
  padding: 2rem 1rem;
  margin-bottom: 2rem;
  background-color: #e9ecef;
  border-radius: .3rem;
}

</style>
</head>
<body>
	<!-- 컨테이너의 시작 -->
	<div class="container">
		<!-- 헤더의 시작 -->
        <jsp:include page="/header.jsp">
        	<jsp:param value="true" name="isHide"/>
        </jsp:include>

		<!-- 본문의 시작 -->
		<section>
			<!-- 본문이 들어가는 래퍼 -->
			<div class="contents-wrapper d-flex justify-content-between mb-5">
				<div class="member-form-container col-md-12">

					<div class="jumbotron col-sm-12">
						<p class="lead">회원 정보 수정</p>
					</div>

					<form id="member-info-form" class="form-horizontal col-sm-12"
						action="/members/modifyMember.do">
						<input type="hidden" name="id" value="${member.getId()}">
						<%
							String type = "required";
						%>
						<%
							if( vo.getCtmtype().equals("네이버") ) {
								type = "readonly";
						%>
						<div class="panel panel-default">
							<div class="panel-body">네이버와 연결된 계정입니다.</div>
						</div>
						<% } else if( vo.getCtmtype().equals("카카오") ) {
							type = "readonly";
						%>
						<div class="panel panel-default">
							<div class="panel-body">카카오와 연결된 계정입니다.</div>
						</div>					
						<% } else if( vo.getCtmtype().equals("페북") ) {
							type = "readonly";
						%>
						<div class="panel panel-default">
							<div class="panel-body">페이스북과 연결된 계정입니다.</div>
						</div>
						<% } %>						
						<div class="form-group ">
							<label class="col-form-label col-sm-2" for="email">이메일:</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email" id="email" readonly
									autocomplete="email" placeholder="Enter email"
									value="${ member.getEmail() }">
							</div>
						</div>
						<div class="form-group col-md-12 mb-3 row">
							<label class="col-form-label col-sm-2 col-form-label" for="pwd">비밀번호:</label>
							<div class="col-sm-10">
								<input type="password" name="pw" class="form-control" id="pw"
									placeholder="비밀 번호 입력" autocomplete="current-password" <%=type %> autofocus>
							</div>
						</div>
						<div class="form-group">
							<label class="col-form-label col-sm-2 col-form-label" for="pwd">비밀번호 확인:</label>
							<div class="col-sm-10">
								<input type="password" name="pw" class="form-control" id="pw"
									placeholder="비밀 번호 다시 입력" autocomplete="new-password" <%=type %>>
							</div>
						</div>
						<div class="form-group">
							<label class="col-form-label col-sm-2" for="name">이름:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="이름 입력" value="${ member.getName() }" required>
							</div>
						</div>
						<div class="form-group">
							<label class="col-form-label col-sm-2" for="tel">휴대폰 번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tel" name="tel"
									autocomplete="tel" placeholder="휴대폰 번호 입력"
									value="${ member.getTel() }">
							</div>
						</div>

						<div class="form-group mb-1">
							<label class="col-form-label col-sm-2" for="zipcode">우편 번호:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control col-sm-2" id="zipcode"
									autocomplete="postal-code" name="zipcode"
									value="${ member.getZipCode() }"> <input type="text"
									class="form-control" id="address2" name="address"
									autocomplete="street-address" value="${member.getAddress() }">
							</div>
							<div class="col-sm-4">
								<button type="button" class="btn btn-primary" onclick="searchAddress(this); return false;">주소
									검색 하기</button>
							</div>
						</div>

						<div class="form-group">
							<div class="mb-3 row">
								<label class="col-form-label col-sm-3" for="joindate">가입일</label>
								<div class="col-sm-6">
									<p>${ member.getJoinDate() }</p>
								</div>
							</div>
						</div>

						<div class="form-group row col-md-12">
							<div class="col-sm-offset-2 col-sm-2">
								<button type="button" id="leave-member" class="btn btn-danger">회원 탈퇴</button>
							</div>
							<div class="col-sm-offset-2 col-sm-2">
								<input type="submit" class="btn btn-primary" value="수정 완료">
							</div>

						</div>

					</form>
				</div>
			</div>
		</section>
	</div>
	<!-- 라이트 박스-->
	<div id="light-box-container"></div>
	<jsp:include page="/pages/login.jsp"></jsp:include> 
	<!-- index.js는 메인 용이므로 알맞은 스크립트를 사용해야 합니다-->
	<script type="module" src="${contextPath}/js/MorePage.js"></script>
	<script src="${contextPath}/js/modifyMemberForm.js"></script>
</body>
</html>