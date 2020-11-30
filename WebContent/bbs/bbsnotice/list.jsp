<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="core.board.notice.BoardBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="core.board.notice.BoardMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	
	int totalRecord = 0;		// ��ü �Խù� ��
	int numPerPage = 10;		// ������ �� �� ����
	int pagePerBlock = 15;		// �� �� ������ ��
	
	int totalPage = 0;			// ��ü ������ ��
	int totalBlock = 0;			// ��ü �� ��
	
	int nowPage = 1;			// �� ������
	int nowBlock = 1;			// �� ��
	int start = 0;				// board ���̺��� select ���۹�ȣ
	int end = 10;				// ���۹�ȣ�κ��� ������ select ����   = number page ?
	
	int listSize = 0; 			// ���� �о�� �Խù� ��
	
	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	
	if(request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	if(request.getParameter("reload") != null) {
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if(request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);		// ��ü ������ ��
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);		// ���� �� ���
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);	// ��ü �� ���	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function paging(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value) {
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (value - 1) + 1;
		document.readFrm.submit();
	}
	
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.submit();
	}
	
	function check() {
		if(document.searchFrm.keyWord.value == "") {
			alert("�˻�� �Է��ϼ���");
			document.searchFrm.keyWord.focus();
			return;			
		}
		document.searchFrm.submit();
	}	
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/>
		<h2>JSP Board</h2>
		<br/>
		<table align="center" border="0" width="80%">
			<tr>
				<td>Total : <%=totalRecord%>�� ��(<font color="red"><%=nowPage%>/<%=totalPage%>Pages</font>)</td>
			</tr>
		</table>
		<table align="center" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center" colspan="2">
					<%
						vlist = bMgr.getBoardList(keyField, keyWord, start, end);
						listSize = vlist.size();			// ȭ�鿡 ��µ� �Խù� ��
						if(vlist.isEmpty()) {
							out.println("��ϵ� �Խù��� �����ϴ�.");
						} else {
					%>
					<table border="0" width="100%" cellpadding="2" cellspacing="0">
						<tr align="center" bgcolor="#D0D0D0" height="120%">
							<td width="80">�� ȣ</td>
							<td width="330">�� ��</td>
							<td width="70">�� ��</td>
							<td width="150">�� ¥</td>
							<td width="70">��ȸ��</td>
						</tr>
						<%
							for (int i = 0; i < numPerPage; i++) {
								if(i == listSize) break;	
								BoardBean bean = vlist.get(i);
								int num = bean.getCtxtno();
								String name = bean.getWrtnm();
								String subject = bean.getCtitle();
								String regdate = bean.getWrtdate();
								int count = bean.getViewcnt();
								
						%>
								<tr>
									<td align="center"><%=totalRecord - ((nowPage - 1) * numPerPage) - i%></td>
									<td>
										<a href="javascript:read('<%=num%>')"><%=subject%></a>
									</td>
									<td align="center"><%=name%></td>
									<td align="center"><%=regdate%></td>
									<td align="center"><%=count%></td>
								</tr>
						<% } %>			<!-- 115 line for ���� -->
					</table>
					<%	} %>		<!-- 104 line else ���� -->
				</td>
			</tr>
			<tr>
				<td colspan="2"><br/><br/></td>
			</tr>
			<tr>
				<td>
				<!-- ����¡ �� ��� ó�� -->
					<%
						int pageStart = (nowBlock - 1) * pagePerBlock + 1;		//������ �ϴ� ���� ��ȣ
						int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? (pageStart + pagePerBlock) : totalPage + 1; 	// ������ �ϴ� �� ��ȣ
						if(totalPage != 0) {
							if (nowBlock > 1) {	%>
								<a href="javascript:block('<%=nowBlock-1%>')">prev...</a> 
							<% } %>&nbsp;
							<%
							for ( ; pageStart < pageEnd; pageStart++) {
							%>
								<a href="javascript:paging('<%=pageStart%>')">
								<%
								if(pageStart == nowPage) { %> <font color="red"> <% } %>
								[<%=pageStart%>]
								<%if(pageStart == nowPage) {%> </font> <% } %>
								</a>
						<% } %><!-- 162 line for ���� --> &nbsp;	
						<% if(totalBlock > nowBlock) {%>
							<a href="javascript:block('<%=nowBlock + 1%>')">...next</a>
						<% } %> &nbsp;
					<% } %>
				</td>
				<!-- ����¡ �� ��� ó�� ���� -->
				<td align="right">
					<a href="post.jsp">[�۾���]</a>
					<a href="javascript:list()">[ó������]</a>
				</td>
			</tr>
		</table>
		<hr width="80%">
		<form name="searchFrm" method="post" action="list.jsp">
			<table border="0" width="527" align="center" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<select name=keyField size="1" height="30">
							<option value="name">�̸�</option>
							<option value="title">����</option>
							<option value="ctxt">����</option>
						</select>
						<input size="16" name="keyWord">
						<input type="button" value="ã��" onClick="javascript:check()">
						<input type="hidden" name="nowPage" value="1">
					</td>
				</tr>
			</table>
		</form>
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<input type="hidden" name="nowPage" value="1">
		</form>
		<form name="readFrm" method="get">
			<input type="hidden" name="num">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>
</body>
</html>