package com.hellokoding.account.repository;

import com.hellokoding.account.Models.RelatedLocation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Admin on 08.05.2017.
 */
public interface RelatedLocationRepository extends JpaRepository<RelatedLocation, Long> {
    List<RelatedLocation> findByCustomer_CustomerId(Long customerId);

    List<RelatedLocation> findByParentLocation_Customer_CustomerId(Long customerId);
}
