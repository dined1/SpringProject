/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.*;
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
@RequestMapping(value = {"admin/so"})
@Controller
public class SoController {

    @Autowired
    OrdItemRepository ordItemRepository;
    @Autowired
    OrdItemdiscountRepository ordItemdiscountRepository;
    @Autowired
    OrdItemCharacteristicsRepository ordItemCharacteristicsRepository;
    @Autowired
    SORepository soRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ProductItemsRepository productItemsRepository;
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
    public String findSo(Model model, @PathVariable("id") Long id) {
        model.addAttribute("SO", soRepository.findOne(id));
        model.addAttribute("PROD", productItemsRepository.findBySoproduct1_SOPId(id));
        model.addAttribute("USER", userRepository.findOne(Long.valueOf(soRepository.findOne(id).getCustomer1().getUserId())));
        return "so/view";
    }

    @RequestMapping(value = {"/item/{id}"}, method = RequestMethod.GET)
    public String findItem(Model model, @PathVariable("id") Long id) {
        model.addAttribute("ITEM", ordItemRepository.findOne(id));
        model.addAttribute("DISC", ordItemdiscountRepository.findByOrdItem_orditemId(id));
        model.addAttribute("CHAR", ordItemCharacteristicsRepository.findByOrdItem_orditemId(id));
        return "so/item";
    }

    @RequestMapping(value = {"/pay/{id}"}, method = RequestMethod.GET)
    public String fakePay(Model model, @PathVariable("id") Long id) {
        So so = soRepository.findOne(id);
        so.setStatus("Ordered");
        soRepository.save(so);
        return "redirect:/admin/so/list";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllSo(Model model) {
        model.addAttribute("SO_WAIT", soRepository.findByStatus("Wait"));
        model.addAttribute("SO_ORDERED", soRepository.findByStatus("Ordered"));
        return "so/list";
    }

}
