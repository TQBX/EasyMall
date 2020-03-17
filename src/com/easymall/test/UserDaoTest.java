package com.easymall.test;

import com.easymall.dao.UserDao;
import com.easymall.domain.User;
import org.junit.Test;

/**
 * @auther Summerday
 */
public class UserDaoTest {

    @Test
    public void test(){
        User user = new User();
        user.setUsername("admin");
        UserDao userDao = new UserDao();
        System.out.println(userDao.UsernameExist(user));
        //User[id=1, username='admin', password='123', nickname='炒鸡管理员', email='admin@tedu.cn']
    }
}
