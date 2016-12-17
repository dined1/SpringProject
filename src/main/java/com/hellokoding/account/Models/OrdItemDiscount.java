package com.hellokoding.account.Models;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import javax.ws.rs.FormParam;
import java.io.Serializable;

/**
 * Created by Admin on 17.12.2016.
 */
@Entity
@Table(name = "orditemdiscount")
@Transactional
public class OrdItemDiscount implements Serializable {

    @Column(name = "OrdIDid", table = "orditemdiscount", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @FormParam("OrdIDid")
    private Long OrdIDid;

    @ManyToOne(targetEntity = OrdItem.class)
    private OrdItem OrdItem;

    @ManyToOne(targetEntity = Discountrule.class)
    private Discountrule discountrule1;

    public com.hellokoding.account.Models.OrdItem getOrdItem() {
        return OrdItem;
    }

    public void setOrdItem(com.hellokoding.account.Models.OrdItem ordItem) {
        OrdItem = ordItem;
    }

    public Discountrule getDiscountrule1() {
        return discountrule1;
    }

    public void setDiscountrule1(Discountrule discountrule1) {
        this.discountrule1 = discountrule1;
    }
}
