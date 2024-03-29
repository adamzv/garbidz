package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Container;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Set;

public interface ContainerRepository extends JpaRepository<Container, Long> {
    Set<Container> findAllByAddress_Id(Long id);

    //    @Override
    @Query(value = "SELECT distinct c FROM Container c left join fetch c.users u join fetch c.address a left join fetch c.containerSchedule cs",
            countQuery = "SELECT distinct count(c) FROM Container c left join c.users u join c.address a left join c.containerSchedule cs")
    Page<Container> findAll2(Pageable pageable);
}