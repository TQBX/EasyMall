<%@ page import="com.sun.org.apache.regexp.internal.RE" %>
<%@ page import="sun.awt.SunHints" %>
<%@ page import="java.net.URLDecoder" %><%--
  Date: 2020/3/17
  Time: 12:09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css"/>
        <title>EasyMall欢迎您登陆</title>
    </head>
    <body>
        <h1>欢迎登陆EasyMall</h1>
        <form action="<%=request.getContextPath()%>/LoginServlet" method="POST">
            <table>
                <%
                    Cookie remname = null;

                    Cookie[] cookies = request.getCookies();
                    if(cookies!=null) {
                        for (Cookie cookie : cookies) {
                            if("remname".equals(cookie.getName())){
                                String value = URLDecoder.decode(cookie.getValue(),"utf-8");
                                cookie.setValue(value);
                                remname = cookie;
                            }
                        }
                    }
                    String username = "";
                    if(remname!=null){
                        username = remname.getValue();
                    }
                %>
                <tr>
                    <td colspan="2" style="color:red;text-align: center">
                        <%=request.getAttribute("login_error") == null ? "" : request.getAttribute("login_error")%>
                    </td>
                </tr>
                <tr>
                    <td class="tdx">用户名：</td>
                    <td><input type="text" name="username" value="<%=username%>"/></td>
                </tr>
                <tr>
                    <td class="tdx">密&nbsp;&nbsp; 码：</td>
                    <td><input type="password" name="password"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="checkbox" name="remname" value="true" <%="".equals(username)?"":"checked = 'checked'"%>/>记住用户名
                        <input type="checkbox" name="autologin" value="true"/>30天内自动登陆
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center">
                        <input type="submit" value="登 陆"/>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
