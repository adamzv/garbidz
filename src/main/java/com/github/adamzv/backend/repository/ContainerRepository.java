package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Container;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface ContainerRepository extends JpaRepository<Container, Long> {
    Set<Container> findAllByAddress_Id(Long id);
}