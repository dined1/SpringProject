/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.model.Role;
import com.hellokoding.account.model.User;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.RoleRepository;
import com.hellokoding.account.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import java.security.Principal;
import java.util.*;

/**
 *
 * @author dzni0816
 */
@Transactional
@RequestMapping(value = {"/admin/role"})
@Controller
public class RoleController {

    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Inject
    private ErrorBean error;

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyRole() {
        return "/role/create";
    }


    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createRole(@Valid
                                @BeanParam Role role) {
        roleRepository.save(role);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editRole(Model model, @PathVariable("id") Long id) {
        model.addAttribute("ROLE", roleRepository.findOne(id));
        return "role/update";
    }



    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateRole(@Valid
                                @BeanParam Role role) {
        roleRepository.save(role);
        return "redirect:list";
    }


    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateRole(@Valid
                                @BeanParam Role role, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        roleRepository.save(role);
        return "redirect:role/list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public RedirectView removeRole(@PathVariable("id") Long id) {
        roleRepository.delete(roleRepository.findOne(id));
        return new RedirectView("/role/list");
    }

    @RequestMapping(value = {"/setadm/{id}"}, method = RequestMethod.GET)
    public String setAdm(User user, @PathVariable("id") Long id) {
        user = userRepository.findById(id);
        List<Role> rl = roleRepository.findAll();
        List<Role> rq = new ArrayList<Role>();
        for (Role r: rl) if (!r.getName().equals("ROLE_MODER")) rq.add(r);
        user.setRoles(new HashSet<>(rq));
        user.setId(id);
        userRepository.save(user);
        return "redirect:/admin/role/list";
    }

    @RequestMapping(value = {"/setmod/{id}"}, method = RequestMethod.GET)
    public String setMod(User user, @PathVariable("id") Long id) {
        user = userRepository.findById(id);
        List<Role> rl = roleRepository.findAll();
        List<Role> rq = new ArrayList<Role>();
        for (Role r: rl) if (!r.getName().equals("ROLE_ADMIN")) rq.add(r);
        user.setRoles(new HashSet<>(rq));
        user.setId(id);
        userRepository.save(user);
        return "redirect:/admin/role/list";
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findRole(User user, Principal principal, Model model, @PathVariable("id") Long id) {
        user = userRepository.findById(id);
        user.setRoles(new HashSet<>(roleRepository.findAll()));
        List<Role> rl = roleRepository.findAll();
        user.getRoles();
        Set<Role> i = user.getRoles();
        Boolean adm = false;
        Boolean mod = false;
        //if (i.contains())
        model.addAttribute("ID", id);

        //model.addAttribute()
        return "role/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllRole(Model model) {
        model.addAttribute("USER_LIST", userRepository.findAll());
        return "role/list";
    }
    
}
