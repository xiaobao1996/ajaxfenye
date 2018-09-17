package com.java.ajaxfenye.service;

import com.java.ajaxfenye.bean.User;
import com.java.ajaxfenye.utils.PageUtil;

import java.util.List;

public interface UserService {
    List<User> getAll();

    PageUtil getByPage(String num);
    boolean addUser(User user);

    boolean remove(Integer id);

    void edit(User user);
    User getById(Integer id);
}
