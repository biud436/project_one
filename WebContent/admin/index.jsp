<%@page import="java.io.File"%>
<%@page import="java.nio.file.*"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@page import="javax.sound.midi.Patch"%>
<%@page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.util.List"%>
<%@ page import="core.*"%>
<%@ page import="controller.*"%>
<%@ page import="dao.board.qna.*, dao.*, utils.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%@ page import="org.json.simple.JSONArray, org.json.simple.JSONObject"%>
<!DOCTYPE html>
<%
	String id = (String)session.getAttribute("id");

	if(id == null || id.equals("")) {
		response.sendRedirect("/");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <style>
  	.left {
  		position: fixed;
  	}
  	.right {
  		float: right;
  	}
  	.comment {
  		color: orange;
  	}
  	
  	tr:hover {
  		background-color: #F4F4F6;
  	}
  	
  	:root {
  		--mycolor: rgba(0, 0, 0, 0.6);
  	}
  	
  	table a {
  		color: #000000;
/*   		text-shadow: 1px 1px 1px var(--mycolor), -1px -1px 1px var(--mycolor), 1px 0px 1px var(--mycolor), 0px 1px 1px var(--mycolor), 0px -1px 1px var(--mycolor); */
  	}
  	
  	.window {
  		position: fixed;
  		left: 50%;
  		right: 0;
  		top: 50%;
  		bottom: 0;
  		transform: translate(-50%, -50%);
  		width: 80%;
  		height: 80%;
  		display: none;  
  		z-index: 1;	
  	}
  	
  	.member-information-form {
  	}
  	
  	header {
  		display: fixed;
  		top: 0;
  	}
  	
  	.container {
  		position: relative;
  	}
  	
  	.return-button {
  		position: fixed;
  		bottom: 5%;
  		left: 5%;
	    width: 60px;
	    height: 60px;
	    text-align: center;
	    padding: 6px 0;
	    font-size: 12px;
	    line-height: 1.42;
	    border-radius: 50%;
	    color: #fff;  		
  	}
  	
  </style>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50">
    <div class="container col-md-12">
        <section class="col-md-12">
			<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-primary">
			  <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#main">관리자</a>
			    </div>
			  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>		
			  <div class="collapse navbar-collapse" id="navbarNavDropdown">
			    <ul class="nav navbar-nav">
			      <li class="nav-item active"><a class="nav-link" href="#">Home</a></li>
			      <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            멤버 관리
			          </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#manage-whole-member">전체 멤버 관리</a>
                        <a class="dropdown-item" href="#manage-forced-secession">강제 탈퇴 관리</a>
                        <a class="dropdown-item" href="#currently-login-members">현재 로그인 멤버</a>
			        </div>
			      </li>
			      <li class="nav-item"><a class="nav-link" href="#board-manage" style="display:none">게시물 관리</a></li>
                  <li class="nav-item"><a class="nav-link" href="#log">접속 로그</a></li>
                  <li class="nav-item"><a class="nav-link" href="#uploads">파일 관리</a></li>
                  <li class="nav-item"><a class="nav-link" href="#db-editor" style="display:none">상품 입고 시스템</a></li>
                  <li class="nav-item"><a class="nav-link" href="#product" style="display:none">상품 진열 시스템</a></li>			      
			    </ul>			  
			    <div class="d-flex mr-0">
			    	<button class="btn btn-primary me-2" id="return-button">나가기</button>
			    </div>
			  </div>	    

			  </div>
			</nav>        
            <div class="content-wrapper wall col-md-12 mt-3">
                <div id="main" class="alert alert-secondary" role="alert">
                    <p>관리자 페이지에 오신 것을 환영합니다.</p>
                    <p><span class="col-md-2"><%=id %></span>님 환영합니다. </p>
                    <p>서버 OS : <%=System.getProperty("os.name") %></p>
                    <p>파일 구분자 : <%= File.separator %></p>
                    <p>&nbsp;</p>
                    <p>서버 경로 : <%= request.getServletContext().getRealPath("/") %></p>
                    <p>&nbsp;</p>
<%--                     <p>프로토콜 : <%= request.getScheme() %></p> --%>
<%--                     <p>호스트 주소 : <%= request.getRemoteHost()%> </p> --%>
<%--                     <p>포트 : <%= request.getRemotePort()%> </p> --%>
                </div>
                <div id="manage-whole-member" class="alert alert-success">
                   	<%
                   		CustomerDAO customerDAO = CustomerDAO.getInstance();
                   		List<CustomerVO> customerList = customerDAO.listMembers();
                   	%>                
                   	<c:set var="customerList" value="<%= customerList %>" />                   	
                	<a name="manage-whole-member"></a>
                    <p>전체 멤버 목록입니다 (총 멤버수 : ${ customerList.size() }명)</p>
                    <table id="manage-whole-member-table" class="table">
                    	<thead>
                    		<th>회원 번호</th>
                    		<th>ID</th>
                    		<th>이름</th>
                    		<th>주소</th>
                    		<th>이메일</th>
                    		<th>전화번호</th>
                    		<th>우편번호</th>
                    		<th>회원 정보</th>
                    	</thead>

                   	<c:forEach var="vo" items="${customerList}">
                   		<tr>
                   			<td><span>${vo.getNo()}</span></td>
                   			<td><span>${vo.getId()}</span></td>
                   			<td><span>${vo.getName()}</span></td>
                   			<td><span>${vo.getAddress()}</span></td>
                   			<td><span>${vo.getEmail()}</span></td>
                   			<td><span>${vo.getTel()}</span></td>
                   			<td><span>${vo.getZipCode()}</span></td>
                   			<td><button data-number="${vo.getId()}" class="ban btn btn-primary whole-member">정보 수정하기</button></td>
                   		</tr>
                   	</c:forEach>

                   	<tfoot>
                   		<div class="input-group mb-3">
                   			<label for="search" class="input-group-text">검색 하기</label>
                   			<input type="search" name="search" id="search-specific-member" class="form-control">
                   			<input type="submit" value="검색하기" class="btn btn-info" id="search-specific-member-button">
                   		</div>
                   	</tfoot>
                    </table>
                </div>
                <div id="manage-forced-secession" class="alert alert-secondary">
             	   <a name="manage-forced-secession"></a>
                    <p>강제 탈퇴 관리</p>
                 	<p></p>
                    <table class="table">
                    	<thead>
                    		<th>회원 번호</th>
                    		<th>ID</th>
                    		<th>이름</th>
                    		<th>주소</th>
                    		<th>이메일</th>
                    		<th>전화번호</th>
                    		<th>우편번호</th>
                    		<th>차단 여부</th>
                    	</thead>     	
                   	<c:forEach var="m" items="${customerList}">
                   		<tr>
                   			<td><span>${m.getNo()}</span></td>
                   			<td><span>${m.getId()}</span></td>
                   			<td><span>${m.getName()}</span></td>
                   			<td><span>${m.getAddress()}</span></td>
                   			<td><span>${m.getEmail()}</span></td>
                   			<td><span>${m.getTel()}</span></td>
                   			<td><span>${m.getZipCode()}</span></td>
                   			<td><button data-number="${m.getId()}" class="ban btn btn-danger forced-secession">강제 탈퇴</button></td>
                   		</tr>
                   	  </c:forEach>
                   	</table>         	
                </div>
                <div id="manage-forced-secession" class="alert alert-secondary">
                	<a name="currently-login-members"></a>
                	<p>현재 로그인중인 멤버</p>
                    <table class="table" style="height: 220px; overflow:scroll;">
                    <%
                    	List<CurrentLoginMembersVO> currentlyMembers = AdminUtil.getInstance().getCurrentLoginMembers();
                    %>
                   		<thead>
                   			<th>ID</th>
                   			<th>IP</th>
                   			<th>접속 시간</th>
                   		</thead>
                    <c:set var="currentlyMembers" value="<%= currentlyMembers %>" />
                    	<c:forEach var="item" items="${currentlyMembers }">
                    		<tr>
                    			<td>${ item.getId() }</td>
                    			<td>${ item.getIp() }</td>
                    			<td>${ item.getConnectTime() }</td>
                    		</tr>
                    	</c:forEach>
                    </table>
                </div>
                <div id="board-manage" class="alert alert-secondary" style="display:none">
                	<a name="board-manage"></a>
                    <p>게시판 관리</p>
                    <table class="table" style="height: 200px; overflow:scroll;">
                    <%
	            		BoardDAO boardMgr = BoardDAO.getInstance();
	            		JSONArray json = boardMgr.getListAll();                    
                    %>
                    	<caption class="well">총 글 갯수 : <%= json.size() %> / 페이지 수 : <%= (int)(Math.ceil(json.size() / 10)) %></caption>
                    	<thead>
                    		<th>글 번호</th>
                    		<th>분류</th>
                    		<th>글 제목</th>
                    		<th>작성자</th>
                    		<th>작성일</th>
                    		<th>조회수</th>
                    		<th>추천수</th>
                    		<th>수정</th>
                    		<th>삭제</th>
                    	</thead>
                    	<%                    		
                    		for(int i = 0 ; i < json.size(); i++) {
                    			JSONObject myBoard = (JSONObject)json.get(i);
                    	%>
                    		<tr>
                    			<td><%= myBoard.get("postNumber") %></td>
                    			<td><%= myBoard.get("postType") %></td>
                    			<td><a href="/pages/board-post.jsp?postNumber=<%=myBoard.get("postNumber")%>" target="_blank"><%= myBoard.get("postTitle") %></a></td>
                    			<td><%= myBoard.get("name") %></td>
                    			<td><%= myBoard.get("create_at") %></td>
                    			<td><%= myBoard.get("view") %></td>
                    			<td><%= myBoard.get("recommandCount") %></td>
                    			<td><button data-number="<%= myBoard.get("postNumber") %>" class="btn btn-primary post-modify">글 수정</button></td>
                    			<td><button data-number="<%= myBoard.get("postNumber") %>" class="btn btn-danger post-delete">글 삭제</button></td>
                    		</tr>
                    	<%
                    		}
                    	%>
                    	<tfoot>
                    	<%
                    		int rowSize = json.size();
                    		int pageCounts = (int)(Math.ceil(rowSize / 10)); 
                    	%>
<!--                     		<div class="panel panel-default"> -->
<!--                     			<form class="form-inline">                    		 -->
<!-- 	                    			<div class=" form-group"> -->
<!-- 	                    				<label for="tablename">테이블 명 :</label> -->
<!-- 	                    			 	<input type="text" class="form-control" name="tablename">                    			 -->
<!-- 	                    			</div> -->
<!--                     			</form>                    			 -->
<!--                     		<button class="btn btn-primary">새로운 테이블 만들기</button> -->
<!--                     		</div> -->
                    	</tfoot>
                    </table>
                </div>                
				<div id="all-post" class="alert alert-secondary" style="display:none;">
					<a name="all-post"></a>
                    <p>상품</p>
                    <canvas id="myChart" width="400" height="200"></canvas>
                    <script>
                    
                    $.ajax({
                    	url: "/contents/all.do",
                    	success: function(data) {
                    		
                    		data = JSON.parse(data);

                    		var labels = data
                        			.filter(i => i.pageType === 'item')
                        			.map(i => i.contentData.shop);
                    		
                    		var datas = data.filter(i => i.pageType === 'item')
                        		.map(i => {
	                        		return parseInt( (i.contentData.price || "0").replace(/\,/g,"") );
                        		});
                    		
                            var ctx = document.getElementById('myChart').getContext('2d');
                            var myChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        label: '# of Votes',
                                        data: datas,
                                        backgroundColor: data.map(i => 'rgba(255, 99, 132, 0.2)'),
                                        borderColor: data.map(i => 'rgba(255, 99, 132, 0.2)'),
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                    }
                                }
                            });  
                            
                    	},
                    	error: function(err) {
                    		console.warn(err);
                    	}
                    });

                    </script>
                </div>   
				<div id="log" class="alert alert-secondary">
					<a name="log"></a>
                    <p><strong>접속 로그</strong></p>
                    <div class="panel panel-default">
                    비회원은 접속 기록이 남지 않습니다.
                    </div>
                   	<div class="form-group">
                   		<label class="panel panel-default"><input id="hide-local-ip" type="checkbox" value="hide"><span>로컬 IP 숨김</span></label>
                   	</div>                    
                    <table class="table" id="ip-logging-table" style="height: 220px; overflow:scroll;">
                    <%
                    	List<IpLogger> logger = AdminUtil.getInstance().getIpLogger();
                    %>
                   		<thead>
                   			<th>IP</th>
                   			<th>접속 시간</th>
                   		</<thead>
                    <c:set var="logger" value="<%= logger %>" />
                    	<c:forEach var="item" items="${logger }">
                    		<tr>
                    			<td>${ item.getIp() }</td>
                    			<td>${ item.getConnectTime() }</td>
                    		</tr>
                    	</c:forEach>
                    </table>
                </div>                               
				<div id="uploads" class="alert alert-secondary">
					<a name="uploads"></a>
                    <p>업로드된 파일 관리</p>
                    <div class="panel panel-default">
                    	<p style="font-size: 12px;">선택된 파일 갯수 <span id="selection-file-count">0</span>개입니다.
                    </div>                    
                    <table class="table">
                    <thead>
                    	<th><input type="checkbox" id="all-file-selection"></th>
                    	<th>파일명</th>
                    	<th>파일 크기</th>
                    	<th>게시물 번호</th>
                    	<th>다운로드</th>
                    	<th>파일 삭제</th>
                    </thead>
                    <tbody>
    
					<%
						Path uploadFolder = Path.of(request.getRealPath("uploads"));
					
                	try (DirectoryStream<Path> dirs = Files.newDirectoryStream(uploadFolder)) {
                		for(Path path : dirs) {
					%>
						<tr>
						<c:set var="filename" value="<%=path.getFileName() %>" />
						<td><input type="checkbox" name="file" value="/uploads/${filename}"></td>
						<td><%=path.getFileName()%></td>
						<td><%= path.toFile().length() / 1024 %> KB</td>
						
						<%
							int postNumber = boardMgr.getFileNameToPostNumber(path.getFileName().toString());
						%>
						<c:set var="postNumber" value="<%=postNumber%>" />
						<c:choose>
							<c:when test="${postNumber > 0}">
								<c:set var="isValid" value="가능" />
								<c:set var="btnName" value="btn-default" />
								<td><%= postNumber %></td>
							</c:when>
							<c:otherwise>
								<c:set var="isValid" value="불가능" />
								<c:set var="btnName" value="btn-danger" />
								<td>글이 존재하지 않습니다</td>
							</c:otherwise>
						</c:choose>
						<td>
							<p>${ isValid }</p>
							<form action="/myadmin/openFileBrowser.do">
								<input type="hidden" name="filename" value="/uploads/${filename}">
								<%
									String osType = System.getProperty("os.name");
									if(osType == null) {
										osType = "";
									}
									 boolean isWindows = osType.indexOf("Windows") >= 0; 
								%> 
								<c:if test="<%=isWindows %>" >
									<input type="submit" class="btn ${btnName}" onclick="openImageView('/uploads/${filename}')" value="업로드 폴더 열기">
								</c:if>
							</form>
							<button type="button" class="btn ${btnName}" onclick="openImageView('/uploads/${filename}')">파일 보기</button>
						</td>
						<td>
							<form action="/myadmin/fileDelete.do">
								<input type="hidden" name="filename" value="/uploads/${filename}">
								<input type="submit" class="btn ${btnName}" data-filename="/uploads/${filename}" value="파일 삭제">
							</form>
						</td> 
						</tr>
					<%
                		}
                	} catch(IOException e) {
                		e.printStackTrace();
                	}
					%>
					</tbody>
					<tfoot>
						<button class="btn btn-default disabled" id="multiple-files-delete-button">삭제</button>
					</tfoot>
					</table>
                </div>                               
<%-- 	            <jsp:include page="./db.jsp"></jsp:include> --%>
<%-- 	            <jsp:include page="./product.jsp"></jsp:include> --%>
            </div>
        </section>
<!--         <button class="return-button btn btn-info" ><i class="fas fa-door-open" style="color: white;">나가기</i></button> -->
    </div>
    
    <!-- 회원 정보 수정 창  -->
    <div class="modal window member-information-form col-md-12 panel panel-default">
    	<%
    		String name = "";
    	%>
    	<div class="jumbotron"><h2><em>회원 정보 수정</h2></div>
    	<div class="panel panel-body">
    		<form class="form-group">
    			<div class="form-group col-md-8">
    				<label for="name">이름 : </label>
    				<input type="text" class="form-control" placeholder="회원명을 입력해주세요">
    			</div>
    			<div class="form-group col-md-8">
    				<label for="name">전화번호 : </label>
    				<input type="text" class="form-control" placeholder="전화번호를 입력해주세요">
    			</div>
 			    <div class="form-group col-md-8">
    				<label for="name">주소 : </label>
    				<input type="text" class="form-control" placeholder="주소를 입력해주세요">
    			</div>    			
    		</form>
    		<div class="col-md-12">
    			<center>
    				<button class="btn btn-primary">수정 완료</button>
    				<button class="btn btn-danger" onclick="closeMemberInformation()">취소</button>
    			</center>
    		</div>
    	</div>
    </div>
 
    <div id="image-view" class="modal window col-md-12 panel panel-default">
    	<div class="jumbotron"><h2><em>파일 미리 보기</h2>
    		<button class="btn btn-primary" onclick="hideImageView()">닫기</button>
    	</div>
    	<div class="panel panel-body" style="overflow:scroll">
    		<img src="">
    	</div>
    </div>        

    <script src="./js/admin.js"></script>
</body>
</html>