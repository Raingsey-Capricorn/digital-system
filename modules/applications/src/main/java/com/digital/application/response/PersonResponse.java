package com.digital.application.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonResponse {
    private UUID id;
    private String firstName;
    private String lastName;
    private String gender;
}
