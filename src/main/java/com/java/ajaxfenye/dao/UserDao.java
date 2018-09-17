package com.java.ajaxfenye.dao;

import com.java.ajaxfenye.bean.User;
import com.java.ajaxfenye.utils.PageUtil;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("userDao")
public interface UserDao {

    List<User>selectAll();

    @Select("select count(*) from users")
    int getCount();

    List<User> getByPage(PageUtil pu);

    boolean insert(User user);

    @Delete("delete from users where id = #{id}")
    boolean delete(@Param("id") Integer id);

    void update(User user);


    User selectById(@Param("id")Integer id);
}
