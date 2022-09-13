package com.example.clientaccount.Model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "Account")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "accountId", nullable = false)
    private Long accountId;
    @Column(name = "accountNo")
    private String accountNo;
    @Column(name = "ccy")
    private String ccy;
    @Column(name = "amount")
    private String amount;
    @Column(name = "priority")
    private String priority;

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return accountId.equals(account.accountId) && accountNo.equals(account.accountNo) && ccy.equals(account.ccy) && amount.equals(account.amount) && priority.equals(account.priority);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountId, accountNo, ccy, amount, priority);
    }

    @Override
    public String toString() {
        return "Account{" +
                "accountId=" + accountId +
                ", accountNo='" + accountNo + '\'' +
                ", ccy='" + ccy + '\'' +
                ", amount='" + amount + '\'' +
                ", priority='" + priority + '\'' +
                '}';
    }
}
