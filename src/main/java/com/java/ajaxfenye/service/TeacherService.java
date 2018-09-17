package com.java.ajaxfenye.service;

import com.java.ajaxfenye.bean.Teacher;

import java.util.List;

public interface TeacherService {

    List<Teacher> getAll();

    Teacher selectById(Integer id);
}
