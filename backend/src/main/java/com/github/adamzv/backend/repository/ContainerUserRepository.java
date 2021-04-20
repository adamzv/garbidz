package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.ContainerUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContainerUserRepository extends JpaRepository<ContainerUser, Long> {
}
