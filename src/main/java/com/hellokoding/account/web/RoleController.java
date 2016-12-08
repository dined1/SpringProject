/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.model.Role;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.RedirectView;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;

/**
 *
 * @author dzni0816
 */
@RequestMapping(value = {"/admin/role"})
@Controller
public class RoleController {

    @Autowired
    RoleRepository roleRepository;
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

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findRole(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ROLE", roleRepository.findOne(Long.valueOf(id)));
        return "role/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllRole(Model model) {
        model.addAttribute("ROLE_LIST", roleRepository.findAll());
        return "role/list";
    }
    
}
