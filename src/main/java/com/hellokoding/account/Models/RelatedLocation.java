package com.hellokoding.account.Models;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Admin on 07.05.2017.
 */
@Entity
@Table(name = "relatedlocation")
@Transactional
public class RelatedLocation {

    @Column(name = "locationId", table = "relatedlocation", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long locationId;

    @Column(name = "name", table = "relatedlocation")
    @Basic
    private String name;

    @ManyToOne(targetEntity = Location.class)
    private Location parentLocation;

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

    public Location getParentLocation() {
        return parentLocation;
    }

    public void setParentLocation(Location parentLocation) {
        this.parentLocation = parentLocation;
    }
}
