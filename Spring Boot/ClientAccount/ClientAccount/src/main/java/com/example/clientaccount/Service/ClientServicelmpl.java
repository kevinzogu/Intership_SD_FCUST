package com.example.clientaccount.Service;

import com.example.clientaccount.Exception.ResourceNotFoundException;
import com.example.clientaccount.Model.Client;
import com.example.clientaccount.Repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ClientServicelmpl implements ClientService {

    @Autowired
    private ClientRepository clientRepository;

    @Override
    public Client createClient(Client client) {
        return clientRepository.save(client);
    }

    @Override
    public Client updateClient(Client client) {
        Optional<Client> clientDB = this.clientRepository.findById(client.getId());
        if (clientDB.isPresent()) {
            Client clientUpdate = clientDB.get();
            clientUpdate.setId(client.getId());
            clientUpdate.setNo(client.getNo());
            clientUpdate.setName(client.getName());
            clientUpdate.setPhone(client.getPhone());
            clientUpdate.setEmail(client.getEmail());
            clientUpdate.setType(client.getType());
            clientUpdate.setCategory(client.getCategory());
            clientUpdate.setAccount(client.getAccount());
            clientRepository.save(clientUpdate);
            return clientUpdate;
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + client.getId() );
        }
    }

    @Override
    public List<Client> getAllClient() {
        return (List<Client>) this.clientRepository.findAll();
    }

    @Override
    public Client getClientById(long clientId) {
        Optional<Client> clientDB = this.clientRepository.findById(clientId);
        if (clientDB.isPresent()) {
            return clientDB.get();
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + clientId);
        }
    }

    @Override
    public void deleteClient(long clienId) {
        Optional<Client> clientDB = this.clientRepository.findById(clienId);
        if (clientDB.isPresent()) {
            this.clientRepository.delete(clientDB.get());
        }else{
            throw new ResourceNotFoundException("Record not found with id : " + clienId);
        }
    }
}
