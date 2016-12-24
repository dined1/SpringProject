package com.hellokoding.account.web;

import com.hellokoding.account.Models.Payment;
import com.hellokoding.account.Models.Paymentbill;
import com.hellokoding.account.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 03.12.2016.
 */
@Service
@EnableScheduling
public class PaymentProcessorService {

    @Autowired
    PaymentRepository paymentRepository;

    public Float paymentCount(Payment payment){
        Paymentbill paymentbill = payment.getPaymentbill1();
        if ("OneTimePay".equals(payment.getPaymenttype1().getTypeName())){
            return paymentbill.getCotp() - paymentbill.getCOTPDisc();
        } else if ("MultiTimePay".equals(payment.getPaymenttype1().getTypeName())){
            return paymentbill.getCmp() - paymentbill.getCMPDisc();
        } else if ("MixPay".equals(payment.getPaymenttype1().getTypeName())){

            return paymentbill.getCotp() - paymentbill.getCOTPDisc();
        }
        return null;
    }

    @Scheduled(cron = "0 0 12 * * *")
    public void paymentTimer(){
        List<Payment> payments = paymentRepository.findAll();
        for (Payment payment : payments){
            Date date = new Date();
            Date paymentDate = payment.getPaymentDate();
            Calendar cal = Calendar.getInstance();
            cal.setTime(paymentDate);
            cal.add(Calendar.DATE, 27);
            paymentDate = cal.getTime();
            if (paymentDate.after(date)){

            }
        }
    }
}
