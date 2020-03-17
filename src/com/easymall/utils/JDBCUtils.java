package com.easymall.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @auther Summerday
 * JDBC工具类
 */
public class JDBCUtils {

    //datasource对象
    private static DataSource ds;

    //加载配置文件
    static{
        try {
            //加载配置文件
            Properties prop = new Properties();
            //使用classloader加载配置文件，获取字节输入流
            InputStream in = JDBCUtils.class.getClassLoader().getResourceAsStream("druid.properties");
            prop.load(in);
            //初始化连接池对象
            ds = DruidDataSourceFactory.createDataSource(prop);

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取连接池对象
     */
    public static DataSource getDataSource(){
        return ds;
    }
    /**
     * 获取连接
     */
    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }
}