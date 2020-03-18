package com.easymall.servlet;

import com.easymall.dao.UserDao;
import com.easymall.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @auther Summerday
 */
@WebServlet("/AjaxCheckUsernameServlet")
public class AjaxCheckUsernameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //乱码处理
        //请求处理
        request.setCharacterEncoding("utf-8");
        //响应乱码处理
        response.setContentType("text/html;charset=utf-8");
        //ajax用户名查重

        String username = request.getParameter("username");
        User user = new User();
        user.setUsername(username);
        UserDao userDao = new UserDao();

        if(userDao.UsernameExist(user)){
            //如果存在
            response.getWriter().write("用户名已存在");


        }else {
            response.getWriter().write("用户名可使用");
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
