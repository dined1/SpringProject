/**
 * This file was generated by the JPA Modeler
 */
package com.hellokoding.account.Models;

import org.hibernate.annotations.Proxy;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

/**
 * @author dzni0816
 */

@Entity
@Table(name = "item")
@Proxy(lazy = false)
@Transactional
public class Item implements Serializable {

    @Column(name = "ItemId", table = "item", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long itemId;

    @Column(name = "Name", table = "item")
    @Basic
    private String name;

    @Column(name = "Type", table = "item")
    @Basic
    private String type;

    @Column(name = "Description", table = "item")
    @Basic
    private String description;

    @Column(name = "DefMP", table = "item", precision = 12)
    @Basic
    private Float defMP;

    @Column(name = "DefOTP", table = "item", precision = 12)
    @Basic
    private Float defOTP;

    @Column(name = "ModifiedDate", table = "item")
    @Basic
    private String modifiedDate;

    @Column(name = "Quantity", table = "item")
    @Basic
    private BigInteger quantity;

    @ManyToOne(targetEntity = Item.class)
    private Item parent;

    @OneToMany(targetEntity = Item.class, mappedBy = "parent", cascade = {CascadeType.REMOVE, CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.EAGER)
    private List<Item> items = new ArrayList<>();

    @OneToMany(targetEntity = ItemLocations.class, mappedBy = "item", cascade = CascadeType.REMOVE)
    private List<ItemLocations> itemlocations;

//    @OneToMany(targetEntity = ProductItems.class, mappedBy = "item1")
//    private List<ProductItems> productItemses1;

    @OneToMany(targetEntity = Itemgroup.class, mappedBy = "item1", cascade = CascadeType.REMOVE)
    private List<Itemgroup> itemgroups1;

    @OneToMany(targetEntity = Itemdiscount.class, mappedBy = "item1", cascade = CascadeType.REMOVE)
    private List<Itemdiscount> itemdiscounts1;

    @OneToMany(targetEntity = ItemCharacteristic.class, mappedBy = "item", cascade = CascadeType.REMOVE)
    private List<ItemCharacteristic> itemCharacteristic;

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
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

    public List<Itemgroup> getItemgroups1() {
        return itemgroups1;
    }

    public void setItemgroups1(List<Itemgroup> itemgroups1) {
        this.itemgroups1 = itemgroups1;
    }

    public List<Itemdiscount> getItemdiscounts1() {
        return itemdiscounts1;
    }

    public void setItemdiscounts1(List<Itemdiscount> itemdiscounts1) {
        this.itemdiscounts1 = itemdiscounts1;
    }

    public List<ItemCharacteristic> getItemCharacteristic() {
        return itemCharacteristic;
    }

    public void setItemCharacteristic(List<ItemCharacteristic> itemCharacteristic) {
        this.itemCharacteristic = itemCharacteristic;
    }

    public List<ItemLocations> getItemlocations() {
        return itemlocations;
    }

    public void setItemlocations(List<ItemLocations> itemlocations) {
        this.itemlocations = itemlocations;
    }

    public BigInteger getQuantity() {
        return quantity;
    }

    public void setQuantity(BigInteger quantity) {
        this.quantity = quantity;
    }

    public Item getParent() {
        return parent;
    }

    public void setParent(Item parent) {
        this.parent = parent;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> parentId) {
        this.items = parentId;
    }
}
