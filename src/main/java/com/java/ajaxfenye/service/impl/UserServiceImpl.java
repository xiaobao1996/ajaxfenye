package com.java.ajaxfenye.service.impl;

import com.java.ajaxfenye.bean.User;
import com.java.ajaxfenye.dao.UserDao;
import com.java.ajaxfenye.service.UserService;
import com.java.ajaxfenye.utils.PageUtil;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public List<User> getAll() {
        return userDao.selectAll();
    }

    @Override
    public PageUtil getByPage(String num) {
        if(num == null || num.equals("")){
            num = "1";
        }
            int count = userDao.getCount();
            PageUtil pu = new PageUtil(Integer.parseInt(num),count);
            List<User> users = userDao.getByPage(pu);
            pu.setRecords(users);

        return pu;
    }

    @Override
    public boolean addUser(User user) {
        return userDao.insert(user);
    }

    @Override
    public boolean remove(Integer id) {
        return userDao.delete(id);
    }

    @Override
    public void edit(User user) {
         userDao.update(user);
    }
     public User getById(Integer id){
        return  userDao.selectById(id);
    }
}
