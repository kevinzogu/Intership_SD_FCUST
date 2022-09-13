package com.example.clientaccount.Service;

import com.example.clientaccount.Model.Account;

import java.util.List;

public interface AccountService {
    Account createAccount(Account account);

    Account updateAccount(Account account);

    List<Account> getAllAccount();

    Account getAccountById(Long accountId);

    void deleteAccount(long accountId);
}
