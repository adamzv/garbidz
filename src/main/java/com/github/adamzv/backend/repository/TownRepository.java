package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Town;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TownRepository extends JpaRepository<Town, Long> {
    List<Town> findAllByRegionId(Long id);
}
