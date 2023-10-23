package com.digital.endpoints.ports.incoming.request;

import lombok.Builder;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Builder
public record SignInRequest(
        String email,
        String password) {
}
