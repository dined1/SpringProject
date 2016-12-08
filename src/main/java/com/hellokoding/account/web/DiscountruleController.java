/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Discountrule;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.DiscountruleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.BeanParam;

/**
 *
 * @author dzni0816
 */
@RequestMapping(value = {"/admin/discountrule"})
@Controller
public class DiscountruleController {

    @Autowired
    DiscountruleRepository discountruleRepository;
    @Inject
    private ErrorBean error;

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyDiscountrule() {
        return "/discountrule/create";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createDiscountrule(@Valid
            @BeanParam Discountrule discountrule) {
        discountruleRepository.save(discountrule);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editDiscountrule(Model model, @PathVariable("id") Long id) {
        model.addAttribute("DISCOUNTRULE", discountruleRepository.findOne(id));
        return "discountrule/update";
    }

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateDiscountrule(@Valid
            @BeanParam Discountrule discountrule) {
        discountruleRepository.save(discountrule);
        return "redirect:list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateDiscountrule(@Valid
            @BeanParam Discountrule discountrule, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        discountruleRepository.save(discountrule);
        return "redirect:discountrule/list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public String removeDiscountrule(@PathVariable("id") Long id) {
        discountruleRepository.delete(discountruleRepository.findOne(id));
        return "discountrule/view";
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findDiscountrule(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("DISCOUNTRULE", discountruleRepository.findOne(Long.valueOf(id)));
        return "discountrule/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllDiscountrule(Model model) {
        model.addAttribute("DISCOUNTRULE_LIST", discountruleRepository.findAll());
        return "discountrule/list";
    }
    
}
