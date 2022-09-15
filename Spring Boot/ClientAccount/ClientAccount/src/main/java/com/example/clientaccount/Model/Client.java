package com.example.clientaccount.Model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "clients")
public class Client implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "clientId")
    public Long clientId;
    @Column(name = "clientNo")
    public String clientNo;
    @Column(name = "name")
    public String name;
    @Column(name = "phone")
    public String phone;
    @Column(name = "email")
    public String email;
    @Column(name = "type")
    public String type;
    @Column(name = "category")
    public String category;


    @OneToMany(mappedBy ="client" ,cascade = CascadeType.ALL,orphanRemoval = true)
    @JsonIgnoreProperties("client")
   //@JsonManagedReference
    public List<Account> account;

    public Client(String clientNo, String name, String phone, String email, String type, String category, List<Account> account) {
        this.clientNo = clientNo;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.type = type;
        this.category = category;
        this.account = account;
    }

    public Client() {
    }

    public List<Account> getAccount() {
        return account;
    }

    public void setAccount(List<Account> accounts) {
        this.account = accounts;
    }

    public Long getId() {
        return clientId;
    }

    public Client setId(Long id) {
        this.clientId = id;
        return null;
    }

    public String getNo() {
        return clientNo;
    }

    public void setNo(String no) {
        this.clientNo = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Client{" +
                "id=" + clientId +
                ", no='" + clientNo + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", type='" + type + '\'' +
                ", category='" + category + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Client client = (Client) o;
        return client.equals(client.clientId) && clientNo.equals(client.clientNo) && name.equals(client.name) && phone.equals(client.phone) && email.equals(client.email) && type.equals(client.type) && category.equals(client.category);
    }

    @Override
    public int hashCode() {
        return Objects.hash(clientId, clientNo, name, phone, email, type, category);
    }
}
