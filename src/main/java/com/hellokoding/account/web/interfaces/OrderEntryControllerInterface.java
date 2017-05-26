package com.hellokoding.account.web.interfaces;

import com.hellokoding.account.Models.Customer;
import com.hellokoding.account.Models.ProductItems;
import com.hellokoding.account.Models.So;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

/**
 * Created by dzni0816 on 23.05.2017.
 */
public interface OrderEntryControllerInterface {
    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    String orderEntry(Model model, Principal principal);

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    String createSalesOrder(Model model,
                            @RequestParam("customer") String custom,
                            @RequestParam("addresslist") String locationId,
                            @RequestParam("country") String countryId);

    So createSalesOrder(Long locationId, Customer customer);

    @RequestMapping(value = {"/basket/{customerid}/{soid}"}, method = RequestMethod.GET)
    String emptyBasket(Model model,
                       @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                       Principal principal) throws Exception;

    @Transactional
    @RequestMapping(value = {"/catalog/{customerid}/{soid}"}, method = RequestMethod.GET)
    String emptyCatalog(Model model,
                        @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                        Principal principal);

    @RequestMapping(value = {"/itemdescription/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    String itemDescription(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                           @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                           Principal principal);

    @RequestMapping(value = {"/itembasket/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    String itemBasketDescription(Model model, ProductItems productItems, @PathVariable("itemid") Long itemid,
                                 @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                                 Principal principal) throws Exception;

    @RequestMapping(value = {"/order/{customerid}/{soid}"}, method = RequestMethod.GET)
    String emptyOrder(Model model, @PathVariable("customerid") Long customerid,
                      @PathVariable("soid") Long soid,
                      Principal principal);

    @RequestMapping(value = {"/add/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    String addBasket(Model model, HttpServletRequest request,
                     ProductItems productItems, @PathVariable("itemid") Long itemid,
                     @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                     Principal principal);

    @RequestMapping(value = {"/remove/{itemid}/{customerid}/{soid}"}, method = RequestMethod.GET)
    String removeBasket(Model model, @PathVariable("itemid") Long itemid,
                        @PathVariable("customerid") Long customerid, @PathVariable("soid") Long soid,
                        Principal principal);
}
