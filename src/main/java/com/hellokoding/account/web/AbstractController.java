package com.hellokoding.account.web;

import com.hellokoding.account.repository.AddressRepository;
import com.hellokoding.account.repository.CharacteristicsRepository;
import com.hellokoding.account.repository.CustomerLocationRepository;
import com.hellokoding.account.repository.CustomerRepository;
import com.hellokoding.account.repository.DiscountruleRepository;
import com.hellokoding.account.repository.GroupRepository;
import com.hellokoding.account.repository.ItemCharacteristicRepository;
import com.hellokoding.account.repository.ItemGroupRepository;
import com.hellokoding.account.repository.ItemLocationRepository;
import com.hellokoding.account.repository.ItemRepository;
import com.hellokoding.account.repository.ItemdiscountRepository;
import com.hellokoding.account.repository.OrdItemCharacteristicsRepository;
import com.hellokoding.account.repository.OrdItemRepository;
import com.hellokoding.account.repository.OrdItemdiscountRepository;
import com.hellokoding.account.repository.PaymentBillRepository;
import com.hellokoding.account.repository.PaymentRepository;
import com.hellokoding.account.repository.PaymentTypeRepository;
import com.hellokoding.account.repository.ProductItemsRepository;
import com.hellokoding.account.repository.RelatedLocationRepository;
import com.hellokoding.account.repository.SOProductRepository;
import com.hellokoding.account.repository.SORepository;
import com.hellokoding.account.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by dzni0816 on 23.05.2017.
 */
public class AbstractController {

    @Autowired
    protected CustomerRepository customerRepository;
    @Autowired
    protected DiscountruleRepository discountruleRepository;
    @Autowired
    protected AddressRepository addressRepository;
    @Autowired
    protected ItemRepository itemRepository;
    @Autowired
    protected ItemGroupRepository itemGroupRepository;
    @Autowired
    protected ItemdiscountRepository itemdiscountRepository;
    @Autowired
    protected GroupRepository groupRepository;
    @Autowired
    protected OrdItemRepository ordItemRepository;
    @Autowired
    protected OrdItemCharacteristicsRepository ordItemCharacteristicsRepository;
    @Autowired
    protected OrdItemdiscountRepository ordItemdiscountRepository;
    @Autowired
    protected ProductItemsRepository productItemsRepository;
    @Autowired
    protected PaymentRepository paymentFacade;
    @Autowired
    protected PaymentTypeRepository paymentTypeRepository;
    @Autowired
    protected SOProductRepository soProductRepository;
    @Autowired
    protected SORepository soRepository;
    @Autowired
    protected UserRepository userRepository;
    @Autowired
    protected CharacteristicsRepository characteristicsRepository;
    @Autowired
    protected ItemCharacteristicRepository itemCharacteristicRepository;
    @Autowired
    protected ItemLocationRepository itemLocationRepository;
    @Autowired
    protected CustomerLocationRepository customerLocationRepository;
    @Autowired
    protected RelatedLocationRepository relatedLocationRepository;
}
