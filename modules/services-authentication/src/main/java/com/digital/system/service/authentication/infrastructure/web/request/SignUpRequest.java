package com.digital.system.service.authentication.infrastructure.web.request;

import com.digital.system.service.authentication.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.system.service.authentication.infrastructure.web.validation.annotations.EnumValidate;
import com.digital.system.service.authentication.infrastructure.web.validation.annotations.StringValidate;
import lombok.Builder;

import java.io.Serializable;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Builder
public record SignUpRequest(
        @StringValidate(type = StringValidate.FieldType.STRING, fieldName = "First Name")
        String firstName,
        @StringValidate(type = StringValidate.FieldType.STRING, fieldName = "Last Name")
        String lastName,
        @StringValidate(type = StringValidate.FieldType.EMAIL, fieldName = "Email")
        String email,
        @StringValidate(type = StringValidate.FieldType.PASSWORD, fieldName = "Password")
        String password,
        @EnumValidate(fieldName = "Password")
        AuthorizationRole role) implements Serializable {
}