/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.ProductItems;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.ProductItemsRepository;
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
@RequestMapping(value = {"/productitems"})
@Controller
public class ProductItemsController {

    @Autowired
    ProductItemsRepository productItemsRepository;
    @Inject
    private ErrorBean error;

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyProductItems() {
        return "/productitems/create";
    }


    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createProductItems(@Valid
                                @BeanParam ProductItems productItems) {
        productItemsRepository.save(productItems);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editProductItems(Model model, @PathVariable("id") Long id) {
        model.addAttribute("PRODUCTITEMS", productItemsRepository.findOne(id));
        return "productitems/update";
    }



    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateProductItems(@Valid
                                @BeanParam ProductItems productItems) {
        productItemsRepository.save(productItems);
        return "redirect:list";
    }


    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateProductItems(@Valid
                                @BeanParam ProductItems productItems, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        productItemsRepository.save(productItems);
        return "redirect:productitems/list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public RedirectView removeProductItems(@PathVariable("id") Long id) {
        productItemsRepository.delete(productItemsRepository.findOne(id));
        return new RedirectView("/productitems/list");
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findProductItems(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("PRODUCTITEMS", productItemsRepository.findOne(Long.valueOf(id)));
        return "productitems/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllProductItems(Model model) {
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        return "productitems/list";
    }
    
}
