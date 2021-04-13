package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Container;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContainerRepository extends JpaRepository<Container, Long> {

}