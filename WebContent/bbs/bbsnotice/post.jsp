<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP Board</title>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/><br/>
		<table width="600" cellpadding="3">
			<tr> 
				<td bgcolor="#84F399" height="25" align="center">�۾���</td>
			</tr>
		</table>
		<br/>
		<form name="postFrm" method="post" action="boardPost" enctype="multipart/form-data">
			<table width="600" cellpadding="3" align="center">
				<tr>
					<td align="center">
						<table align="center">
							<tr>
								<td width="12%">�� ��</td>
								<td width="90%"><input name="wrtnm" size="10" maxlength="8"></td>
							</tr>
							<tr>
								<td>�� ��</td>
								<td><input name="ctitle" size="50" maxlength="30"></td>
							</tr>
							<tr>
								<td>�� ��</td>
								<td><textarea name="ctxt" rows="25" cols="55"></textarea></td>								
							</tr>
							<tr>
								<td>��й�ȣ</td>
								<td><input type="password" name="cpwd" size="15" maxlength="15"></td>								
							</tr>
							<tr>
								<td>����ã��</td>
								<td><input type="file" name="filename" size="50" maxlength="50"></td>								
							</tr>
							<tr>
								<td>����Ÿ��</td>
								<td>HTML<input type="radio" name="contentType" value="HTTP">&nbsp;&nbsp;&nbsp;
								TEXT<input type="radio" name="contentType" value="TEXT" checked></td>
							</tr>
							<tr>
								<td colspan="2"><hr/></td>										
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="���">
									<input type="reset" value="�ٽþ���">
									<input type="button" value="����Ʈ" onClick="javascript:location.href='list.jsp'">
								</td>										
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>