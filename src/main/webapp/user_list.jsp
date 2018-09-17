<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>user_list</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        /*.container{overflow: hidden;}*/
        .table{text-align: center; margin: 100px auto 0;cursor: pointer;}
        .table button{margin:0 20px;}
        .container .bt{position: absolute;top:40px;left: 10%;}
        #input_add{padding: 0 auto;display: none;}
        ul li {cursor:pointer;}
    </style>
    <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
</head>
<body>
    <div class="container">
        <button type="button" class="btn btn-info bt" id="to_add">添加</button>
        <table class="table table-hover table-striped" id="table">
            <thead class="active">
            <td>序号</td>
            <td>姓名</td>
            <td>密码</td>
            <td>老师</td>
            <td>操作</td>
            </thead>
            <thead id="input_add">
            <td>新增信息</td>
            <td><input type="text" id="input_name"></td>
            <td><input type="password" id="input_password"></td>
            <td><select name="input_teacher" id="input_teacher"></select></td>
            <td><button type="button" class="btn btn-info" onclick="do_add();">提交</button></td>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
    </div>
    <div style="text-align: center">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="u_li">
            </ul>
        </nav>
    </div>
</body>
</html>

<script>
    window.onload = list(1);
    function list(num){
        var url = "${pageContext.request.contextPath}/user/list.do";
        var num =num;
        if(num==null||num==''){
            num = 1;
        }
        var data = {num:num};
        $.post(url,data,function(res){
            $("#tbody tr").remove();
            $("#u_li li").remove();
            $.each(res.page.records,function(i,v){
                $("#tbody").append(
                    "<tr><td>"+v.id+"</td><td>"+v.name+"</td><td>"+v.password+"</td><td>"+v.teacher.name+"</td>" +
                     "<td><button type='button' class='btn btn-success'>详情</button>" +
                    "<button type='button' class='btn btn-info' onclick='to_edit(this,"+v.id+");'>编辑</button>" +
                    "<button type='button' class='btn btn-danger' onclick='del(this,"+v.id+");'>删除</button></td></tr>"
                );
            });
            $.each(res.teachers,function(i,v){
                $("#input_teacher").append("<option value='"+v.id+"'>"+v.name+"</option>");
            });


            if(res.page.currentPageNum == 1){
                console.log(res.page.currentPageNum );
                $("#u_li").append("<li  ><a href='javascript:return false;' onclick='return false;' style='color:#000;cursor:w-resize;' >首页</a></li>");
                $("#u_li").append("<li class='li_pre'><a href='javascript:void(0);' style='color:#000;cursor:w-resize;' >上一页</a></li>");
            }else{
                $("#u_li").append("<li  ><a href='javascript:;' onclick='list(1)'>首页</a></li>");
                $("#u_li").append("<li class='li_pre'><a href='javascript:;' onclick='list("+res.page.prePageNum+");'>上一页</a></li>");
            }

            for(var i=res.page.endPageNum;i>=res.page.startPageNum;i--){
                var li_str="<li ><a href='javascript:;' onclick='list("+i+");'>"+i+"</a></li>";
                $("#u_li .li_pre").after(li_str);
            }
            if(res.page.currentPageNum == res.page.totalPageNum){
                $("#u_li").append("<li  ><a href='javascript:void(0);' style='color:#000;cursor:w-resize;'>下一页</a></li>");
                $("#u_li").append("<li class='li_pre'><a href='javascript:void(0);' style='color:#000;cursor:w-resize;'>尾页</a></li>");
            }else{
                $("#u_li").append("<li ><a href='javascript:;' onclick='list("+res.page.nextPageNum+");'>下一页</a></li>");
                $("#u_li").append("<li ><a href='javascript:;' onclick='list("+res.page.totalPageNum+");'>尾页</a></li>");
            }

            $("#u_li").append("<li><a href='javascript:;'>"+num+"/"+res.page.totalPageNum+"共"+res.page.totalSize+"条</a></li>");

        },"json");
    }
    var name;
    var password;
    var oteacher;
    var id;
    function to_edit(obj,id){
        var obj = $(obj);
        var p_node = obj.parents('tr');
        var index =  $("#tbody tr").index(p_node);
        id = $("#tbody tr").eq(index).find('td').eq(0).text();
         name = $("#tbody tr").eq(index).find('td').eq(1).text();
         password = $("#tbody tr").eq(index).find('td').eq(2).text();
         oteacher = $("#tbody tr").eq(index).find('td').eq(3).text();
        console.log(oteacher);
        $("#tbody tr").eq(index).find('td').eq(0).html(id);
        $("#tbody tr").eq(index).find('td').eq(1).html("<input type='text' name='up_name' value='"+name+"' id='up_name'>");
        $("#tbody tr").eq(index).find('td').eq(2).html("<input type='text' name='up_pwd' value='"+password+"' id='up_pwd'>");
        $("#tbody tr").eq(index).find('td').eq(3).html("<select name='up_sid' id = 'upsid'></select>");
        $("#tbody tr").eq(index).find('td').eq(4).html("" +
            "<button type='button' class='btn btn-info' onclick='do_update(this);'>提交</button>" +
            "<button type='button' class='btn btn-danger' onclick='do_reg(this);'>取消</button>");

        var url = "${pageContext.request.contextPath}/user/ft.do";
        var data ={};
        $.post(url,data,function (res) {
            console.log(res);
            $.each(res,function (i,v) {
                $("#upsid").append("<option value="+v.id+">"+v.name+"</option>");
            });
        },"json");
        var up_name = $("#up_name").val();
        var up_pwd = $("#up_pwd").val();
        var sid = $("upsid").val();
    }
    function do_reg(obj){
        var obj = $(obj);
        var p_node = $(obj).parents('tr');
        var index = $("#tbody tr").index(p_node);
        $("#tbody tr").eq(index).find('td').eq(1).html('');
        $("#tbody tr").eq(index).find('td').eq(2).html('');
        $("#tbody tr").eq(index).find('td').eq(3).html('');
        $("#tbody tr").eq(index).find('td').eq(4).html('');
        $("#tbody tr").eq(index).find('td').eq(1).html(name);
        $("#tbody tr").eq(index).find('td').eq(2).html(password);
        $("#tbody tr").eq(index).find('td').eq(3).html(oteacher)
        $("#tbody tr").eq(index).find('td').eq(4).html("<button type='button' class='btn btn-success'>详情</button>" +
            "<button type='button' class='btn btn-info' onclick='to_edit(this,"+id+");'>编辑</button>" +
            "<button type='button' class='btn btn-danger' onclick='del(this,"+id+");'>删除</button>");
    }
    function do_update(obj){
        var obj = $(obj);
        var p_node = obj.parents('tr');
        var index =  $("#tbody tr").index(p_node);
        var up_name = $("#up_name").val();
        var up_pwd = $("#up_pwd").val();
        var upsid = $("#upsid").val();
        console.log(upsid);
        var  id = $("#tbody tr").eq(index).find('td').eq(0).text();
        var url = "${pageContext.request.contextPath}/user/update.do";
        var data = {id:id,name:up_name,password:up_pwd,sid:upsid};
        $.post(url,data,function(res){
            console.log(res);
            $("#tbody tr").eq(index).find('td').eq(1).html('');
            $("#tbody tr").eq(index).find('td').eq(2).html('');
            $("#tbody tr").eq(index).find('td').eq(3).html('');
            $("#tbody tr").eq(index).find('td').eq(4).html('');

            $("#tbody tr").eq(index).find('td').eq(1).html(up_name);
            $("#tbody tr").eq(index).find('td').eq(2).html(up_pwd);
            $("#tbody tr").eq(index).find('td').eq(3).html(res.teacher.name)
            $("#tbody tr").eq(index).find('td').eq(4).html("<button type='button' class='btn btn-success'>详情</button>" +
            "<button type='button' class='btn btn-info' onclick='to_edit(this,"+res.id+");'>编辑</button>" +
            "<button type='button' class='btn btn-danger' onclick='del(this,"+res.id+");'>删除</button>");
        },"json");
        console.log(up_name);
    }
    function  do_add() {
        var name = $("#input_name").val();
        var password = $("#input_password").val();
        var sid = $("#input_teacher").val();
        var data = {name:name,password:password,sid:sid};
        var url = "${pageContext.request.contextPath}/user/add.do";
        $.post(url,data,function (res) {
            if(res){
                $("#input_add").hide();
                list(1);
            }
        },"json");
    }
    function del(obj,id){
        var obj = $(obj);
        var id = id;
        var data = {id:id};
        var url = "${pageContext.request.contextPath}/user/del.do"
        $.post(url,data,function (res) {
                obj.parents('tr').remove();
                list(1);
        },"json");
    }
   ;$(function () {
        $("#to_add").click(function(){
            $("#input_add").show();
        });
    });
</script>

