package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportRepository extends JpaRepository<Report, Long> {
}
