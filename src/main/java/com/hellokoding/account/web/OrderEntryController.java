package com.hellokoding.account.web;

import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.repository.CharacteristicsRepository;
import com.hellokoding.account.repository.CustomerRepository;
import com.hellokoding.account.repository.DiscountruleRepository;
import com.hellokoding.account.repository.GroupRepository;
import com.hellokoding.account.repository.ItemGroupRepository;
import com.hellokoding.account.repository.ItemRepository;
import com.hellokoding.account.repository.ItemdiscountRepository;
import com.hellokoding.account.repository.LocationRepository;
import com.hellokoding.account.repository.SORepository;
import com.hellokoding.account.repository.UserRepository;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.UserService;
import com.hellokoding.account.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;

/**
 * Created by dzni0816 on 20.04.2017.
 */

@RequestMapping(value = {"/adm/orderentry"})
@Controller
public class OrderEntryController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private GroupRepository groupRepository;

    @Autowired
    private ItemGroupRepository itemGroupRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CharacteristicsRepository characteristicsRepository;

    @Autowired
    private LocationRepository locationRepository;

    @Autowired
    private DiscountruleRepository discountruleRepository;

    @Autowired
    private ItemdiscountRepository itemdiscountRepository;

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private SORepository soRepository;


    @RequestMapping(value = {"/adm/orderentry/{customerId}"}, method = RequestMethod.GET)
    public String orderEntry(Model model, Principal principal,
                             @PathVariable("customerId") Long customerId) {
        Customer customer = customerRepository.findOne(customerId);
        model.addAttribute("SO_WAIT", soRepository.findByStatus("Wait"));
        model.addAttribute("SO_ORDERED", soRepository.findByStatus("Ordered"));
        model.addAttribute("SOES", soRepository.findAll());
        model.addAttribute("CUSTOMER", customer);
        return "admin";
    }
}
