package com.hellokoding.account.repository;

import com.hellokoding.account.Models.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Admin on 02.12.2016.
 */
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    Payment findBySo1_Customer1_UserId(String userid);
}
