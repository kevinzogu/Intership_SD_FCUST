package com.example.clientaccount.Service;

import com.example.clientaccount.Model.Client;

import java.util.List;

public interface ClientService {
    Client createClient(Client client);

    Client updateClient(Client client);

    List<Client> getAllClient();

    Client getClientById(Long clienId);

    void deleteClient(long clienId);

}
