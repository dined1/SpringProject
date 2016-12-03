/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Paymenttype;
import com.hellokoding.account.repository.PaymentTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import javax.validation.Valid;
import javax.validation.executable.ExecutableType;
import javax.validation.executable.ValidateOnExecution;
import javax.ws.rs.*;

/**
 *
 * @author dzni0816
 */
@Path("paymenttype")
public class PaymenttypeController {

    @Autowired
    private PaymentTypeRepository paymentTypeRepository;

    @GET
    @Path("new")
    @javax.mvc.annotation.Controller
    public String emptyPaymenttype() {
        return "paymenttype/create.jsp";
    }

    @POST
    @Path("new")
    @javax.mvc.annotation.Controller
    @ValidateOnExecution(type = ExecutableType.NONE)
    public String createPaymenttype(@Valid
            @BeanParam Paymenttype paymenttype) {
        paymentTypeRepository.save(paymenttype);
        return "redirect:paymenttype/list";
    }

    @GET
    @Path("update/{id}")
    @javax.mvc.annotation.Controller
    public String editPaymenttype(Model model, @PathParam("id") Long id) {
        model.addAttribute("PAYMENTTYPE", paymentTypeRepository.findOne(id));
        return "paymenttype/update.jsp";
    }

    @POST
    @Path("update")
    @javax.mvc.annotation.Controller
    @ValidateOnExecution(type = ExecutableType.NONE)
    public String updatePaymenttype(@Valid
            @BeanParam Paymenttype paymenttype) {
        paymentTypeRepository.save(paymenttype);
        return "redirect:paymenttype/list";
    }

    @GET
    @Path("remove/{id}")
    @javax.mvc.annotation.Controller
    public String removePaymenttype(@PathParam("id") Long id) {
        paymentTypeRepository.delete(paymentTypeRepository.findOne(id));
        return "redirect:paymenttype/list";
    }

    @GET
    @Path("{id}")
    @javax.mvc.annotation.Controller
    public String findPaymenttype(Model model, @PathParam("id") Long id) {
        model.addAttribute("PAYMENTTYPE", paymentTypeRepository.findOne(id));
        return "paymenttype/view.jsp";
    }

    @GET
    @Path("list")
    @javax.mvc.annotation.Controller
    public String findAllPaymenttype(Model model) {
        model.addAttribute("PAYMENTTYPE_LIST", paymentTypeRepository.findAll());
        return "paymenttype/list.jsp";
    }
    
}
