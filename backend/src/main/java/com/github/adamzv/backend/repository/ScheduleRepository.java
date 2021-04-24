package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.ContainerSchedule;
import com.github.adamzv.backend.model.Schedule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ScheduleRepository extends JpaRepository<Schedule, Long> {
    @Query("SELECT cs FROM ContainerSchedule cs INNER JOIN cs.container c INNER JOIN c.containerUser cu INNER JOIN cu.user u INNER JOIN cs.schedule s WHERE u.id = :id AND s.datetime >= CURRENT_DATE")
    Page<ContainerSchedule> findAllSchedulesForUser(Pageable pageable, Long id);
}