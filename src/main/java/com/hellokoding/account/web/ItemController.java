/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Item;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.ItemRepository;
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
@RequestMapping(value = {"/admin/item"})
@Controller
public class ItemController {

    @Autowired
    ItemRepository itemRepository;
    @Inject
    private ErrorBean error;

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyItem() {
        return "item/create";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createItem(@Valid
            @BeanParam Item item) {
        itemRepository.save(item);
        return "redirect:list";
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editItem(Model model, @PathVariable("id") Long id) {
        model.addAttribute("ITEM", itemRepository.findOne(id));
        return "item/update";
    }

    /*@GET
    @Path("author")
    @javax.mvc.annotation.Controller
    public String author() {
        model.put("log", "sdf");
        return "item/author.jsp";
    }

    @POST
    @Path("author")
    @javax.mvc.annotation.Controller
    @ValidateOnExecution(type = ExecutableType.NONE)
    public String author(@Valid
                         @BeanParam Reg reg) {
        model.put("log", reg.getLogin());
        model.put("pass", reg.getPassword());
        return "item/hello.jsp";
    }

    @GET
    @Path("cat")
    @javax.mvc.annotation.Controller
    public String cat() {
        model.put("ITEM_LIST", facade.findAll());
        model.put("cat", "Pain");
        return "item/cat.jsp";
    }*/

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateItem(@Valid
                                @BeanParam Item item) {
        itemRepository.save(item);
        return "redirect:list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    public String updateItem(@Valid
                                @BeanParam Item item, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "welcome";
        }
        itemRepository.save(item);
        return "redirect:item/list";
    }

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    public RedirectView removeItem(@PathVariable("id") Long id) {
        itemRepository.delete(itemRepository.findOne(id));
        return new RedirectView("/item/list");
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findItem(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ITEM", itemRepository.findOne(Long.valueOf(id)));
        return "item/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllItem(Model model) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        return "item/list";
    }

    /*@GET
    @Path("group/{id}")
    @javax.mvc.annotation.Controller
    public String groupItem(@PathParam("id") Integer id) {
        model.put("ID", id);
        model.put("ITEM_LIST", facade.findAll());
        model.put("ITEMGROUP_LIST", itemgroupFacade.findAll());
        model.put("ITEMDISCOUNT_LIST", itemdiscountFacade.findAll());
        model.put("GROUP_LIST", groupFacade.findAll());
        model.put("PRODUCTITEMS_LIST", productItemsFacade.findAll());
        model.put("PAYMENT_LIST", paymentFacade.findAll());
        model.put("SO_LIST", soFacade.findAll());
        return "item/group.jsp";
    }*/
    
}
