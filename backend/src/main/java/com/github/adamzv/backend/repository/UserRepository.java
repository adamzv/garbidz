package com.github.adamzv.backend.repository;

import com.github.adamzv.backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

// JpaRepository extends PagingAndSortingRepository which extends CrudRepository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}
