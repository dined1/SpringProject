/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Address;
import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.AddressRepository;
import com.hellokoding.account.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;

/**
 *
 * @author dzni0816
 */
@RequestMapping(value = {"/admin/customer"})
@Controller
public class CustomerController {


    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private ApplicationContext applicationContext;
    @Inject
    private ErrorBean error;



    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyCustomer(Model model) {
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        return "customer/create";
    }


    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createCustomer(@Valid
            @BeanParam Customer customer, @RequestParam(value = "Address", required = false) String addre) {
        Address address = addressRepository.findOne(Long.valueOf(addre));
        customer.setAddress1(address);
        customerRepository.save(customer);
        return "redirect:list";
    }


    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editCustomer(Model model, @PathVariable("id") Long id) {
        model.addAttribute("CUSTOMER", customerRepository.findOne(id));
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        return "customer/update";
    }


    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateCustomer(@Valid
            @BeanParam Customer customer, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        customerRepository.save(customer);
        return "redirect:customer/list";
    }


    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public String removeCustomer(@PathVariable("id") Integer id, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        customerRepository.delete(customerRepository.findOne(Long.valueOf(id)));
        return "redirect:customer/list";
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findCustomer(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("CUSTOMER", customerRepository.findOne(Long.valueOf(id)));
        return "customer/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllCustomer(Model model) {
        model.addAttribute("CUSTOMER_LIST", customerRepository.findAll());
        return "customer/list";
    }




    @RequestMapping(value = {"/cabinet"}, method = RequestMethod.GET)
    public String editCabinet(Model model) {
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        return "customer/cabinet";
    }

}
