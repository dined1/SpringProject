package com.hellokoding.account.web;

import com.hellokoding.account.Models.Account;
import com.hellokoding.account.Models.PayUser;
import com.hellokoding.account.repository.AccountRepository;
import com.hellokoding.account.repository.PayUserrepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Context;
import java.util.List;

/**
 * Created by Admin on 02.01.2017.
 */
@RequestMapping(value = {"/payments"})
@Controller
@Transactional
public class Payments {

    @Autowired
    private PayUserrepository payUserrepository;
    @Autowired
    private AccountRepository accountRepository;


    @RequestMapping(value = {"/paylogin"}, method = RequestMethod.GET)
    public String payLogin(Model model) {
        return "/paylogin";
    }


    @RequestMapping(value = {"/paylogin"}, method = RequestMethod.POST)
    public String payLoginpost(@Context HttpServletResponse httpServletResponse,
                               @Context HttpServletRequest httpServletRequest,
                               PayUser payUser, Model model) {
        Cookie cookie = new Cookie("Login", payUser.getLogin());
        httpServletResponse.addCookie(cookie);
        return "redirect:/payments/transfer";
    }

    @RequestMapping(value = {"/transfer"}, method = RequestMethod.GET)
    public String proc(@Context HttpServletResponse httpServletResponse,
                       @Context HttpServletRequest httpServletRequest,
                       Model model) {
        String login = "";
        for (Cookie cookie : httpServletRequest.getCookies()){
            if (cookie.getName().equals("Login")){
                login = cookie.getValue();
            }
        }
        List<Account> accounts = accountRepository.findByUser_Login(login);
        model.addAttribute("Accounts", accounts);
        return "/accounts";
    }
}
