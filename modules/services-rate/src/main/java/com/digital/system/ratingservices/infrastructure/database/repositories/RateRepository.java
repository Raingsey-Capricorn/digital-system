package com.digital.system.ratingservices.infrastructure.database.repositories;

import com.digital.system.ratingservices.infrastructure.database.entities.RateEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/1/24
 * Project : com.digital.system
 */
@Repository
public interface RateRepository extends JpaRepository<RateEntity, Long> {
}
