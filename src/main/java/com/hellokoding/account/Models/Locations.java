package com.hellokoding.account.Models;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.List;

/**
 * Created by dzni0816 on 21.12.2016.
 */
@Entity
@Table(name = "locations")
@Transactional
public class Locations implements Serializable {

    @Column(name = "locationId", table = "locations", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long locationId;

    @Column(name = "locationname", table = "locations")
    @Basic
    private String locationname;

    @OneToMany(targetEntity = ItemLocations.class, mappedBy = "location")
    private List<ItemLocations> itemlocations;

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public String getLocationname() {
        return locationname;
    }

    public void setLocationname(String locationname) {
        this.locationname = locationname;
    }

    public List<ItemLocations> getItemlocations() {
        return itemlocations;
    }

    public void setItemlocations(List<ItemLocations> itemlocations) {
        this.itemlocations = itemlocations;
    }
}
