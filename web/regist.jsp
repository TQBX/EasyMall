<%--
  Date: 2020/3/17
  Time: 12:09
--%>
<%@ page contentType="text/html;charset=UTF-8" buffer="0kb" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title>欢迎注册EasyMall</title>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" href="css/regist.css"/>

        <style>

            span {
                position: relative;

                color: #990000;
                text-align: center;
            }

        </style>
        <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>

        <script>

            var formObj;
            $(function () {

                //前台校验
                formObj = {

                    checkForm: function () {
                        var flag = true;
                        //非空校验
                        flag = this.checkNull("username", "用户名不能为空") && flag;
                        flag = this.checkNull("password", "密码不能为空") && flag;
                        flag = this.checkNull("password2", "确认密码不能为空") && flag;
                        flag = this.checkNull("nickname", "昵称不能为空") && flag;
                        flag = this.checkNull("email", "邮箱不能为空") && flag;
                        flag = this.checkNull("valistr", "验证码不能为空") && flag;
                        flag = this.checkPassword("password", "两次密码不一致") && flag;
                        flag = this.checkEmail("email", "邮箱格式不正确") && flag;
                        //邮箱格式
                        flag = this.checkEmail() && flag;
                        //密码一致性
                        flag = this.checkPassword() && flag;
                        return flag;

                    },

                    checkPassword: function () {
                        var password = $("input[name='password']").val();
                        var password2 = $("input[name='password2']").val();
                        if ($.trim(password) !== "" && $.trim(password2)) {
                            if (password !== password2) {
                                this.setMsg("password2", "两次密码不一致");
                                return false;
                            }
                        }
                        return true;
                    },
                    checkEmail: function () {
                        //邮箱格式校验
                        var reg = new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
                        var email = $("input[name='email']").val();

                        if (email !== "" && !reg.test(email)) {
                            this.setMsg("email", "邮箱格式有误");
                            return false;
                        }
                        return true;
                    },
                    checkNull: function (name, msg) {
                        var value = $("input[name=" + name + "]").val();
                        this.setMsg(name, "");
                        if ($.trim(value) === "") {
                            this.setMsg(name, msg);
                            return false;
                        }
                        return true;
                    },
                    setMsg: function (name, msg) {
                        $("input[name='" + name + "']").nextAll("span").text(msg).css("color", "purple");
                    }
                };

            })


        </script>
    </head>
    <body>
        <form onsubmit="return formObj.checkForm()" action="<%=request.getContextPath()%>/RegistServlet" method="POST">
            <h1>欢迎注册EasyMall</h1>
            <table>
                <%--<tr>--%>
                <%--    <td class="tds" colspan="2" style="">--%>
                <%--        <%=request.getAttribute("msg")==null?"":request.getAttribute("msg")%>--%>
                <%--    </td>--%>
                <%--</tr>--%>
                <tr>
                    <td class="tds">用户名：</td>
                    <td>
                        <input type="text" name="username"
                               value="<%=request.getParameter("username")==null?"":request.getParameter("username")%>"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("user_msg") == null ? "" : request.getAttribute("user_msg")%></span>
                    </td>
                </tr>

                <tr>
                    <td class="tds">密码：</td>
                    <td>
                        <input type="password" name="password"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("pas_msg") == null ? "" : request.getAttribute("pas_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds">确认密码：</td>
                    <td>
                        <input type="password" name="password2"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("pas2_msg") == null ? "" : request.getAttribute("pas2_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds">昵称：</td>
                    <td>
                        <input type="text" name="nickname"
                               value="<%=request.getParameter("nickname")==null?"":request.getParameter("nickname")%>"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("nick_msg") == null ? "" : request.getAttribute("nick_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds">邮箱：</td>
                    <td>
                        <input type="text" name="email"
                               value="<%=request.getParameter("email")==null?"":request.getParameter("email")%>"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("email_msg") == null ? "" : request.getAttribute("email_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds">验证码：</td>
                    <td>
                        <input type="text" name="valistr"
                               value="<%=request.getParameter("valistr")==null?"":request.getParameter("valistr")%>"/>
                        <img src="img/regist/yzm.jpg" width="" height="" alt=""/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("validate_msg") == null ? "" : request.getAttribute("validate_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="sub_td" colspan="2" class="tds">
                        <input type="submit" value="注册用户"/>
                    </td>
                </tr>
            </table>
        </form>

    </body>
</html>
