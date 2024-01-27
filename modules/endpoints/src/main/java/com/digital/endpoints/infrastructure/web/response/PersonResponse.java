package com.digital.endpoints.infrastructure.web.response;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.UUID;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
@Data
@AllArgsConstructor
public class PersonResponse {
    private UUID id;
    private String firstName;
    private String lastName;
    private String gender;
}
