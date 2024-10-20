package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    Optional<Address> findAddressByAddress(String address);
}
