package com.hellokoding.account.web;

import com.hellokoding.account.Models.Card;
import com.hellokoding.account.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import java.security.Principal;

/**
 * Created by alex on 27.12.2016.
 */
@RequestMapping(value = {"/processing/PayPage"})
@Controller
public class CardController {

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
}
