package com.easymall.servlet;

import com.easymall.dao.UserDao;
import com.easymall.domain.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.util.Map;

/**
 * @auther Summerday
 *
 * 登录校验
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        User user = new User();
        UserDao userDao = new UserDao();
        //获取用户信息
        Map<String, String[]> map = request.getParameterMap();
        try {
            BeanUtils.populate(user, map);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
        //用户登录记住用户名
        String remname = request.getParameter("remname");
        if("true".equals(remname)){
            //如果rename的值为true，则记住用户名和remname的value
            String username = user.getUsername();
            Cookie username_cookie = new Cookie("remname", URLEncoder.encode(username,"utf-8"));

            username_cookie.setMaxAge(60*60*12);
            username_cookie.setPath(request.getContextPath()+"/");

            response.addCookie(username_cookie);

        }else {
            //销毁username_cookie
            Cookie username_cookie = new Cookie("remname","kill");
            username_cookie.setMaxAge(0);
            username_cookie.setPath(request.getContextPath()+"/");
            response.addCookie(username_cookie);


        }
        //用户名密码一致
        if(userDao.login(user)!=null){
            //跳转回首页
            //定时刷新
            response.sendRedirect("http://localhost/");

        }else {

            //如果不一致，提示用户名或密码错误
            request.setAttribute("login_error", "用户名或密码错误！");
            //请求转发
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
