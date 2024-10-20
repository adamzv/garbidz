package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Region;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegionRepository extends JpaRepository<Region, Long> {
}
