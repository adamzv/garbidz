package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.ERole;
import com.github.adamzv.backend.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

// JpaRepository extends PagingAndSortingRepository which extends CrudRepository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByRole(ERole role);
}
