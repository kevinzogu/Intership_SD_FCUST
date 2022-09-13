package com.example.clientaccount.Repository;

import com.example.clientaccount.Model.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account,Long>{
}
