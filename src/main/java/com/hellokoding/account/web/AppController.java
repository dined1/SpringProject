package com.hellokoding.account.web;

import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Admin on 27.11.2016.
 */


@RequestMapping(value = {"/application"}, method = RequestMethod.GET)
@Controller
public class AppController {

    @Autowired
    private ItemRepository facade;
    @Autowired
    private ItemGroupRepository itemgroupFacade;
    @Autowired
    private ItemdiscountRepository itemdiscountFacade;
    @Autowired
    private GroupRepository groupFacade;
    @Autowired
    private ProductItemsRepository productItemsFacade;
    @Autowired
    private PaymentRepository paymentFacade;
    @Autowired
    private SORepository soFacade;


    @RequestMapping(value = {"/main"}, method = RequestMethod.GET)
    public String findAllItem(Model model) {
        model.addAttribute("GROUP_LIST", groupFacade.findAll());
        return "pages/main"; //Используется для просмотра главной страницы
    }


    @RequestMapping(value = {"/group/{id}"}, method = RequestMethod.GET)
    public String groupItem(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ID", id);
        model.addAttribute("ITEM_LIST", facade.findAll());
        model.addAttribute("ITEMGROUP_LIST", itemgroupFacade.findAll());
        model.addAttribute("ITEMDISCOUNT_LIST", itemdiscountFacade.findAll());
        model.addAttribute("GROUP_LIST", groupFacade.findAll());
        model.addAttribute("PRODUCTITEMS_LIST", productItemsFacade.findAll());
        model.addAttribute("PAYMENT_LIST", paymentFacade.findAll());
        model.addAttribute("SO_LIST", soFacade.findAll());
        return "pages/group";
    }
}
