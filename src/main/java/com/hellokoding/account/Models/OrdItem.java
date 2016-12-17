package com.hellokoding.account.Models;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Admin on 17.12.2016.
 */
@Entity
@Table(name = "orditem")
@Transactional
public class OrdItem implements Serializable {

    @Column(name = "OrdItemId", table = "orditem", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long orditemId;

    @Column(name = "Name", table = "orditem")
    @Basic
    private String name;

    @Column(name = "Type", table = "orditem")
    @Basic
    private String type;

    @Column(name = "Description", table = "orditem")
    @Basic
    private String description;

    @Column(name = "DefMP", table = "orditem", precision = 12)
    @Basic
    private Float defMP;

    @Column(name = "DefOTP", table = "orditem", precision = 12)
    @Basic
    private Float defOTP;

    @Column(name = "ModifiedDate", table = "orditem")
    @Basic
    private String modifiedDate;

    @Column(name = "locationDistribute", table = "orditem")
    @Basic
    private String locationDistribute;

//    @OneToMany(targetEntity = ProductItems.class, mappedBy = "item1")
//    private List<ProductItems> productItemses1;
//
//    @OneToMany(targetEntity = Itemgroup.class, mappedBy = "item1")
//    private List<Itemgroup> itemgroups1;
//
    @OneToMany(targetEntity = OrdItemDiscount.class, mappedBy = "OrdItem")
    private List<OrdItemDiscount> itemdiscounts1;

    @OneToMany(targetEntity = OrdItemCharacteristic.class, mappedBy = "OrdItem")
    private List<OrdItemCharacteristic> itemCharacteristic;

    public Long getOrditemId() {
        return orditemId;
    }

    public void setOrditemId(Long orditemId) {
        this.orditemId = orditemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Float getDefMP() {
        return defMP;
    }

    public void setDefMP(Float defMP) {
        this.defMP = defMP;
    }

    public Float getDefOTP() {
        return defOTP;
    }

    public void setDefOTP(Float defOTP) {
        this.defOTP = defOTP;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(String modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getLocationDistribute() {
        return locationDistribute;
    }

    public void setLocationDistribute(String locationDistribute) {
        this.locationDistribute = locationDistribute;
    }
}
