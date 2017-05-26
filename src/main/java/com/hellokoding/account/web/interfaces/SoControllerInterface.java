package com.hellokoding.account.web.interfaces;

import com.hellokoding.account.Models.So;
import com.hellokoding.account.Models.Soproduct;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import javax.ws.rs.BeanParam;

/**
 * Created by dzni0816 on 23.05.2017.
 */
public interface SoControllerInterface {
    @RequestMapping(value = {"/new"}, method = RequestMethod.GET)
    String emptySo(Model model);

    @RequestMapping(value = {"/new"}, method = RequestMethod.POST)
    String createSo(Model model, So so, Soproduct soproduct, @RequestParam("socustomer") String cust);

    @RequestMapping(value = {"/update/{id}"}, method = RequestMethod.GET)
    String editSo(Model model, @PathVariable("id") Long id);

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    String updateSo(@Valid
                    @BeanParam So so);

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.POST)
    String updateSo(@Valid
                    @BeanParam So so, BindingResult bindingResult);

    @RequestMapping(value = {"/remove/{id}"}, method = RequestMethod.GET)
    String removeSo(@PathVariable("id") Long id);

    @RequestMapping(value = {"/{id}"}, method = RequestMethod.GET)
    String findSo(Model model, @PathVariable("id") Long id);

    @RequestMapping(value = {"/pays/{id}"}, method = RequestMethod.GET)
    String pay(Model model, @PathVariable("id") Long id);
}
