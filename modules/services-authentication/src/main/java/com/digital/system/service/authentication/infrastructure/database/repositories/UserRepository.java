package com.digital.system.service.authentication.infrastructure.database.repositories;

import com.digital.system.service.authentication.infrastructure.database.entities.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 6/10/23
 * Project : com.digital.system
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {
    /**
     * @param email
     * @return
     */
    Optional<UserEntity> findByEmail(String email);
}
