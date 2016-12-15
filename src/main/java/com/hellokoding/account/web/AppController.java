package com.hellokoding.account.web;

import com.hellokoding.account.Models.*;
import com.hellokoding.account.model.User;
import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

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

    @RequestMapping(value = {"/basket"}, method = RequestMethod.GET)
    public String basket(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        List<ProductItems> productItems = productItemsRepository.findAll();
        List<ProductItems> finalproducts = new ArrayList<>();
        Float CMP = 0f;
        Float OTP = 0f;
        So so = soRepository.findByStatusAndCustomer1_UserId("Wait", userid.toString()).get(0);
//        for (ProductItems productItem : productItems){
//            if (productItem.getSoproduct1().getSo1().getCustomer1().getUserId().equals(userid.toString()) && productItem.getSoproduct1().getSo1().getStatus().equals("Wait")){
//                CMP+=productItem.getMp();
//                OTP+=productItem.getOtp();
//                finalproducts.add(productItem);
//            }
//        }
        List<ProductItems> pm = so.getSoproducts1().get(0).getProductItemses1();
        for (ProductItems productItems1 : pm){
                CMP+=productItems1.getMp();
                OTP+=productItems1.getOtp();
        }
        model.addAttribute("PRODUCTITEMS_LIST", pm);
        model.addAttribute("ID", userid);

        model.addAttribute("CMP", CMP);
        model.addAttribute("OTP", OTP);
        return "/pages/basket";
    }

    @RequestMapping(value = {"/basket/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyBasket(Model model,
                              @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                              Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (!customerRepository.findOne(customerid).getUserId().equals(userid.toString())){
            return "";
        }
        List<ProductItems> productItems = productItemsRepository.findAll();
        List<ProductItems> finalproducts = new ArrayList<>();
        Float CMP = 0f;
        Float OTP = 0f;
        for (ProductItems productItem : productItems){
            if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                    productItem.getSoproduct1().getSo1().getSOId().equals(soid)){
                CMP+=productItem.getMp();
                OTP+=productItem.getOtp();
                finalproducts.add(productItem);
            }
        }
        model.addAttribute("PRODUCTITEMS_LIST", finalproducts);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        model.addAttribute("USERID", userid);

        model.addAttribute("CMP", CMP);
        model.addAttribute("OTP", OTP);
//        List<ProductItems> productItems = productItemsRepository.findAll();
//        List<ProductItems> finalproducts = new ArrayList<>();
//        Float CMP = 0f;
//        Float OTP = 0f;
//
//        for (ProductItems productItem : productItems){
//            if (productItem.getSoproduct1().getSo1().getCustomer1().getUserId().equals(id.toString()) && productItem.getSoproduct1().getSo1().getStatus().equals("Wait")){
//                CMP+=productItem.getMp();
//                OTP+=productItem.getOtp();
//                finalproducts.add(productItem);
//            }
//        }
//        model.addAttribute("PRODUCTITEMS_LIST", finalproducts);
//        model.addAttribute("ID", id);
//
//        model.addAttribute("CMP", CMP);
//        model.addAttribute("OTP", OTP);
        return "/pages/basket";
    }

    @RequestMapping(value = {"/catalog/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyCatalog(Model model,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        return "/pages/catalog";
    }

    @RequestMapping(value = {"/order"}, method = RequestMethod.GET)
    public String emptyOrder(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        model.addAttribute("ID", id);
        return "/pages/order";
    }

    @RequestMapping(value = {"/orderinfo"}, method = RequestMethod.GET)
    public String emptyOrderInfo(Model model, Principal principal) {
        User u = userRepository.findByUsername(principal.getName());
        model.addAttribute("SO_LIST", soRepository.findAll());
        model.addAttribute("USER_ID", u.getId());
        return "/pages/orderinfo";
    }

    @RequestMapping(value = {"/add/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String addBasket(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                            @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                            Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (!customerRepository.findOne(customerid).getUserId().equals(userid.toString())){
            return "";
        }
        So so = soRepository.findOne(soid);

        Soproduct soproduct = so.getSoproducts1().get(0);
        productItems.setSoproduct1(soproduct);
        Item item = itemRepository.findOne(itemid);
        productItems.setItem1(item);
        productItems.setOtp(item.getDefOTP());
        productItems.setMp(item.getDefMP());
        productItemsRepository.save(productItems);
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        model.addAttribute("USERID", userid);
        return "redirect:/application/basket/" + customerid + "/" + soid;
    }

    @RequestMapping(value = {"/add"}, method = RequestMethod.POST)
    public String addBasd(Model model, ProductItems productItems) {
        /*Soproduct soproduct = soProductRepository.findOne(Long.valueOf(c));
        productItems.setSoproduct1(soproduct);
        Item item = itemRepository.findOne(Long.valueOf(id));
        productItems.setItem1(item);
        productItemsRepository.save(productItems);
        model.addAttribute("PRODUCTITEMS_LIST", productItemsRepository.findAll());
        model.addAttribute("ID", c);*/
        return "/pages/basket";
    }

    @RequestMapping(value = {"/remove/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String removeBasket(Model model, @PathVariable("itemid") Long itemid,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (!customerRepository.findOne(customerid).getUserId().equals(userid.toString())){
            return "";
        }
        productItemsRepository.delete(productItemsRepository.findOne(itemid));
        return "redirect:/application/basket/" + customerid + "/" + soid;
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptySO(Model model) {
        model.addAttribute("CUSTOMER_LIST", customerRepository.findAll());
        return "/pages/so";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createItemdiscount(Model model, So so, Soproduct soproduct, @RequestParam("dateCreated1") String dateCreated1, @RequestParam("dateModified1") String dateModified1, @RequestParam("orderDate1") String orderDate1) {
        so.setDateCreated(dateCreated1);
        so.setDateModified(dateModified1);
        so.setOrderDate(orderDate1);
        so.setStatus("Wait");
        so.setSONumber("132342");
        so.setPurchaseOrderNumber("13232342");
        Customer customer = customerRepository.findOne(1l);
        so.setCustomer1(customer);
        soRepository.save(so);
        soproduct.setSOPId(so.getSOId());
        soproduct.setSo1(so);
        soProductRepository.save(soproduct);
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "/pages/orderinfo";
    }

}
