package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

// JpaRepository extends PagingAndSortingRepository which extends CrudRepository
public interface RoleRepository extends JpaRepository<Role, Long> {
}
