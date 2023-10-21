package com.digital.endpoints.ports.incoming.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SignInRequest {
    private String email;
    private String password;
}
