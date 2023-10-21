package com.digital.endpoints.infrastructure.entities;

import com.digital.endpoints.config.constants.AuthorizationRole;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 6/10/23
 * Project : com.digital.system
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(catalog = "sample", schema = "sample", name = "t_users")
public class UserEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    @Enumerated(EnumType.STRING)
    private AuthorizationRole role;

}
