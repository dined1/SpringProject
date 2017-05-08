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
import java.math.BigInteger;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by dzni0816 on 20.04.2017.
 */

@RequestMapping(value = {"/adm/orderentry"})
@Controller
@Transactional
public class OrderEntryController {

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
    @Autowired
    private CustomerLocationRepository customerLocationRepository;
    @Autowired
    private RelatedLocationRepository relatedLocationRepository;

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
    public String createSalesOrder(Model model,
                                   @RequestParam("customer") String custom,
                                   @RequestParam("addresslist") String locationId,
                                   @RequestParam("country") String countryId) {
        Customer customer = customerRepository.findOne(Long.valueOf(custom));
        So so = soRepository.findByCustomer1_CustomerIdAndLocation_LocationId(customer.getCustomerId(), Long.valueOf(locationId));
        if (so != null){
            so.setDistributionChannel(countryId);
            soRepository.save(so);
            return "redirect:/adm/orderentry/basket/"+customer.getCustomerId()+"/"+so.getSOId();
        }
        createSalesOrder(Long.valueOf(locationId), customer);
        model.addAttribute("SO_LIST", soRepository.findAll());
        return "redirect:/adm/orderentry/"+customer.getCustomerId();
    }


    public So createSalesOrder(Long locationId, Customer customer){
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        So so = new So();
        Soproduct soproduct = new Soproduct();
        Location location = customerLocationRepository.findOne(locationId);
        so.setStatus("Open");
        so.setFinalMP(BigDecimal.ZERO);
        so.setFinalOTP(BigDecimal.ZERO);
        so.setDistributionChannel(customer.getAddress1().getCountry());
        so.setFinalMPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setFinalOTPwithTaxAndDiscount(BigDecimal.ZERO);
        so.setDateCreated(dateFormat.format(date));
        so.setLocation(location);
//        so.setDateModified(dateFormat.format(date));
        so.setCustomer1(customer);
        soRepository.save(so);
        StringBuilder s = new StringBuilder();
        for (int i = 0; i < 4-so.getSOId().toString().length(); i++)
            s.append('0');
        so.setSONumber(s + so.getSOId().toString());
        soRepository.save(so);
        soproduct.setSOPId(so.getSOId());
        soproduct.setSo1(so);
        soProductRepository.save(soproduct);
        List<Soproduct> soproductList = new ArrayList<>();
        soproductList.add(soproduct);
        so.setSoproducts1(soproductList);
        return so;
    }


    @RequestMapping(value = {"/basket/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyBasket(Model model,
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

        List<ProductItems> productItems = productItemsRepository.findAll();
        List<ProductItems> finalproducts = new ArrayList<>();
        Float CMP = 0f;
        Float OTP = 0f;
        Float FFCMP = 0f;
        Float FFOTP = 0f;
        for (ProductItems productItem : productItems){
            if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                    productItem.getSoproduct1().getSo1().getSOId().equals(soid)
                    && productItem.getOrdItem().getStatus().equals("Wait")){
                CMP+=productItem.getMp();
                OTP+=productItem.getOtp();
                FFCMP+=productItem.getMPWithTaxandDiscont();
                FFOTP+=productItem.getOTPWithTaxandDiscont();
                finalproducts.add(productItem);
            } else if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                    productItem.getSoproduct1().getSo1().getSOId().equals(soid)){
                CMP+=productItem.getMp();
                FFCMP+=productItem.getMPWithTaxandDiscont();
                finalproducts.add(productItem);
            }
        }
        int i=0;
        BigDecimal FCMP = new BigDecimal(Float.toString(FFCMP)).setScale(2, BigDecimal.ROUND_HALF_UP);
        BigDecimal FOTP = new BigDecimal(Float.toString(FFOTP)).setScale(2, BigDecimal.ROUND_HALF_UP);
        for (ProductItems p : finalproducts){
            if (p.getOrdItem().getStatus().equals("Ordered")){
                i++;
            }
        }
        if (i == finalproducts.size() && i != 0){
            soRepository.findOne(soid).setStatus("Ordered");
        }
        model.addAttribute("ALLCUSTOMERLIST", customerRepository.findAll());
        model.addAttribute("ALLLOCATIONS", customerLocationRepository.findByCustomer_CustomerId(customerid));
        model.addAttribute("ALLRELATEDLOCATIONS", relatedLocationRepository.findByParentLocation_Customer_CustomerId(customerid));
        model.addAttribute("PRODUCTITEMS_LIST", finalproducts);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("STATUS", soRepository.findOne(soid).getStatus());
        model.addAttribute("SOID", soid);
        model.addAttribute("SO", soRepository.findOne(soid));
        model.addAttribute("USERID", userid);
        model.addAttribute("FCMP", FCMP);
        model.addAttribute("FOTP", FOTP);
        model.addAttribute("CMP", CMP);
        model.addAttribute("OTP", OTP);
        return "/pages/basket";
    }

    @Transactional
    @RequestMapping(value = {"/catalog/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String emptyCatalog(Model model,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
        if (principal==null){
            return "redirect:/";
        }
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);

        So so = soRepository.findOne(soid);
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (customerRepository.findOne(customerid) == null
                || !customerRepository.findOne(customerid).getUserId().equals(userid.toString())
                || soRepository.findOne(soid) == null
                || !soRepository.findOne(soid).getCustomer1().getUserId().equals(userid.toString())){
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }
        if ("Canceled".equals(so.getStatus())){
            return "error";
        }

        List<ItemLocations> items = itemLocationRepository.findByLocation_Locationname(so.getDistributionChannel());
        model.addAttribute("CHARACTERISTICS", itemCharacteristicRepository.findAll());
        model.addAttribute("GROUP_LIST", groupRepository.findAll());
        model.addAttribute("ITEM_LIST", items);
        return "/pages/catalog";
    }

    @RequestMapping(value = {"/itemdescription/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String itemDescription(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                                  @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                  Principal principal) {
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
                                        Principal principal) throws Exception {
        if (principal==null){
            return "redirect:/";
        }
        if (soRepository.findOne(soid) == null || soRepository.findByCustomer1_CustomerId(customerid).isEmpty()
                || soRepository.findByCustomer1_UserId(userRepository.findByUsername(principal.getName()).getId().toString()).isEmpty()){
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }
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
        if (principal==null){
            return "redirect:/";
        }
        List<ProductItems> productItems = productItemsRepository.findAll();
        List<ProductItems> finalproducts = new ArrayList<>();
        So so = soRepository.findOne(soid);
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        if (customerRepository.findOne(customerid) == null
                || !customerRepository.findOne(customerid).getUserId().equals(userid.toString())
                || soRepository.findOne(soid) == null
                || !soRepository.findOne(soid).getCustomer1().getUserId().equals(userid.toString())){
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }

        Float FFCMP = 0f;
        Float FFOTP = 0f;
        for (ProductItems productItem : productItems){
            try {
                if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                        productItem.getSoproduct1().getSo1().getSOId().equals(soid)
                        && productItem.getOrdItem().getStatus().equals("Wait")){
                    FFCMP+=productItem.getMPWithTaxandDiscont();
                    FFOTP+=productItem.getOTPWithTaxandDiscont();
                    finalproducts.add(productItem);
                } else if (productItem.getSoproduct1().getSo1().getCustomer1().getCustomerId().equals(customerid) &&
                        productItem.getSoproduct1().getSo1().getSOId().equals(soid)){
                    Date date = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    Date itemDate = formatter.parse(productItem.getOrdItem().getModifiedDate());
                    Calendar calI = Calendar.getInstance();
                    calI.setTime(itemDate);
                    calI.add(Calendar.DATE, 27);
                    itemDate = calI.getTime();
                    long leftI = Math.abs(date.getTime() - itemDate.getTime());
                    long daysI = leftI / (24 * 60 * 60 * 1000);
                    if (itemDate.before(date) && daysI >= 0) {
                        FFCMP += productItem.getMPWithTaxandDiscont();
                        finalproducts.add(productItem);
                    }
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        BigDecimal FCMP = new BigDecimal(Float.toString(FFCMP)).setScale(2, BigDecimal.ROUND_HALF_UP);
        BigDecimal FOTP = new BigDecimal(Float.toString(FFOTP)).setScale(2, BigDecimal.ROUND_HALF_UP);
        model.addAttribute("ITEM_LIST", finalproducts);
        model.addAttribute("SO_FINAL", soRepository.findOne(soid));
        model.addAttribute("FCMP", FCMP);
        model.addAttribute("FOTP", FOTP);
        model.addAttribute("CUSTOMERID", customerid);
        model.addAttribute("SOID", soid);
        return "/pages/order";
    }


    private void copyItemToOrderItem(Item item, OrdItem ordItem){
        List<OrdItemCharacteristic> ordItemCharacteristic = new ArrayList<>();
        List<OrdItemDiscount> ordItemDiscount = new ArrayList<>();
        ordItem.setDefMP(item.getDefMP());
        ordItem.setDefOTP(item.getDefOTP());
        ordItem.setDescription(item.getDescription());
//        ordItem.setModifiedDate(item.getModifiedDate());
        ordItem.setName(item.getName());
        ordItem.setType(item.getType());
        ordItem.setItemCharacteristic(ordItemCharacteristic);
        ordItem.setItemdiscounts1(ordItemDiscount);
        ordItem.setParentId(item.getItemId());
        ordItem.setStatus("Wait");
        while (item.getItems() != null && !item.getItems().isEmpty()){
            for (Item item1 : item.getItems()){
                item = item1;
                OrdItem ordItem1 = new OrdItem();
                copyItemToOrderItem(item, ordItem1);
                ordItem1.setParent(ordItem);
                ordItem.getOrdItems().add(ordItem1);
            }
        }
    }


    @RequestMapping(value = {"/add/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String addBasket(Model model, HttpServletRequest request,
                            ProductItems productItems, @PathVariable("itemid") Long itemid,
                            @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                            Principal principal) {
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
        addOnTarget(productItems, itemid, so, request);
        priceRecountSO(customerid, soid);
        return "redirect:/adm/orderentry/basket/" + customerid + "/" + soid;
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
        soRepository.findOne(soid).setFinalMP(BigDecimal.valueOf(CMP).setScale(2, BigDecimal.ROUND_HALF_UP));
        soRepository.findOne(soid).setFinalOTP(BigDecimal.valueOf(OTP).setScale(2, BigDecimal.ROUND_HALF_UP));
        soRepository.findOne(soid).setFinalMPwithTaxAndDiscount(BigDecimal.valueOf(CMPTD).setScale(2, BigDecimal.ROUND_HALF_UP));
        soRepository.findOne(soid).setFinalOTPwithTaxAndDiscount(BigDecimal.valueOf(OTPTD).setScale(2, BigDecimal.ROUND_HALF_UP));
    }

    @RequestMapping(value = {"/remove/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String removeBasket(Model model, @PathVariable("itemid") Long itemid,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
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
        deleteOnSource(itemid, customerid, soid);
        return "redirect:/adm/orderentry/basket/" + customerid + "/" + soid;
    }

    private void deleteOnSource(Long itemid, Long customerid, Long soid){
        Long parent = ordItemRepository.findOne(itemid).getParentId();
        Item root = itemRepository.findOne(parent);
        if (root != null){
            itemRepository.findOne(parent).setQuantity(root.getQuantity().add(BigInteger.ONE));
        }
        ordItemRepository.delete(itemid);
        priceRecountSO(customerid, soid);
    }

    private void addOnTarget(ProductItems productItems, Long itemid,
                             So so, HttpServletRequest request){
        if (so.getStatus().equals("Ordered") || so.getStatus().equals("Open")){
            so.setStatus("Wait");
        }
        Soproduct soproduct = so.getSoproducts1().get(0);
        productItems.setSoproduct1(soproduct);
        Item item = itemRepository.findOne(itemid);
        OrdItem ordItem = new OrdItem();
        copyItemToOrderItem(item, ordItem);
        ordItemRepository.save(ordItem);
        String[] characs = request.getParameterValues("characteristics");
        if (characs!=null) {
            for (String charac : characs) {
                OrdItemCharacteristic ordItemChar = new OrdItemCharacteristic();
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
        OrdItemDiscount ordDisc = new OrdItemDiscount();
        for (Itemdiscount itemdisc : itemdiscountRepository.findByItem1_ItemId(ordItem.getParentId())) {
            if (itemdisc.getDiscountrule1().getType().equals("tax")) {
                ordDisc.setOrdItem(ordItem);
                ordDisc.setDiscountrule1(itemdisc.getDiscountrule1());
                ordItemdiscountRepository.save(ordDisc);
            }
        }
        Float mp = ordItem.getDefMP();
        Float otp = ordItem.getDefOTP();
        List<OrdItemDiscount> itemdisc = ordItemdiscountRepository.findAll();
        List<OrdItemDiscount> basketItemdisc = new ArrayList<>();
        for (OrdItemDiscount id : itemdisc){
            if (ordItem.getOrditemId().equals(id.getOrdItem().getOrditemId())) {
                basketItemdisc.add(id);
            }
        }
        for (OrdItemDiscount discount : basketItemdisc) {
            if (discount.getDiscountrule1().getType().equals("disc") && discount.getDiscountrule1().getDiscountValue() != null){
                otp -= discount.getDiscountrule1().getDiscountValue();
//                mp -= discount.getDiscountrule1().getDiscountValue();
            }
            if (discount.getDiscountrule1().getType().equals("disc") && discount.getDiscountrule1().getDiscountProcent() != null){
                otp -= otp*discount.getDiscountrule1().getDiscountProcent()/100.0f;
//                mp -= mp*discount.getDiscountrule1().getDiscountProcent()/100.0f;
            }
        }
        List<Itemdiscount> itemdiscounts = itemdiscountRepository.findByItem1_ItemId(itemid);
        for (Itemdiscount discount : itemdiscounts) {
            if (discount.getDiscountrule1().getType().equals("tax") && discount.getDiscountrule1().getDiscountProcent() != null){
                otp += otp*discount.getDiscountrule1().getDiscountProcent()/100.0f;
            }
            if (discount.getDiscountrule1().getType().equals("tax") && discount.getDiscountrule1().getDiscountValue() != null){
                otp += discount.getDiscountrule1().getDiscountValue();
            }
        }
        if (otp < 0){
            otp = 0.01f;
        }
        if (mp < 0){
            mp = 0.01f;
        }
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        so.setDateModified(dateFormat.format(date));
        soRepository.save(so);
        itemRepository.findOne(itemid).setQuantity(item.getQuantity().subtract(BigInteger.ONE));
        productItems.setOrdItem(ordItem);
        productItems.setOTPWithTaxandDiscont(Float.valueOf(String.valueOf(BigDecimal.valueOf(otp).setScale(2, BigDecimal.ROUND_HALF_UP))));
        productItems.setMPWithTaxandDiscont(Float.valueOf(String.valueOf(BigDecimal.valueOf(mp).setScale(2, BigDecimal.ROUND_HALF_UP))));
        productItems.setOtp(Float.valueOf(String.valueOf(BigDecimal.valueOf(item.getDefOTP()).setScale(2, BigDecimal.ROUND_HALF_UP))));
        productItems.setMp(Float.valueOf(String.valueOf(BigDecimal.valueOf(item.getDefMP()).setScale(2, BigDecimal.ROUND_HALF_UP))));
        productItemsRepository.save(productItems);
    }

    @RequestMapping(value = {"/disconnect/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String disconnectItem(Model model, @PathVariable("itemid") Long itemid,
                               @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                               Principal principal) {
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
        deleteOnSource(itemid, customerid, soid);
        return "redirect:/adm/orderentry/basket/" + customerid + "/" + soid;
    }


    @RequestMapping(value = {"/customerlocations/{customerid}"}, method = RequestMethod.GET)
    public String customerLocations(Model model, @PathVariable("customerid") Long customerid,
                                 Principal principal) {
        if (principal==null){
            return "redirect:/";
        }
        Long userid = userRepository.findByUsername(principal.getName()).getId();
        Customer customer = customerRepository.findOne(customerid);
        if (customer == null
                || !customer.getUserId().equals(userid.toString())) {
            model.addAttribute("message", "You cannot process this order");
            return "error";
        }

        model.addAttribute("CUSTOMER", customer);
        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        model.addAttribute("LOCATIONSLIST", customerLocationRepository.findByCustomer_CustomerId(customerid));
        model.addAttribute("RELATEDLOCATIONSLIST", relatedLocationRepository.findByParentLocation_Customer_CustomerId(customerid));
        return "admin";
    }

    @RequestMapping(value = {"/customerlocations"}, method = RequestMethod.POST)
    public String locreate(Model model, @RequestParam("customer") String customerid,
                           @RequestParam("addresslist") String locationId,
                           @RequestParam("name") String name, Principal principal) {
        if (principal==null){
            return "redirect:/";
        }

        Location location = new Location();
        Address address = addressRepository.findOne(Long.valueOf(locationId));
        Customer customer = customerRepository.findOne(Long.valueOf(customerid));
        location.setAddress(address);
        location.setCustomer(customer);
        location.setName(name);
        customerLocationRepository.save(location);

        model.addAttribute("ADDRESS_LIST", addressRepository.findAll());
        model.addAttribute("LOCATIONSLIST", customerLocationRepository.findByCustomer_CustomerId(Long.valueOf(customerid)));
        model.addAttribute("RELATEDLOCATIONSLIST", relatedLocationRepository.findByParentLocation_Customer_CustomerId(Long.valueOf(customerid)));
        return "redirect:/adm/orderentry/customerlocations/"+customerid;
    }


    @RequestMapping(value = {"/changeownership/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String changeOwnershipOrdItem(Model model, @PathVariable("itemid") Long itemid, HttpServletRequest request,
                                 @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                 @RequestParam("targetcustomer") String targetCustomerId,
                                 Principal principal) {
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
        ProductItems productItems = new ProductItems();
        Customer customer = customerRepository.findOne(customerid);
        So so = soRepository.findByCustomer1_CustomerIdAndLocation_LocationId(Long.valueOf(targetCustomerId), customer.getAddress1().getAddressId());
        if (so == null){
            Customer targetCustomer = customerRepository.findOne(Long.valueOf(targetCustomerId));
            so = createSalesOrder(customer.getAddress1().getAddressId(), targetCustomer);
        }
        Long rootId = ordItemRepository.findOne(itemid).getParentId();
        deleteOnSource(itemid, customerid, soid);
        addOnTarget(productItems, rootId, so, request);
        priceRecountSO(so.getCustomer1().getCustomerId(), so.getSOId());
        return "redirect:/adm/orderentry/basket/" + customerid + "/" + soid;
    }

    @RequestMapping(value = {"/relocate/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    public String relocateOrdItem(Model model, @PathVariable("itemid") Long itemid, HttpServletRequest request,
                                         @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                         @RequestParam("targetlocation") String targetLocationId,
                                         Principal principal) {
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
        ProductItems productItems = new ProductItems();
        Customer customer = customerRepository.findOne(customerid);
        So so = soRepository.findByCustomer1_CustomerIdAndLocation_LocationId(customerid, Long.valueOf(targetLocationId));
        if (so == null){
            createSalesOrder(Long.valueOf(targetLocationId), customer);
            so = soRepository.findByCustomer1_CustomerIdAndLocation_LocationId(customerid, Long.valueOf(targetLocationId));
        }
        Long rootId = ordItemRepository.findOne(itemid).getParentId();
        deleteOnSource(itemid, customerid, soid);
        addOnTarget(productItems, rootId, so, request);
        priceRecountSO(so.getCustomer1().getCustomerId(), so.getSOId());
        return "redirect:/adm/orderentry/basket/" + customerid + "/" + soid;
    }
}
