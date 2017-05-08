package com.hellokoding.account.Models;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Admin on 07.05.2017.
 */
@Entity
@Table(name = "location")
@Transactional
public class Location {

    @Column(name = "locationId", table = "location", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long locationId;

    @Column(name = "name", table = "location")
    @Basic
    private String name;

    @ManyToOne(targetEntity = Customer.class)
    private Customer customer;

    @ManyToOne(targetEntity = Address.class)
    private Address address;

    @OneToMany(targetEntity = RelatedLocation.class, mappedBy = "parentLocation", cascade = CascadeType.REMOVE)
    private List<RelatedLocation> relatedLocations;

    @OneToMany(targetEntity = So.class, mappedBy = "location", cascade = CascadeType.REMOVE)
    private List<So> so;

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<RelatedLocation> getRelatedLocations() {
        return relatedLocations;
    }

    public void setRelatedLocations(List<RelatedLocation> relatedLocations) {
        this.relatedLocations = relatedLocations;
    }

    public List<So> getSo() {
        return so;
    }

    public void setSo(List<So> so) {
        this.so = so;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}
