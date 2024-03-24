package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Complaint;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    Page<Complaint> findAllByUser_Id(Pageable pageable, Long id);
}
