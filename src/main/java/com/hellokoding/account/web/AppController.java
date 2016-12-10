package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
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

import javax.validation.Valid;
import javax.ws.rs.BeanParam;

/**
 * Created by Admin on 27.11.2016.
 */


@RequestMapping(value = {"/application"})
@Controller
public class AppController {

    Integer c;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private DiscountruleRepository discountruleRepository;
    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private ItemRepository itemRepository;
    @Autowired
    private ItemGroupRepository itemGroupRepository;
    @Autowired
    private ItemdiscountRepository itemdiscountRepository;
    @Autowired
    private GroupRepository groupRepository;
    @Autowired
    private ProductItemsRepository productItemsRepository;
    @Autowired
    private PaymentRepository paymentFacade;
    @Autowired
    private PaymentTypeRepository paymentTypeRepository;
    @Autowired
    private SORepository soFacade;
    @Autowired
    private SOProductRepository soProductRepository;
    @Autowired
    private SORepository soRepository;


    @RequestMapping(value = {"/main"}, method = RequestMethod.GET)
    public String findAllItem(Model model) {
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        return "/pages/main"; //Используется для просмотра главной страницы
    }


    @RequestMapping(value = {"/group/{id}"}, method = RequestMethod.GET)
    public String groupItem(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ID", id);
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        model.addAttribute("ITEMGROUP_LIST", itemGroupRepository.findAll());
        model.addAttribute("ITEMDISCOUNT_LIST", itemdiscountRepository.findAll());
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("PAYMENT_LIST", paymentFacade.findAll());
        return "/pages/group";
    }

    @RequestMapping(value = {"/finalpay"}, method = RequestMethod.GET)
    public String emptyPay(Model model) {
        model.addAttribute("PAYTYPE_LIST", paymentTypeRepository.findAll());
        return "/pages/payment"; //Используется для просмотра главной страницы
    }

    /*@RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    public String findPaymentbill(Model model, @PathVariable("id") Long id) {
        c++;
        Item i = itemRepository.findOne(id);
        Soproduct s = soProductRepository.findOne(1l);
        ProductItems p = productItemsRepository.findOne(1l);
        //p.setId(c);
        p.setItem1(i);
        p.setSoproduct1(s);
        productItemsRepository.save(p);
        return "/pages/productCreate";
    }*/

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptyItemdiscount(Model model) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        return "/pages/basket";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createItemdiscount(Model m, @RequestParam("qw") String q) {
        m.addAttribute("q", q);
        return "/pages/other";
    }

    @RequestMapping(value = {"/basket/{id}"}, method = RequestMethod.GET)
    public String emptyBasket(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("ID", id);
        c = id;
        return "/pages/basket";
    }

    @RequestMapping(value = {"/catalog/{id}"}, method = RequestMethod.GET)
    public String emptyCatalog(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        model.addAttribute("ID", id);
        c = id;
        return "/pages/catalog";
    }

    @RequestMapping(value = {"/order/{id}"}, method = RequestMethod.GET)
    public String emptyOrder(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        model.addAttribute("ID", id);
        c = id;
        return "/pages/order";
    }

    @RequestMapping(value = {"/orderinfo"}, method = RequestMethod.GET)
    public String emptyOrderInfo(Model model) {
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "/pages/orderinfo";
    }

    @RequestMapping(value = {"/add/{id1}"}, method = RequestMethod.GET)
    public String addBasket(Model model, ProductItems productItems, @PathVariable("id1") Integer id1) {
        Soproduct soproduct = soProductRepository.findOne(Long.valueOf(c));
        productItems.setSoproduct1(soproduct);
        Item item = itemRepository.findOne(Long.valueOf(id1));
        productItems.setItem1(item);
        productItemsRepository.save(productItems);
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("ID", c);
        return "/pages/basket";
    }

    @RequestMapping(value = {"/remove/{id1}"}, method = RequestMethod.GET)
    public String removeBasket(Model model, @PathVariable("id1") Long id1) {
        productItemsRepository.delete(productItemsRepository.findOne(id1));
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("ID", c);
        return "/pages/basket";
    }

}