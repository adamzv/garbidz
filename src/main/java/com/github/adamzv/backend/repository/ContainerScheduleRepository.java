package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.ContainerSchedule;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContainerScheduleRepository extends JpaRepository<ContainerSchedule, Long> {
}
