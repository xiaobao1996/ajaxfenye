package com.java.ajaxfenye.dao;

import com.java.ajaxfenye.bean.Teacher;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;


import java.util.List;
@Repository("teacherDao")
public interface TeacherDao {

   @Select("select * from teacher")
    List<Teacher> getAll();
   @Select("select * from teacher where id = #{id}")
   Teacher select(@Param("id")Integer id);
}
