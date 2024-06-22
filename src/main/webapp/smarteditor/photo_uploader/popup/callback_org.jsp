<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String callback_func = request.getParameter("callback_func");
	String bNewLine = request.getParameter("bNewLine");
	String errstr = request.getParameter("errstr");
	int fileCount = 0;
	try {
		fileCount = Integer.parseInt(request.getParameter("fileCnt")) ;
	} catch (Exception e) {
		fileCount = 0;
	}

	String[] sFileNames = request.getParameterValues("sFileName");
	String[] sFileURLs = request.getParameterValues("sFileURL");
	String[] alts = request.getParameterValues("alt");
	String[] widths = request.getParameterValues("width");

	StringBuilder oResultBuilder = new StringBuilder();
	if(fileCount > 0){
		oResultBuilder.append("[");
		for(int i = 0; i < fileCount; i++){
			oResultBuilder.append("{");
			oResultBuilder.append("\"callback_func\":\"").append(callback_func).append("\",");
			oResultBuilder.append("\"bNewLine\":").append(bNewLine).append(",");
			oResultBuilder.append("\"sFileName\":\"").append(URLDecoder.decode(sFileNames[i], "utf-8")).append("\",");
			oResultBuilder.append("\"sFileURL\":\"").append(sFileURLs[i]).append("\",");

			if(alts != null){
				oResultBuilder.append("\"alt\":\"").append(URLDecoder.decode(alts[fileCount - (1 + i)], "utf-8")).append("\"");
			}

			if(widths != null){
				if(!"".equals(widths[fileCount - (1 + i)])){
					oResultBuilder.append(",\"width\":\"").append(widths[fileCount - (1 + i)]).append("px\"");
				} else {
					oResultBuilder.append(",\"width\":\"auto\"");
				}
			}

			oResultBuilder.append(i < fileCount - 1 ? "}," : "}");
		}
		oResultBuilder.append("]");
	} else {
		oResultBuilder.append("[{\"errstr\":\"error\",\"callback_func\":\"").append(callback_func).append("\"}]");
	}
	String oResult = oResultBuilder.toString();
%>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>FileUploader Callback</title>
	<script type="text/javascript">
		var oResult = <%=oResult%>;

		if ((oResult[0].errstr || '').length) { // on error
			(parent.jindo.FileUploader._oCallback[oResult[0].callback_func+'_error'])(oResult);
		} else {
			(parent.jindo.FileUploader._oCallback[oResult[0].callback_func+'_success'])(oResult);
		}
	</script>
</head>
<body>
</body>
</html>
