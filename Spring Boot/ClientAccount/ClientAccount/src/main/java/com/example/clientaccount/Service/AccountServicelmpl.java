package com.example.clientaccount.Service;

import com.example.clientaccount.Exception.ResourceNotFoundException;
import com.example.clientaccount.Model.Account;
import com.example.clientaccount.Repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class AccountServicelmpl implements AccountService{

    @Autowired
    private AccountRepository accountRepository;


    @Override
    public Account createAccount(Account account) {
        return accountRepository.save(account);

    }

    @Override
    public Account updateAccount(Account account) {
        Optional<Account> accountDB = this.accountRepository.findById(account.getAccountId());
        if (accountDB.isPresent()) {
            Account accountUpdate = accountDB.get();
            accountUpdate.setAccountId(account.getAccountId());
            accountUpdate.setAccountNo(account.getAccountNo());
            accountUpdate.setAmount(account.getAmount());
            accountUpdate.setCcy(account.getCcy());
            accountUpdate.setPriority(account.getPriority());
            accountRepository.save(accountUpdate);
            return accountUpdate;
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + account.getAccountId() );
        }
    }

    @Override
    public List<Account> getAllAccount() {
        return (List<Account>) this.accountRepository.findAll();
    }

    @Override
    public Account getAccountById(Long accountId) {
        Optional<Account> accountDB = this.accountRepository.findById(accountId);
        if (accountDB.isPresent()) {
            return accountDB.get();
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + accountId);
        }
    }

    @Override
    public void deleteAccount(long accountId) {
        Optional<Account> accountDB = this.accountRepository.findById(accountId);
        if (accountDB.isPresent()) {
            this.accountRepository.delete(accountDB.get());
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + accountId);
        }
    }
}
