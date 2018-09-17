package com.java.ajaxfenye.service.impl;

import com.java.ajaxfenye.bean.Teacher;
import com.java.ajaxfenye.dao.TeacherDao;
import com.java.ajaxfenye.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherDao teacherDao;


    @Override
    public List<Teacher> getAll() {
        return teacherDao.getAll();
    }

    @Override
    public Teacher selectById(Integer id) {
        return teacherDao.select(id);
    }
}
