package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
import com.hellokoding.account.model.*;
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
import java.security.Principal;

/**
 * Created by Admin on 27.11.2016.
 */


@RequestMapping(value = {"/cabinet"})
@Controller
public class CabinetController {

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
    private SOProductRepository soProductRepository;
    @Autowired
    private SORepository soRepository;
    @Autowired
    private UserRepository userRepository;


    @RequestMapping(value = {"/cabinet"}, method = RequestMethod.GET)
    public String cabinet(Model model) {
        model.addAttribute("CUSTOMER_LIST", customerRepository.findAll());
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "/cabinet/list"; //Используется для просмотра главной страницы
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
        /*if (bindingResult.hasErrors()) {
            return "welcome";
        }*/
        customerRepository.save(customer);
        return "redirect:cabinet/cabinet";
    }

}
