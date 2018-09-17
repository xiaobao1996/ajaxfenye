package com.java.ajaxfenye.servlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.java.ajaxfenye.bean.Teacher;
import com.java.ajaxfenye.bean.User;
import com.java.ajaxfenye.service.TeacherService;
import com.java.ajaxfenye.service.UserService;
import com.java.ajaxfenye.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("userController")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private TeacherService teacherService;
    public  void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String num = request.getParameter("num");
        if(num==null||num.equals("")){
            num = "1";
        }
        PageUtil pageUtil = userService.getByPage(num);
        List<User> list = pageUtil.getRecords();
        System.out.println(list);
        List<Teacher> teachers =teacherService.getAll();

        Map<String,Object> map = new HashMap<>();
        map.put("teachers",teachers);
        map.put("users",list);
        map.put("page",pageUtil);
        String str = JSONObject.toJSONString(map);
        response.getOutputStream().write(str.getBytes("utf-8"));
    }
    public void add(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        Integer sid = Integer.parseInt(request.getParameter("sid"));
        User user = new User();
        user.setName(name);user.setPassword(password);user.setSid(sid);
        boolean flag = userService.addUser(user);
        System.out.println(flag);
        String str = JSON.toJSONString(flag);
        response.getOutputStream().write(str.getBytes("utf-8"));
    }
 public void del(HttpServletRequest request,HttpServletResponse response){
        Integer id = Integer.parseInt(request.getParameter("id"));
        boolean flag = userService.remove(id);
 }
 public void ft(HttpServletRequest request,HttpServletResponse response) throws IOException {
        List<Teacher> list = teacherService.getAll();
        String str = JSON.toJSONString(list);
        response.getOutputStream().write(str.getBytes("utf-8"));
 }
 public void update(HttpServletRequest request,HttpServletResponse response) throws IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        Integer sid = Integer.parseInt(request.getParameter("sid"));
        User user = new User();
        user.setId(id);user.setName(name);user.setPassword(password);user.setSid(sid);
        userService.edit(user);
        User user1 = userService.getById(id);

        String str = JSON.toJSONString(user1);
        response.getOutputStream().write(str.getBytes("utf-8"));
 }
}
