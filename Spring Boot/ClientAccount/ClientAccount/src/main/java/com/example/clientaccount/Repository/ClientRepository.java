package com.example.clientaccount.Repository;

import com.example.clientaccount.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<Client ,Long> {
}
