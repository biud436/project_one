<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>���θ� Ŭ�� ������Ʈ</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a99df0f94f.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/underscore@1.11.0/underscore-min.js"></script>
</head>
    <!-- �����̳��� ���� -->
    <div class="container">
    	<jsp:include page="header.jsp"></jsp:include>
    	
        <!-- ������ ���� -->
        <section>
            <!-- ������ ���� ���� -->
            <div class="contents-wrapper">    
            	<jsp:include page="join.html"></jsp:include>
            </div>
        </section>
    </div>
    <!-- ����Ʈ �ڽ�-->
    <div id="light-box-container">
    </div>
    <!-- ��ũ��Ʈ -->
    <!-- <script src="../js/boardMain.js"></script>     -->
    <script type="module" src="../js/MorePage.js"></script>    
</html>
