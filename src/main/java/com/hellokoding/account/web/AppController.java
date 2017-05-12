package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Admin on 27.11.2016.
 */


@RequestMapping(value = {"/application"})
@Controller
@Transactional
public class AppController {

    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private ItemGroupRepository itemGroupRepository;
    @Autowired
    private GroupRepository groupRepository;
    @Autowired
    private OrdItemRepository ordItemRepository;
    @Autowired
    private ProductItemsRepository productItemsRepository;
    @Autowired
    private PaymentTypeRepository paymentTypeRepository;
    @Autowired
    private SOProductRepository soProductRepository;
    @Autowired
    private SORepository soRepository;
    @Autowired
    private UserRepository userRepository;


    @RequestMapping(value = {"/main"}, method = RequestMethod.GET)
    public String findAllItem(Model model) {
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        return "/pages/main"; //Используется для просмотра главной страницы
    }


    @RequestMapping(value = {"/finalpay"}, method = RequestMethod.GET)
    public String emptyPay(Model model) {
        model.addAttribute("PAYTYPE_LIST", paymentTypeRepository.findAll());
        return "/pages/payment"; //Используется для просмотра главной страницы
    }

    @RequestMapping(value = {"/orderinfo"}, method = RequestMethod.GET)
    public String emptyOrderInfo(Model model, Principal principal) {
        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();

        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        model.addAttribute("USER_ID", userid);
        return "/pages/orderinfo";
    }
    @RequestMapping(value = {"/PayPage"}, method = RequestMethod.GET)
    public String AddPay(Model model, @Context HttpServletRequest request, Card card , Principal principal) {

        Long userid = userRepository.findByUsername(principal.getName()).getId();

        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        model.addAttribute("USER_ID", userid);
        String soid = request.getParameter("SOID");
        String paymentsum = request.getParameter("paymentsum");
        model.addAttribute("SOID", soid);
        model.addAttribute("PAYMENTSUM", paymentsum);
        return "/processing/PayPage";
    }

    @RequestMapping(value = {"/PayNumb"}, method = RequestMethod.GET)
    public String AddPayNumb(Model model, @Context HttpServletRequest request, Card card , Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();

        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        model.addAttribute("USER_ID", userid);
        String soid = request.getParameter("SOID");
        String paymentsum = request.getParameter("paymentsum");
        model.addAttribute("SOID", soid);
        model.addAttribute("PAYMENTSUM", paymentsum);
        return "/processing/PayNumb";
    }

    @RequestMapping(value = {"/cancel/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String cancel(Model model, @PathVariable("customerid") Long customerid,
                         @PathVariable("soid") Long soid, Principal principal) {
        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (customerRepository.findOne(customerid) == null
                || !customerRepository.findOne(customerid).getUserId().equals(userid.toString())
                || soRepository.findOne(soid) == null
                || !soRepository.findOne(soid).getCustomer1().getUserId().equals(userid.toString())){
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }
        List<ProductItems> productItems = productItemsRepository.findAll();
        List<ProductItems> productItemsList = new ArrayList<>();
        for (ProductItems product : productItems){
            if (product.getOrdItem().getStatus().equals("Ordered") && soid.equals(product.getSoproduct1().getSo1().getSOId())){
                OrdItem item = product.getOrdItem();
                item.setStatus("Canceled");
                ordItemRepository.save(item);
            }
        }
        So so = soRepository.findOne(soid);
        so.setStatus("Canceled");
        so.setAttentionFlag("");
        return "redirect:/application/basket/" + customerid + "/" + soid;
    }

    @RequestMapping(value = {"/group/{group}"}, method = RequestMethod.GET)
    public String group(Model model, @PathVariable("group") Long groupid) {
        model.addAttribute("ITEM_LIST", itemGroupRepository.findByGroups1_GroupId(groupid));
        return "pages/list";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptySO(Model model, Principal principal) {
        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(userid.toString()));
        return "/pages/so";
    }

    @RequestMapping(value = {"/faq"}, method = RequestMethod.GET)
    public String createItemdiscount(Model model) {
        return "/services";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createItemdiscount(Model model, So so, Soproduct soproduct,
                                     @RequestParam("socustomer") String customer1) {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        Customer customer = customerRepository.findOne(Long.valueOf(customer1));
        so.setStatus("Open");
        so.setFinalMP(BigDecimal.ZERO);
        so.setFinalOTP(BigDecimal.ZERO);
        so.setDistributionChannel(customer.getAddress1().getCountry());
        so.setFinalMPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setFinalOTPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setDateCreated(dateFormat.format(date));
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
        return "redirect:/application/orderinfo";
    }

    @RequestMapping(value = {"/print/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String print(Model model,
                        @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                        Principal principal) throws Exception {
        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (customerRepository.findOne(customerid) == null
                || !customerRepository.findOne(customerid).getUserId().equals(userid.toString())
                || soRepository.findOne(soid) == null
                || !soRepository.findOne(soid).getCustomer1().getUserId().equals(userid.toString())){
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }

        So so = soRepository.findOne(soid);
        List<ProductItems> productItems = productItemsRepository.findByOrdItem_Location(so.getLocation().getLocationId());
        List<ProductItems> finalproducts = new ArrayList<>();
        Float CMP = 0f;
        Float OTP = 0f;
        Float FCMP = 0f;
        Float FOTP = 0f;
        for (ProductItems productItem : productItems){
            if (customerid.equals(productItem.getOrdItem().getOrderedBy()) || productItem.getOrdItem().getOrderedBy() == null
                    && productItem.getOrdItem().getStatus().equals("Wait")){
                CMP+=productItem.getMp();
                OTP+=productItem.getOtp();
                FCMP+=productItem.getMPWithTaxandDiscont();
                FOTP+=productItem.getOTPWithTaxandDiscont();
                finalproducts.add(productItem);
            } else if (customerid.equals(productItem.getOrdItem().getOrderedBy()) ||
                    productItem.getOrdItem().getOrderedBy() == null){
                CMP+=productItem.getMp();
                FCMP+=productItem.getMPWithTaxandDiscont();
                finalproducts.add(productItem);
            }
        }
        int i=0;
        for (ProductItems p : finalproducts){
            if (p.getOrdItem().getStatus().equals("Ordered")){
                i++;
            }
        }
        if (i == finalproducts.size() && i != 0){
            soRepository.findOne(soid).setStatus("Ordered");
        }
        model.addAttribute("PRODUCTITEMS_LIST", finalproducts);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("STATUS", soRepository.findOne(soid).getStatus());
        model.addAttribute("SOID", soid);
        model.addAttribute("USERID", userid);
        model.addAttribute("FCMP", FCMP);
        model.addAttribute("FOTP", FOTP);
        model.addAttribute("CMP", CMP);
        model.addAttribute("OTP", OTP);
        return "/pages/print";
    }
}
