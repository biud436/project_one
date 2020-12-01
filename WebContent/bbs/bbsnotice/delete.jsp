<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="core.board.notice.BoardBean" %>
<jsp:useBean id="bMgr" class="core.board.notice.BoardMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP Board</title>
<%
	request.setCharacterEncoding("EUC-KR");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if (request.getParameter("cpwd") != null) {
		String inPass = request.getParameter("cpwd");
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String dbPass = bean.getCpwd();
		
		if(inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "list.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} else {
%>
<script type="text/javascript">
	alert("�Է��Ͻ� ��й�ȣ�� �ƴմϴ�.");
	history.back();
</script>
<%  	} 	
	} else { %>
<script>
	function check() {
		if (document.delFrm.pass.value == "") {
			alert("�н����带 �Է��ϼ���");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/><br/>	
		<table width="600" cellpadding="3">
			<tr>
				<td bgcolor="#DDDDDD" height="21" align="center">
					������� ��й�ȣ�� �Է��� �ּ���
				</td>
			</tr>	
		</table>	
		<form name="delFrm" method="post" action="delete.jsp">
			<table width="600" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td align="center">
									<input type="password" name="cpwd" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#EEEEEE"/></td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="�����Ϸ�" onClick="check()">
									<input type="reset" value="�ٽþ���">
									<input type="button" value="�ڷ�" onClick="history.go(-1)">
								</td>
							</tr>
						</table>			
					</td>
				</tr>		
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="num" value="<%=num%>">		
		</form>		
	</div>
<%  } %>
</body>
</html>