package com.hellokoding.account.repository;

import com.hellokoding.account.Models.Location;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Admin on 08.05.2017.
 */
public interface CustomerLocationRepository extends JpaRepository<Location, Long> {
    List<Location> findByCustomer_CustomerId(Long customerId);

    List<Location> findByAddress_AddressId(Long addressId);
}
