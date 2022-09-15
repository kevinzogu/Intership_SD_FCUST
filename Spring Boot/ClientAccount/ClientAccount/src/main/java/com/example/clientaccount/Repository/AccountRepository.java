package com.example.clientaccount.Repository;

import com.example.clientaccount.Model.Account;
import com.example.clientaccount.Model.Client;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface AccountRepository extends JpaRepository<Account,Long> {
}
