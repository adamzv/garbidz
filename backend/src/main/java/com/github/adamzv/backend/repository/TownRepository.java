package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Town;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TownRepository extends JpaRepository<Town, Long> {
}
