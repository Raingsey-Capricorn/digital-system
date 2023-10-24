package com.digital.endpoints.ports.incoming.request;

import com.digital.endpoints.infrastructure.validation.annotations.Validate;
import lombok.Builder;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Builder
public record SignInRequest(
        @Validate(type = Validate.Type.STRING, fieldName = "Email")
        String email,
        @Validate(type = Validate.Type.PASSWORD, fieldName = "Password")
        String password) {
}
