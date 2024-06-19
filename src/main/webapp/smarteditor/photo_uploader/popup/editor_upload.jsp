<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.multipart.MultipartFile"%>
<%@ page import="org.springframework.web.multipart.commons.CommonsMultipartResolver"%>
<%@ page import="org.springframework.web.multipart.MultipartHttpServletRequest" %>
<%@ page import="util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body onload="document.frm.submit();">
<%
	String callback = request.getParameter("callback");
	String callback_func = request.getParameter("callback_func");

	CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
	MultipartHttpServletRequest multipartRequest = multipartResolver.resolveMultipart(request);

	S3Uploader s3Uploader = (S3Uploader) WebApplicationContextUtils
			.getRequiredWebApplicationContext(application)
			.getBean("S3Uploader");

	int fileCount = 0;
	String url = callback + "?callback_func=" + callback_func;

	String[] imgAlts = multipartRequest.getParameterValues("image_alt");
	String[] widths = multipartRequest.getParameterValues("width");

	Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
%>
<form action="<%=callback%>" method="post" id="frm" name="frm">
	<input type="hidden" name="callback_func" value="<%=callback_func%>" />
	<input type="hidden" name="bNewLine" value="true" />
	<%
		if (!fileMap.isEmpty()) {
			for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
				MultipartFile file = entry.getValue();
				if (!file.isEmpty()) {
					String fileUrl = s3Uploader.uploadFile(file);
					String originalFilename = file.getOriginalFilename();
	%>
	<input type="hidden" name="sFileName" value="<%=originalFilename%>" />
	<input type="hidden" name="sFileURL" value="<%=fileUrl%>" />
	<%if (imgAlts != null) { %>
	<input type="hidden" name="alt" value="<%=URLDecoder.decode(imgAlts[fileCount], "utf-8")%>" />
	<% } %>
	<%if (widths != null) { %>
	<input type="hidden" name="width" value="<%=widths[fileCount]%>" />
	<% } %>
	<%
				fileCount++;
			}
		}
	%>
	<input type="hidden" name="fileCnt" value="<%=fileCount%>" />
	<%
	} else {
	%>
	<input type="hidden" name="errstr" value="error" />
	<%
		}
	%>
</form>
</body>
</html>
