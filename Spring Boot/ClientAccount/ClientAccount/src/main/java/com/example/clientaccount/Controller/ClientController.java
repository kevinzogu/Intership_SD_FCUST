package com.example.clientaccount.Controller;

import com.example.clientaccount.Model.Client;
import com.example.clientaccount.Service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ClientController {

    @Autowired
    private ClientService clientService;

    @GetMapping("/clients/{id}")
    ResponseEntity<Client> getClientById(@PathVariable long id){
        return ResponseEntity.ok().body(clientService.getClientById(id));
    }

    @GetMapping("/clients")
    ResponseEntity<List<Client>> getAllClient(){
        return ResponseEntity.ok().body(clientService.getAllClient());
    }

    @PostMapping("/clients")
    public ResponseEntity<Client> createClient(@RequestBody Client client){
        return ResponseEntity.ok().body(this.clientService.createClient(client));
    }

    @PutMapping("/clients/{id}")
    public ResponseEntity<Client> updateClient(long id,@RequestBody Client client){
        client.setId(id);
        return ResponseEntity.ok().body(this.clientService.updateClient(client));
    }
    @DeleteMapping("/clients/{id}")
    public HttpStatus deleteClient(@PathVariable long id,@RequestBody Client client){
        this.clientService.deleteClient(id);
        return HttpStatus.OK;
    }

}
