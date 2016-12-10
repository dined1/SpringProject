/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Group1;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.GroupRepository;
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
@RequestMapping(value = {"/group"})
@Controller
public class Group1Controller {

    @Autowired
    GroupRepository groupRepository;
    @Inject
    private ErrorBean error;

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyGroup1() {
        return "group/create";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createGroup1(@Valid
            @BeanParam Group1 group1) {
        groupRepository.save(group1);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editGroup1(Model model, @PathVariable("id") Long id) {
        model.addAttribute("GROUP", groupRepository.findOne(id));
        return "group/update";
    }

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateGroup1(@Valid
            @BeanParam Group1 group1) {
        groupRepository.save(group1);
        return "redirect:list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateGroup1(@Valid
            @BeanParam Group1 group1, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        groupRepository.save(group1);
        return "redirect:list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public String removeGroup1(@PathVariable("id") Long id) {
        groupRepository.delete(groupRepository.findOne(id));
        return "group/view";
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findAddress(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("GROUP", groupRepository.findOne(Long.valueOf(id)));
        return "group/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllGroup1(Model model) {
        model.addAttribute("GROUP_1_LIST", groupRepository.findAll());
        return "group/list";
    }

}
