package com.example.clientaccount.Model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "accounts")
public class Account implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "accountId",unique = true)
    private Long accountId;

    @Column(name = "accountNo")
    private String accountNo;

    @Column(name = "clientNo")
    private String clientNo;
    @Column(name = "ccy")
    private String ccy;
    @Column(name = "amount")
    private String amount;
    @Column(name = "priority")
    private String priority;

    @ManyToOne
    @JoinColumn(name = "clientNo", referencedColumnName = "clientNo",insertable = false,updatable = false)
    //@JsonBackReference
    @JsonIgnoreProperties("account")
    public Client client;



    public String getClientNo() {
        return clientNo;
    }

    public void setClientNo(String clientNo) {
        this.clientNo = clientNo;
    }

    public Account() {
    }

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }


    public String getCcy() {
        return ccy;
    }

    public void setCcy(String ccy) {
        this.ccy = ccy;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

  public Account(String accountNo, String clientNo, String ccy, String amount, String priority, Client client) {
      this.accountNo = accountNo;
      this.clientNo = clientNo;
      this.ccy = ccy;
      this.amount = amount;
      this.priority = priority;
      this.client = client;
  }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return accountId.equals(account.accountId) && accountNo.equals(account.accountNo) && clientNo.equals(account.clientNo) && ccy.equals(account.ccy) && amount.equals(account.amount) && priority.equals(account.priority) && client.equals(account.client);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountId, accountNo, clientNo, ccy, amount, priority ,client);
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + accountId +
                ", accountNo='" + accountNo + '\'' +
                ", clientNo='" + clientNo + '\'' +
                ", ccy='" + ccy + '\'' +
                ", amount='" + amount + '\'' +
                ", priority='" + priority + '\'' +
                ", client=" + client +
                '}';
    }
}
