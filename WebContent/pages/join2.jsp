<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.MemberMgr" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/join.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    
   
</head>

<body>
    <div class="header"></div>

    <div class="main">
        <div class="content_login">
            <h2 class="title">회원가입</h2>
            <span>회원정보를 입력해주세요.</span>
            <!-- <hr class="line_top"> -->
            <form id="join_form" name="user_form" method="post" action="/members/signUp.do">
                <ul class="form_list">
                    <li>
                        <!-- 아이디 -->
                        <label for="id" class="label1">
                            <span>ID를 입력해주세요.</span>
                            <span>띄어쓰기없이 영/숫자 6~14자</span>
                        </label>
                        <input type="text" id="login_id" name="id" maxlength="14">
                        <div id="idMsg" class="ability_chk">
                         	
                     
                        </div>
                    </li>
                    <li>
                        <!-- 비밀번호 -->
                        <label for="pw" class="label1">
                            <span>비밀번호를 입력해주세요.</span>
                            <span>띄어쓰기없이 영/숫자 6~14자</span>
                        </label>
                        <input type="password" name="pw" id="password" maxlength="15">
                        <div id="pwd1Msg" class="ability_chk"></div>
                    </li>
                    <li>
                        <!-- 이름 -->
                        <label for="name" class="label1"><span>이름을 입력해주세요.</span></label>
                        <input type="text" name="name" id="user_name" maxlength="30">
                        <div id="userNameMsg" class="ability_chk"></div>
                    </li>
                    <li>
                        <!-- 휴대폰 -->
                        <label for="tel" class="label1"><span>휴대폰번호를 입력해주세요.</span></label>
                        <input type="text" name="tel" id="user_phoneNum" maxlength="30">
                        <div id="userNameMsg" class="ability_chk"></div>
                    </li>
                    <li>
                        <!-- 주소 -->
                        <input type="text" name="zipcode" readonly="true" id="user_adr1" maxlength="40"
                            placeholder="21500">
                        <button type="button" id="bt_adr">주소검색하기</button>

                        <input type="text" name="address1" readonly="true" id="user_adr2" maxlength="40"
                            placeholder="인천 남동구 백범로467번길 51 (간석동, OO빌라)">

                        <label for="address2" class="label1">
                            <span>상세주소를 입력해주세요.</span>
                        </label>

                        <input type="text" name="address2" id="user_adr3" maxlength="40">

                    </li>
                    <li>
                        <!-- 이메일 -->
                        <label for="email1" class="label1">
                            <span>이메일을 입력해주세요.</span>
                        </label>
                        <label for="email2" class="label1"></label>

                        <input type="text" name="email1" id="user_email1" maxlength="30">
                        <span id="sp"></span>

                        <input type="text" name="email2" id="user_email2" maxlength="30">
                        <button type="button" id="bt_email">이메일인증</button>

                        <div id="userEmailMsg" class="ability_chk"></div>
                    </li>

                </ul>
                <input id="join_button" type="submit" value="회원가입">
                
                  </form>

        </div>

    </div>

                <script>
                    // 주소  api
                    $("#bt_adr").click(function () {
                        new daum.Postcode({
                            oncomplete: function (data) {
                                var postNo = data.zonecode;
                                var address = data.roadAddress;

                                $("#user_adr1").val(postNo);
                                $("#user_adr2").val(address);

                            }
                        }).open();
                    });

                    // 올바른 이메일형식 체크
                    $("#bt_email").click(function () {
                        var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
                        var str = $("#user_email1").val() + "@" + $("#user_email2").val();
                        if (!reg_email.test(str)) {
                            alert("이메일형식이 잘못됬습니다.");
                        }
                    });

                    $(".main .content_login input").focus(function () {
                        var read = $(this).prop("readonly");
                        if (!read) {
                            $(this).parent().find(".label1").css("display", "none")
                        }
                    }).blur(function () {
                        var value = $(this).val()
                        if (value == "")
                            $(this).parent().find(".label1").css("display", "block")
                    });

                    $("#user_email1,#user_email2").focus(function () {
                        $("#sp").html("@")
                    }).blur(function () {
                        $("#sp").html(" ")
                    });

                    $(".main .content_login input").focus(function () {
                        var read = $(this).prop("readonly");
                        if (!read) {
                            $(this).parent().find(".label1").css("display", "none")
                        }
                    }).blur(function () {
                        var value = $(this).val()
                        if (value == "")
                            $(this).parent().find(".label1").css("display", "block");
                    })

                    $("#user_email1,#user_email2").focus(function () {
                        $("#sp").html("@")
                    }).blur(function () {
                        $("#sp").html(" ")
                    });

                    $("#join_button").on("click", function (ev) {
                        if ($("#login_id").val() == "") {
                            alert("아이디를 입력하세요");
                            return false;
                        }
                        if ($("#login_pwd1").val() == "") {
                            alert("비밀번호를 입력하세요");
                            return false;
                        }
                        if ($("#user_name").val() == "") {
                            alert("이름을 입력하세요");
                            return false;
                        }
                        if ($("#user_phoneNum").val() == "") {
                            alert("전화번호를 입력하세요");
                            return false;
                        }
                        if ($("#user_adr1").val() == "") {
                            alert("우편번호를 입력하세요");
                            return false;
                        }
                        if ($("#user_adr2").val() == "") {
                            alert("기본주소를 입력하세요");
                            return false;
                        }
                        if ($("#user_adr3").val() == "") {
                            alert("상세주소를 입력하세요");
                            return false;
                        }
                        if ($("#user_email1, user_email2").val() == "") {
                            alert("이메일를 입력하세요");
                            return false;
                        }

                        $(".main .content_login input").trigger("blur");

                    });
                  
                    

                </script>
           
</body>

</html>