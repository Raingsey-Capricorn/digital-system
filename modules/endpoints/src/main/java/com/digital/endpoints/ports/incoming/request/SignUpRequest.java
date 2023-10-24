package com.digital.endpoints.ports.incoming.request;

import com.digital.endpoints.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.endpoints.infrastructure.validation.annotations.Validate;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Builder;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Builder
public record SignUpRequest(
        @Validate(type = Validate.Type.STRING, fieldName = "First Name")
        String firstName,
        @Validate(type = Validate.Type.STRING, fieldName = "Last Name")
        String lastName,
        @Validate(type = Validate.Type.EMAIL, fieldName = "Email")
        String email,
        @Validate(type = Validate.Type.PASSWORD, fieldName = "Password")
        String password,
        @Validate(type = Validate.Type.ENUM, fieldName = "Password")
        @Enumerated(EnumType.STRING)
        AuthorizationRole role
) {
}