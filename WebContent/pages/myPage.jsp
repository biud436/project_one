<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.net.URLDecoder, service.SendMailService, dao.CustomerDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a99df0f94f.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
            <div class="contents-wrapper">    
                <div class="order-information">
                    <h1>주문 서비스 이용 안내</h1>
                    <ul>
                        <li>반품/교환/환불 신청은 7일 이내만 가능하며, 반품 신청은 1:1 문의 게시판 이용 바랍니다.</li>
                        <li>토요일 배송은 가능하오나 고객 부재, 기업체 휴무, 배송 물량 증가의 경우 월요일 배송됩니다</li>
                    </ul>
                </div>
                <div class="order-table">
                    <div class="order-table-header">
                        <h1>구매 정보</h1>
                    </div>
                    <table>
                        <thead>
                            <th>번호</th>
                            <th>상품명</th>
                            <th>상품코드</th>
                            <th>주문량</th>
                            <th>발송량</th>
                            <th>주문자</th>
                            <th>주문번호</th>
                            <th>주문일자</th>
                            <th>금액</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="order-table-footer">
                        <button disabled>구매 취소</button>
                    </div>
                </div>     
            </div>
        </section>
    </div>
    <!-- 라이트 박스-->
    <div id="light-box-container">
    </div>
    <jsp:include page="/pages/login.jsp"></jsp:include> 
    <!-- 스크립트 --> 
    <script type="module" src="../js/MorePage.js"></script>
</body>
</html>
