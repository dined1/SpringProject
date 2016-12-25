package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
import com.hellokoding.account.model.User;
import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.security.RolesAllowed;
import javax.validation.Valid;
import javax.ws.rs.BeanParam;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
    private PaymentBillRepository paymentBillRepository;
    @Autowired
    private PaymentTypeRepository paymentTypeRepository;
    @Autowired
    private SOProductRepository soProductRepository;
    @Autowired
    private OrdItemRepository ordItemRepository;

    @Autowired
    private SORepository soRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @RolesAllowed("ROLE_USER")
    @RequestMapping(value = {"/cabinet"}, method = RequestMethod.GET)
    public String cabinet(Model model, Principal principal) {
        //String qwe = bCryptPasswordEncoder.encode("12345678");
        if (principal==null){
            return "error";
        }
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
        if (principal==null){
            return "error";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        return "cabinet/orders";
    }

    @RequestMapping(value = {"/mypayments"}, method = RequestMethod.GET)
    public String getPayments(Model model, Principal principal) {
        if (principal==null){
            return "error";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("PAYMENTS_LIST", paymentFacade.findBySo1_Customer1_UserId(userid.toString()));
        return "cabinet/payments";
    }


    @RequestMapping(value = {"/password"}, method = RequestMethod.GET)
    public String getPassword(Model model, Principal principal) {
        if (principal==null){
            return "error";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        return "cabinet/password";
    }

    @RequestMapping(value = {"/password"}, method = RequestMethod.POST)
    public String updatePassword(Principal principal, @RequestParam("name1") String name1,
                                 @RequestParam("name2") String name2, @RequestParam("name3") String name3) {
        if (principal==null){
            return "error";
        }
        if (name2.length() < 8 || name2.length() > 32
                || name3.length() < 8 || name3.length() > 32) {
            return "error";        }
        if (!name2.equals(name3) || userRepository.findByUsername(principal.getName()) == null
                || !bCryptPasswordEncoder.matches(name1, userRepository.findByUsername(principal.getName()).getPassword())){
            return "error";
        }
        if (bCryptPasswordEncoder.matches(name2, userRepository.findByUsername(principal.getName()).getPassword())){
            return "error";
        }
        User u = userRepository.findByUsername(principal.getName());
        User user = new User();
        user.setId(u.getId());
        user.setPassword(bCryptPasswordEncoder.encode(name2));
        user.setPasswordConfirm(bCryptPasswordEncoder.encode(name2));
        user.setRoles(u.getRoles());
        user.setUsername(u.getUsername());
        userRepository.save(user);
        return "redirect:/cabinet/cabinet";
    }

    @RequestMapping(value = {"/apply/{sq}"}, method = RequestMethod.GET)
    public String apply(@PathVariable("sq") Long qw, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        /*if (bindingResult.hasErrors()) {
            return "welcome";
        }*/
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date date = new Date();
        So so = soRepository.findOne(qw);
        if (!so.getStatus().equals("Ordered")) {
            so.setStatus("Ordered");
            so.setOrderDate(dateFormat.format(date));
            soRepository.save(so);
            List<ProductItems> productItems = productItemsRepository.findAll();
            List<ProductItems> productItemsList = new ArrayList<>();
            for (ProductItems product : productItems) {
                if (product.getOrdItem().getStatus().equals("Wait") && qw.equals(product.getSoproduct1().getSo1().getSOId())) {
                    OrdItem item = product.getOrdItem();
                    item.setStatus("Ordered");
                    ordItemRepository.save(item);
                }
            }
            Paymentbill paymentbill = new Paymentbill();
            paymentbill.setCmp(so.getFinalMP().floatValue());
            paymentbill.setCotp(so.getFinalOTP().floatValue());
            paymentBillRepository.save(paymentbill);
            Payment payment = new Payment();
            payment.setPaymentDate(date);
            payment.setPaymentInfo("Payment was succesfull");
            payment.setSo1(so);
            payment.setPaymentbill1(paymentbill);
            payment.setPaymenttype1(paymentTypeRepository.findOne(2L));
            paymentFacade.save(payment);
        }
        return "redirect:/application/orderinfo";
    }

    @RequestMapping(value = {"/customerinfo"}, method = RequestMethod.GET)
    public String getCustomer(Model model, Principal principal) {
        Long id =  userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(id.toString()));

        return "cabinet/cabinet";
    }

    @RequestMapping(value = {"/newcustomer"}, method = RequestMethod.GET)
    public String emptyCustomer(Model model) {
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        return "cabinet/customerCreate";
    }

    @RequestMapping(value = {"/newcustomer"}, method = RequestMethod.POST)
    public String createCustomer(Principal principal, @Valid
    @BeanParam Customer customer, @RequestParam(value = "Address", required = false) String addre) {
        Address address = addressRepository.findOne(Long.valueOf(addre));
        customer.setAddress1(address);
        Long u = userRepository.findByUsername(principal.getName()).getId();
        customer.setUserId(String.valueOf(u));
        customerRepository.save(customer);
        return "redirect:/cabinet/cabinet";

    }
}
