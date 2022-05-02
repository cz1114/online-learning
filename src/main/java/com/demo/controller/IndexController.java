package com.demo.controller;

import com.demo.bean.Password;
import com.demo.bean.User;
import com.demo.common.Result;
import com.demo.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.Map;

@Controller
public class IndexController {
    @Autowired
    UserService userService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request,Model model){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user==null){
            model.addAttribute("msg","please login first");
            return "redirect:/";
        }
        model.addAttribute("user",user);
        return "views/index";
    }



    @RequestMapping("/")
    public String toLogin(){
        return "views/user/login";
    }

    @RequestMapping("/loginCheck")
    public String loginCheck(User user,Model model,HttpServletRequest request){
        if(user.getLoginname()!=null&&!"".equals(user.getLoginname())){
           if(user.getPwd()!=null&&!"".equals(user.getPwd())) {
              User user1= userService.loginCheck(user);
              if(user1!=null){
                  HttpSession session = request.getSession();
                  session.setAttribute("user",user1);
                  return "redirect:/index";
              }

           }
        }
            model.addAttribute("msg","password error or username does not exist");
            return "views/user/login";
    }

    @RequestMapping("toLogout")
    public String toLogout( HttpSession session){
        session.removeAttribute("user");
        return "redirect:/";
    }

    @RequestMapping("toChangePassWord")
    public String toChangePassWord(){
        return "views/set/user/password";
    }

    @RequestMapping("toInfo")
    public String toInfo(HttpServletRequest request,Model model){
        User user = (User) request.getSession().getAttribute("user");
        model.addAttribute("item",user);
        return "views/set/user/info";
    }

    @RequestMapping("changePassword")
    @ResponseBody
    public Result changePassword(@RequestBody Password password, HttpSession session){
        System.out.println(password);
        User user = (User) session.getAttribute("user");
        if(user.getPwd().equals(password.getOldPassword())){
            user.setPwd(password.getPassword());
            userService.updateUser(user);
            session.removeAttribute("user");
            return Result.ok();
        }else {
            return Result.error().msg("The original password is incorrect. Please confirm and try again");
        }

    }


    @RequestMapping("changeInfo")
    @ResponseBody
    public Result changeInfo(@RequestBody User user){
        userService.updateUser(user);
        return Result.ok();
    }

    @RequestMapping("register")
    @ResponseBody
    public Result register(@RequestBody Map param){
        System.out.println(param);
        User user=userService.getByloginname(param.get("loginname").toString());
        if(user!=null){
            return Result.error().msg("The user name has been occupied. Please confirm and try again");
        }else {
           userService.saveItem(param);
            return Result.ok();
        }

    }
}
