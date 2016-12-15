package com.hellokoding.account.repository;

import com.hellokoding.account.Models.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Admin on 02.12.2016.
 */
public interface CustomerRepository extends JpaRepository<Customer, Long> {

}
