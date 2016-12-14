/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.Models.So;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.CustomerRepository;
import com.hellokoding.account.repository.SORepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;

/**
 *
 * @author dzni0816
 */
@RequestMapping(value = {"/so"})
@Controller
public class SoController {

    @Autowired
    SORepository soRepository;
    @Autowired
    CustomerRepository customerRepository;
    @Inject
    private ErrorBean error;


    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptySo(Model model) {
        model.addAttribute("CUSTOMER_LIST", customerRepository.findAll());
        return "/so/create";
    }


    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createSo(@Valid
                               @BeanParam So so, @RequestParam(value = "customer1", required = false) String cust) {
        Customer customer = customerRepository.findOne(Long.valueOf(cust));
        so.setCustomer1(customer);
        soRepository.save(so);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editSo(Model model, @PathVariable("id") Long id) {
        model.addAttribute("SO", soRepository.findOne(id));
        return "so/update";
    }



    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateSo(@Valid
                                @BeanParam So so) {
        soRepository.save(so);
        return "redirect:list";
    }


    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateSo(@Valid
                                @BeanParam So so, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        soRepository.save(so);
        return "redirect:so/list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public RedirectView removeSo(@PathVariable("id") Long id) {
        soRepository.delete(soRepository.findOne(id));
        return new RedirectView("/so/list");
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findSo(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("SO", soRepository.findOne(Long.valueOf(id)));
        return "so/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllSo(Model model) {
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "so/list";
    }

}
