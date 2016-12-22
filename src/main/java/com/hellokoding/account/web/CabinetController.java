package com.hellokoding.account.web;

import com.hellokoding.account.Models.Address;
import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.Models.So;
import com.hellokoding.account.model.User;
import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import javax.ws.rs.BeanParam;
import java.security.Principal;

/**
 * Created by Admin on 27.11.2016.
 */


@RequestMapping(value = {"/cabinet"})
@Controller
public class CabinetController {

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
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @RequestMapping(value = {"/cabinet"}, method = RequestMethod.GET)
    public String cabinet(Model model, Principal principal) {
        //String qwe = bCryptPasswordEncoder.encode("12345678");
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(Long.toString(userRepository.findByUsername(principal.getName()).getId())));
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "/cabinet/list"; //Используется для просмотра главной страницы
    }

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    public String editCustomer(Model model, @PathVariable("id") Long id) {
        model.addAttribute("CUSTOMER", customerRepository.findOne(id));
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        return "cabinet/update";
    }

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String updateCustomer(@Valid
                                 @BeanParam Customer customer/*, BindingResult bindingResult*/) {
        /*if (bindingResult.hasErrors()) {
            return "welcome";
        }*/
        customerRepository.save(customer);
        return "redirect:cabinet";
    }

    @RequestMapping(value = {"/myorders"}, method = RequestMethod.GET)
    public String getOrders(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        return "cabinet/orders";
    }

    @RequestMapping(value = {"/mypayments"}, method = RequestMethod.GET)
    public String getPayments(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("PAYMENTS_LIST", paymentFacade.findBySo1_Customer1_UserId(userid.toString()));
        return "cabinet/payments";
    }

    @RequestMapping(value = {"/login"}, method = RequestMethod.GET)
    public String getLogin(Model model, Principal principal) {
        model.addAttribute("n", principal.getName());
        return "cabinet/login";
    }

    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    public String updateLogin(Principal principal, @RequestParam("name") String name) {
        User user = userRepository.findByUsername(principal.getName());
        user.setUsername(name);
        userRepository.save(user);
        return "redirect:/cabinet/cabinet";
    }

    @RequestMapping(value = {"/password"}, method = RequestMethod.GET)
    public String getPassword(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();

        return "cabinet/payments";
    }

    @RequestMapping(value = {"/apply/{sq}"}, method = RequestMethod.GET)
    public String apply(@PathVariable("sq") Long qw) {
        /*if (bindingResult.hasErrors()) {
            return "welcome";
        }*/
        So so = soRepository.findOne(qw);
        so.setStatus("Ordered");
        soRepository.save(so);
        return "redirect:/application/orderinfo";
    }

    @RequestMapping(value = {"/customerinfo"}, method = RequestMethod.GET)
    public String getCustomer(Model model, Principal principal) {
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(Long.toString(userRepository.findByUsername(principal.getName()).getId())));

        return "cabinet/customer";
    }

}
