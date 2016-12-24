/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hellokoding.account.web;

import com.hellokoding.account.Models.Group1;
import com.hellokoding.account.Models.Itemgroup;
import com.hellokoding.account.Models.Item;
import com.hellokoding.account.controller.util.ErrorBean;
import com.hellokoding.account.repository.GroupRepository;
import com.hellokoding.account.repository.ItemGroupRepository;
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
import java.util.List;

/**
 *
 * @author dzni0816
 */
@RequestMapping(value = {"admin/group"})
@Controller
public class Group1Controller {

    @Autowired
    GroupRepository groupRepository;
    @Autowired
    ItemGroupRepository itemGroupRepository;
    @Autowired
    ItemRepository itemRepository;
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
        /*List<Itemgroup> itemGroup = itemGroupRepository.findByGroups1_GroupId(id);
        for (:
             ) {

        }*/
        itemGroupRepository.delete(itemGroupRepository.findByGroups1_GroupId(id));
        groupRepository.delete(groupRepository.findOne(id));
        return "redirect:/admin/group/list";
    }

    @RequestMapping(value = {"/removeitem/{id}"}, method = RequestMethod.GET)
    public String removeItemGroup1(@PathVariable("id") Long id) {
        itemGroupRepository.delete(itemGroupRepository.findOne(id));
        return "redirect:/admin/group/list";
    }

    @RequestMapping(value = {"/add/{iid}/{gid}"}, method = RequestMethod.GET)
    public String addItemGroup1(Itemgroup itemgroup, @PathVariable("iid") Long iid, @PathVariable("gid") Long gid) {
        itemgroup.setItem1(itemRepository.findOne(iid));
        itemgroup.setGroups1(groupRepository.findOne(gid));
        itemGroupRepository.save(itemgroup);
        return "redirect:/admin/group/list";
    }

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findAddress(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("GROUP", groupRepository.findOne(Long.valueOf(id)));
        model.addAttribute("ITEMGROUP_LIST", itemGroupRepository.findAll());
        return "group/view";
    }

    @RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String findAllGroup1(Model model) {
        model.addAttribute("GROUP_1_LIST", groupRepository.findAll());
        model.addAttribute("ITEMGROUP_LIST", itemGroupRepository.findAll());
        return "group/list";
    }

}
