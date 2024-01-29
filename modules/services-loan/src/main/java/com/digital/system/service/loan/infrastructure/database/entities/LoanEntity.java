package com.digital.system.service.loan.infrastructure.database.entities;

import com.digital.system.service.loan.infrastructure.constant.LoanType;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Data
@Entity
@NoArgsConstructor
@Table(catalog = "sample", schema = "sample", name = "t_loans")
public class LoanEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private LoanType type;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "interest")
    private Double interest;
}