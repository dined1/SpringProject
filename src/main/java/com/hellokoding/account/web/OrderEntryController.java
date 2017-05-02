package com.hellokoding.account.web;

import com.hellokoding.account.Models.Address;
import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.Models.So;
import com.hellokoding.account.Models.Soproduct;
import com.hellokoding.account.repository.*;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.UserService;
import com.hellokoding.account.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by dzni0816 on 20.04.2017.
 */

@RequestMapping(value = {"/adm/orderentry"})
@Controller
public class OrderEntryController {

    @Autowired
    private AddressRepository addressRepository;

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

    @Autowired
    private SOProductRepository soProductRepository;


    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String orderEntry(Model model, Principal principal) {

        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(userid.toString()));
        return "/pages/so";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createSalesOrder(Model model, So so, Soproduct soproduct,
                                   @RequestParam("customer") String custom,
                                   @RequestParam("addresslist") String addressId) {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        Customer customer = customerRepository.findOne(Long.valueOf(custom));
        if (soRepository.findByCustomer1_CustomerIdAndAddress_AddressId(customer.getCustomerId(), Long.valueOf(addressId)) != null){
            return "redirect:/adm/orderentry/";
        }
        Address address = addressRepository.findOne(Long.valueOf(addressId));
        so.setStatus("Open");
        so.setFinalMP(BigDecimal.ZERO);
        so.setFinalOTP(BigDecimal.ZERO);
        so.setDistributionChannel(customer.getAddress1().getCountry());
        so.setFinalMPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setFinalOTPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setDateCreated(dateFormat.format(date));
        so.setAddress(address);
//        so.setDateModified(dateFormat.format(date));
        so.setCustomer1(customer);
        soRepository.save(so);
        String s = "";
        for (int i = 0; i < 4-so.getSOId().toString().length(); i++)
            s += '0';
        so.setSONumber(s + so.getSOId().toString());
        soRepository.save(so);
        soproduct.setSOPId(so.getSOId());
        soproduct.setSo1(so);
        soProductRepository.save(soproduct);
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "redirect:/adm/orderentry/"+customer.getCustomerId();
    }
}
