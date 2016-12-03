/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Paymentbill;
import com.hellokoding.account.repository.PaymentBillRepository;
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
@Path("paymentbill")
public class PaymentbillController {

    @Autowired
    private PaymentBillRepository paymentBillRepository;

    @GET
    @Path("new")
    @javax.mvc.annotation.Controller
    public String emptyPaymentbill() {
        return "paymentbill/create.jsp";
    }

    @POST
    @Path("new")
    @javax.mvc.annotation.Controller
    @ValidateOnExecution(type = ExecutableType.NONE)
    public String createPaymentbill(@Valid
            @BeanParam Paymentbill paymentbill) {

        paymentBillRepository.save(paymentbill);
        return "redirect:paymentbill/list";
    }

    @GET
    @Path("update/{id}")
    @javax.mvc.annotation.Controller
    public String editPaymentbill(Model model, @PathParam("id") Long id) {
        model.addAttribute("PAYMENTBILL", paymentBillRepository.findOne(id));
        return "paymentbill/update.jsp";
    }

    @POST
    @Path("update")
    @javax.mvc.annotation.Controller
    @ValidateOnExecution(type = ExecutableType.NONE)
    public String updatePaymentbill(@Valid
            @BeanParam Paymentbill paymentbill) {
        paymentBillRepository.save(paymentbill);
        return "redirect:paymentbill/list";
    }

    @GET
    @Path("remove/{id}")
    @javax.mvc.annotation.Controller
    public String removePaymentbill(@PathParam("id") Long id) {
        paymentBillRepository.delete(paymentBillRepository.findOne(id));
        return "redirect:paymentbill/list";
    }

    @GET
    @Path("{id}")
    @javax.mvc.annotation.Controller
    public String findPaymentbill(Model model, @PathParam("id") Long id) {
        model.addAttribute("PAYMENTBILL", paymentBillRepository.findOne(id));
        return "paymentbill/view.jsp";
    }

    @GET
    @Path("list")
    @javax.mvc.annotation.Controller
    public String findAllPaymentbill(Model model) {
        model.addAttribute("PAYMENTBILL_LIST", paymentBillRepository.findAll());
        return "paymentbill/list.jsp";
    }
    
}
