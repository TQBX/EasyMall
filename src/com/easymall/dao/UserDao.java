package com.easymall.dao;

import com.easymall.domain.User;
import com.easymall.utils.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @auther Summerday
 */
public class UserDao {


    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());


    /**
     * 登录方法
     *  判断用户名密码是否正确
     */
    public User login(User loginUser){
        try {
            //编写sql
            String sql = "select * from user where username = ? and password = ?";

            //调用query方法
            return template.queryForObject
                    (sql, new BeanPropertyRowMapper<>(User.class), loginUser.getUsername(), loginUser.getPassword());
            //找不到就会报这个错：Incorrect result size: expected 1, actual 0，捕捉并返回null
        }catch (DataAccessException e){
            return null;
        }
    }

    /**
     * 判断用户名是否存在
     * @param user 传入的user实体
     * @return  如果存在就返回值，不存在返回null
     */
    public boolean UsernameExist(User user){
        try {
            String sql = "select * from user where username = ?";
            template.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), user.getUsername());
        }catch (DataAccessException e){
            return false;
        }
        return true;
    }
    /**
     * 判断邮箱是否存在
     * @param user 传入的user实体
     * @return  如果存在就返回值，不存在返回null
     */
    public boolean emailExist(User user){
        try {
            String sql = "select * from user where email = ?";
            template.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), user.getEmail());
        }catch (DataAccessException e){
            return false;
        }
        return true;
    }

    //利用template对象添加数据
    public void Insert(User user){
        String sql = "insert into user values(null,?,?,?,?)";
        int update = template.update(sql, user.getUsername(), user.getPassword(), user.getNickname(), user.getEmail());
    }

}
