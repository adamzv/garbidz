package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContainerRepository extends JpaRepository<Container, Long> {

}