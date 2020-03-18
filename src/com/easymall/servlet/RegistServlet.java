package com.easymall.servlet;

import com.easymall.dao.UserDao;
import com.easymall.domain.User;
import com.easymall.utils.StringUtils;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

/**
 * @auther Summerday
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //乱码处理
        //请求处理
        request.setCharacterEncoding("utf-8");
        //响应乱码处理
        response.setContentType("text/html;charset=utf-8");

        //获取所有请求参数
        Map<String, String[]> map = request.getParameterMap();
        User user = new User();

        try {
            BeanUtils.populate(user, map);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }

        String valistr = request.getParameter("valistr");


        //验证码非空校验
        if (StringUtils.isEmpty(valistr)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("validate_msg", "验证码不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }
        //获取session中的验证码
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("code");
        session.removeAttribute("code");

        if(!StringUtils.equalsIgnoreCase(code,valistr)){
            //注册页面提示，用户名称不能为空
            request.setAttribute("validate_msg", "验证码错误");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }

        //获取用户发送的参数信息
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");

        //非空校验
        if (StringUtils.isEmpty(username)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("user_msg", "用户名称不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }
        //非空校验
        if (StringUtils.isEmpty(password)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("pas_msg", "密码不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }
        //非空校验
        if (StringUtils.isEmpty(password2)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("pas2_msg", "确认密码不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }
        //非空校验
        if (StringUtils.isEmpty(nickname)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("nick_msg", "昵称不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }
        //非空校验
        if (StringUtils.isEmpty(email)) {
            //注册页面提示，用户名称不能为空
            request.setAttribute("email_msg", "邮箱不能为空");
            //请求转发到注册页面，可以共享数据
            request.getRequestDispatcher("/regist.jsp").forward(request, response);

            //打断下方代码
            return;
        }


        //邮箱格式^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$
        String reg = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        if (!email.matches(reg)) {
            request.setAttribute("email_msg", "邮箱格式错误");
            request.getRequestDispatcher("/regist.jsp").forward(request, response);
            return;
        }
        //密码一致性
        if (!StringUtils.equals(password, password2)) {
            request.setAttribute("pas2_msg", "两次密码不一致");
            request.getRequestDispatcher("/regist.jsp").forward(request, response);
            return;
        }
        //验证码校验
        //TODO:SESSION

        //完整注册
        //用户名存在校验
        //创建用户实体user

        //创建userDao
        UserDao userDao = new UserDao();
        if (userDao.UsernameExist(user)) {
            request.setAttribute("user_msg", "用户名已经存在");
            request.getRequestDispatcher("/regist.jsp").forward(request, response);
            return;
        } else if (userDao.emailExist(user)) {
            request.setAttribute("email_msg", "该邮箱已经存在");
            request.getRequestDispatcher("/regist.jsp").forward(request, response);
            return;
        } else {
            userDao.Insert(user);
        }

        //跳转回首页
        //定时刷新
        response.getWriter().write("<h1 align='center'>恭喜注册成功，3秒后跳转回首页<h1>");
        response.setHeader("refresh", "3;url=http://localhost/");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
