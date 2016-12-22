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
import java.math.BigDecimal;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
    private OrdItemRepository ordItemRepository;
    @Autowired
    private OrdItemCharacteristicsRepository ordItemCharacteristicsRepository;
    @Autowired
    private OrdItemdiscountRepository ordItemdiscountRepository;
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
    private CharacteristicsRepository characteristicsRepository;
    @Autowired
    private ItemCharacteristicRepository itemCharacteristicRepository;
    @Autowired
    private ItemLocationRepository itemLocationRepository;


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
        return "/pages/basket";
    }



    @Transactional
    @RequestMapping(value = {"/catalog/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyCatalog(Model model,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        So so = soRepository.findOne(soid);
        if (so == null){
            return "";
        }
        List<ItemLocations> items = itemLocationRepository.findByLocation_Locationname(so.getLocation());
        model.addAttribute("CHARACTERISTICS", itemCharacteristicRepository.findAll());
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        model.addAttribute("ITEM_LIST", items);
        return "/pages/catalog";
    }

    @RequestMapping(value = {"/itemdescription/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String itemDescription(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                                  @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                  Principal principal) {
        Item item = itemRepository.findOne(itemid);
        model.addAttribute("ITEM", item);

        model.addAttribute("ITEMCHARACTERISTICS", itemCharacteristicRepository.findByItem_ItemId(itemid));
        model.addAttribute("ITEMDISCOUNTS", itemdiscountRepository.findByItem1_ItemId(itemid));

        model.addAttribute("ITEMID", itemid);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        return "/pages/itemDesc";
    }

    @RequestMapping(value = {"/itembasket/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String itemBasketDescription(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                                  @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                  Principal principal) {
        OrdItem item = ordItemRepository.findOne(itemid);
        model.addAttribute("ITEM", item);
        List<OrdItemCharacteristic> itemchar = ordItemCharacteristicsRepository.findAll();
        List<OrdItemCharacteristic> basketItemchar = new ArrayList<>();
        for (OrdItemCharacteristic ic : itemchar){
            if (itemid.equals(ic.getOrdItem().getOrditemId())) {
                basketItemchar.add(ic);
            }
        }
        List<OrdItemDiscount> itemdisc = ordItemdiscountRepository.findAll();
        List<OrdItemDiscount> basketItemdisc = new ArrayList<>();
        for (OrdItemDiscount id : itemdisc){
            if (itemid.equals(id.getOrdItem().getOrditemId())) {
                basketItemdisc.add(id);
            }
        }
        model.addAttribute("ITEMCHARACTERISTICS", basketItemchar);
        model.addAttribute("ITEMDISCOUNTS", basketItemdisc);

        model.addAttribute("ITEMID", itemid);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        return "/pages/itemBasketDesc";
    }

    @RequestMapping(value = {"/order/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyOrder(Model model, @PathVariable("customerid") Long customerid,
                             @PathVariable("soid") Long soid,
                             Principal principal) {
        model.addAttribute("ITEM_LIST", itemRepository.findAll());
        model.addAttribute("SO_FINAL", soRepository.findOne(soid));
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        return "/pages/order";
    }

    @RequestMapping(value = {"/orderinfo"}, method = RequestMethod.GET)
    public String emptyOrderInfo(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();

        model.addAttribute("SO_LIST", soRepository.findByCustomer1_UserId(userid.toString()));
        model.addAttribute("USER_ID", userid);
        return "/pages/orderinfo";
    }

    @RequestMapping(value = {"/add/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String addBasket(Model model, HttpServletRequest request, ItemCharacteristic itemCharacteristic, Itemdiscount itemdiscount,
                            ProductItems productItems, @PathVariable("itemid") Long itemid,
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
        OrdItem ordItem = new OrdItem();
        List<OrdItemCharacteristic> ordItemCharacteristic = new ArrayList<>();
        List<OrdItemDiscount> ordItemDiscount = new ArrayList<>();

        ordItem.setDefMP(item.getDefMP());
        ordItem.setDefOTP(item.getDefOTP());
        ordItem.setDescription(item.getDescription());
        ordItem.setModifiedDate(item.getModifiedDate());
        ordItem.setName(item.getName());
        ordItem.setType(item.getType());
        ordItem.setItemCharacteristic(ordItemCharacteristic);
        ordItem.setItemdiscounts1(ordItemDiscount);
        ordItemRepository.save(ordItem);
        String[] characs = request.getParameterValues("characteristics");
        if (characs!=null) {
            OrdItemCharacteristic ordItemChar = new OrdItemCharacteristic();
            for (String charac : characs) {
                ordItemChar.setOrdItem(ordItem);
                ordItemChar.setItemCharacteristic(characteristicsRepository.findOne(Long.valueOf(charac)));
                ordItemCharacteristicsRepository.save(ordItemChar);
            }
        }
        String[] discounts = request.getParameterValues("discounts");
        if (discounts!=null) {
            OrdItemDiscount ordDisc = new OrdItemDiscount();
            for (String disc : discounts) {
                ordDisc.setOrdItem(ordItem);
                ordDisc.setDiscountrule1(discountruleRepository.findOne(Long.valueOf(disc)));
                ordItemdiscountRepository.save(ordDisc);
            }
        }
        Float mp = 0f;
        Float otp = 0f;
        List<Itemdiscount> itemdiscounts = itemdiscountRepository.findByItem1_ItemId(itemid);
        for (Itemdiscount discount : itemdiscounts) {
            if (discount.getDiscountrule1().getType().equals("tax") && discount.getDiscountrule1().getDiscountValue() != null){
                otp += discount.getDiscountrule1().getDiscountValue();
            } else if (discount.getDiscountrule1().getType().equals("disc") && discount.getDiscountrule1().getDiscountValue() != null){
                mp -= discount.getDiscountrule1().getDiscountValue();
            }
        }
        productItems.setOrdItem(ordItem);
        productItems.setOTPWithTaxandDiscont(item.getDefOTP() + otp);
        productItems.setMPWithTaxandDiscont(item.getDefMP() + mp);
        productItems.setOtp(item.getDefOTP());
        productItems.setMp(item.getDefMP());
        productItemsRepository.save(productItems);
        priceRecountSO(customerid, soid);
        return "redirect:/application/basket/" + customerid + "/" + soid;
    }

    private void priceRecountSO(Long customerid, Long soid){
        List<ProductItems> productItems = productItemsRepository.findAll();
        Float CMP = 0f, CMPTD = 0f;
        Float OTP = 0f, OTPTD = 0f;
        for (ProductItems productItem : productItems){
            if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                    productItem.getSoproduct1().getSo1().getSOId().equals(soid)){
                CMP+=productItem.getMp();
                OTP+=productItem.getOtp();
                CMPTD+=productItem.getMPWithTaxandDiscont();
                OTPTD+=productItem.getOTPWithTaxandDiscont();
            }
        }
        soRepository.findOne(soid).setFinalMP(BigDecimal.valueOf(CMP));
        soRepository.findOne(soid).setFinalOTP(BigDecimal.valueOf(OTP));
        soRepository.findOne(soid).setFinalMPwithTaxAndDiscount(BigDecimal.valueOf(CMPTD));
        soRepository.findOne(soid).setFinalOTPwithTaxAndDiscount(BigDecimal.valueOf(OTPTD));
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
        ordItemRepository.delete(itemid);
        return "redirect:/application/basket/" + customerid + "/" + soid;
    }

    /*@RequestMapping(value = {"/remove/{soid}"}, method = RequestMethod.GET)
    public String remove(Model model, @PathVariable("soid") Long soid,
                               Principal principal) {
        soRepository.delete(soid);
        return "redirect:/application/orderinfo";
    }*/

    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    public String emptySO(Model model, Principal principal) {
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        model.addAttribute("CUSTOMER_LIST", customerRepository.findByUserId(userid.toString()));
        return "/pages/so";
    }

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    public String createItemdiscount(Model model, So so, Soproduct soproduct,
                                     @RequestParam("socustomer") String customer1) {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date date = new Date();
        Customer customer = customerRepository.findOne(Long.valueOf(customer1));
        so.setStatus("Wait");
        so.setFinalMP(BigDecimal.ZERO);
        so.setFinalOTP(BigDecimal.ZERO);
        so.setLocation(customer.getLocation());
        so.setFinalMPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setFinalOTPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setDateCreated(dateFormat.format(date));
        so.setCustomer1(customer);
        soRepository.save(so);
        soproduct.setSOPId(so.getSOId());
        soproduct.setSo1(so);
        soProductRepository.save(soproduct);
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "/pages/orderinfo";
    }



}
