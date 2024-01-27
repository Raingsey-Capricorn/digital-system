package com.digital.system.loanservice.infrastructure.database.repositories;

import com.digital.system.loanservice.infrastructure.database.entities.LoanEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Repository
public interface LoanRepository extends JpaRepository<LoanEntity, Long> {
}
