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
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/regist.css"/>

        <style>

            span {
                position: relative;

                color: #990000;
                text-align: center;
            }

        </style>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>

        <script>

            var formObj;
            //文档就绪事件
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
                //鼠标离焦事件
                $("input[name='username']").blur(function () {
                    var username = $("input[name='username']").val();
                    if(!formObj.checkNull("username", "用户名不能为空")){
                        //如果为空
                        $("#username_msg").text("");
                        return;
                    }

                    //ajax实现，鼠标离开用户名之后去数据库完成查重操作
                    $("#username").load(
                        "<%=request.getContextPath()%>/AjaxCheckUsernameServlet",
                        {"username":username}
                    );

                        $("#username_msg").text("");

                });
                $("input[name='password']").blur(function () {
                    formObj.checkNull("password", "密码不能为空");
                });
                $("input[name='password2']").blur(function () {
                    formObj.checkNull("password2", "确认密码不能为空");
                    formObj.checkPassword();
                });
                $("input[name='email']").blur(function () {
                    formObj.checkNull("email", "邮箱不能为空");
                    formObj.checkEmail();
                });
                $("input[name='nickname']").blur(function () {
                    formObj.checkNull("nickname", "昵称不能为空");
                });
                $("input[name='valistr']").blur(function () {
                       if(!formObj.checkNull("valistr", "验证码不能为空")){
                           $("#validate_msg").text("");
                       }
                });

                //点击图片切换
                $("#img").click(function () {
                    this.src = "<%=request.getContextPath()%>/validateServlet?time="+new Date().getTime();
                })

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
                    <td class="tds"><label for="username_input">用户名：</label></td>
                    <td>
                            <input type="text" name="username" id="username_input" placeholder="请输入用户名"
                                   value="<%=request.getParameter("username")==null?"":request.getParameter("username")%>"/>

                        <span id="username"></span>
                    </td>
                    <td>
                        <span id="username_msg"><%=request.getAttribute("user_msg") == null ? "" : request.getAttribute("user_msg")%></span>
                    </td>
                </tr>

                <tr>
                    <td class="tds"><label for="pas_input">密码：</label></td>
                    <td>
                        <input id="pas_input" type="password" name="password" placeholder="请输入密码"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("pas_msg") == null ? "" : request.getAttribute("pas_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds"><label for="pas2_input">确认密码：</label></td>
                    <td>
                        <input id="pas2_input" type="password" name="password2" placeholder="请确认密码"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("pas2_msg") == null ? "" : request.getAttribute("pas2_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds"><label for="nickname_input">昵称：</label></td>
                    <td>
                        <input type="text" name="nickname" id="nickname_input" placeholder="请输入昵称"
                               value="<%=request.getParameter("nickname")==null?"":request.getParameter("nickname")%>"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("nick_msg") == null ? "" : request.getAttribute("nick_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds"><label for="email_input">邮箱：</label></td>
                    <td>
                        <input type="text" name="email" id="email_input" placeholder="请输入邮箱"
                               value="<%=request.getParameter("email")==null?"":request.getParameter("email")%>"/>
                        <span></span>
                    </td>
                    <td>
                        <span><%=request.getAttribute("email_msg") == null ? "" : request.getAttribute("email_msg")%></span>
                    </td>
                </tr>
                <tr>
                    <td class="tds"><label for="validate_input">验证码：</label></td>
                    <td>
                        <input type="text" name="valistr" id="validate_input" placeholder="请输入验证码"
                               value="<%=request.getParameter("valistr")==null?"":request.getParameter("valistr")%>"/>
                        <img src="<%=request.getContextPath()%>/validateServlet" id="img" width="" height="" alt="验证码"/>
                        <span></span>
                    </td>
                    <td>
                        <span id="validate_msg"><%=request.getAttribute("validate_msg") == null ? "" : request.getAttribute("validate_msg")%></span>
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
