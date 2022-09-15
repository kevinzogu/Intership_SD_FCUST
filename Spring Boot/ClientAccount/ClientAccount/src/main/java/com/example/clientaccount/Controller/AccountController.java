package com.example.clientaccount.Controller;

import com.example.clientaccount.Model.Account;
import com.example.clientaccount.Service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/accounts/{id}")
    ResponseEntity<Account> getAccountById(@PathVariable long id){
        return ResponseEntity.ok().body(accountService.getAccountById(id));
    }
    @GetMapping("/accounts")
    ResponseEntity<List<Account>> getAllAccount(){
        return ResponseEntity.ok().body(accountService.getAllAccount());
    }

    @PostMapping("/accounts")
    public ResponseEntity<Account> createAccount(@RequestBody Account account){
        return ResponseEntity.ok().body(this.accountService.createAccount(account));
    }

    @PutMapping("/accounts/{id}")
    public ResponseEntity<Account> updateAccount(long id,@RequestBody Account account){
        account.setAccountId(id);
        return ResponseEntity.ok().body(this.accountService.updateAccount(account));
    }

    @DeleteMapping("/accounts/{id}")
    public HttpStatus deleteAccount(@PathVariable long id, @RequestBody Account account){
        this.accountService.deleteAccount(id);
        return HttpStatus.OK;
    }
}
