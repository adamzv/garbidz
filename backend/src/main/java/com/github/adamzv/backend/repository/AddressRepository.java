package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressRepository extends JpaRepository<Address, Long> {
}
