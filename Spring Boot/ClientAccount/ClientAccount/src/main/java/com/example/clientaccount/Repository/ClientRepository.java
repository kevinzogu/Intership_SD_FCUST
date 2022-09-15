package com.example.clientaccount.Repository;

import com.example.clientaccount.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ClientRepository extends JpaRepository<Client ,Long> {
}
