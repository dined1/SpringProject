package com.hellokoding.account.Models;

import javax.persistence.*;
import java.io.Serializable;


public class Card implements Serializable {
    @Column(name = "CardId", table = "card", nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long CardId;

    @Column(name = "Card_number", table = "card")
    @Basic
    private String cardnumber;

    @Column(name = "Cvc", table = "card")
    @Basic
    private String cvc;
    @Column(name = "CardHolder", table = "card")
    @Basic
    private String cardholder;

    @Column(name = "Expiration_date", table = "card")
    @Basic
    private String expiration_date;

    @Column(name="Sum",  table="card")
    @Basic
    private String sum;

    @Column(name="SOID",  table="card")
    @Basic
    private String soid;
    public Long getCardid() {
        return this.CardId;
    }

    public void setCardidId(Long cardid) {
        this.CardId = cardid;
    }

    public String getCardnumber() {
        return this.cardnumber;
    }

    public void setCardnumber(String cardnumber) {this.cardnumber = cardnumber;}

    public String getCvc() {
        return this.cvc;
    }

    public void setCvc(String cvc) {
        this.cvc = cvc;
    }

    public String getExpiration_date() {
        return this.expiration_date;
    }

    public void setExpiration_date(String expiration_date) {
        this.expiration_date = expiration_date;
    }

    public String getSum() {
        return this.sum;
    }
    public void setSum(String sum) {
        this.sum = sum;
    }
    public void setSOID(String soid) {
        this.soid = soid;
    }
    public String getSOID() {
        return this.soid;
    }
    public void setCardholder(String cardholder) {
        this.cardholder = cardholder;
    }
    public String getCardholder() {
        return this.cardholder;
    }







    
}
