package com.digital.system.ratingservices.infrastructure.database.entities;

import com.digital.system.ratingservices.infrastructure.constant.RateType;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/1/24
 * Project : com.digital.system
 */
@Data
@Entity
@NoArgsConstructor
@Table(catalog = "sample", schema = "sample", name = "t_rates")
public class RateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Long id;

    @Column(name = "rate")
    private Double rate;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private RateType type;

}
