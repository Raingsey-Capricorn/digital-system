package com.digital.endpoints.ports.incoming.request;

import com.digital.endpoints.infrastructure.validation.annotations.StringValidate;
import lombok.Builder;

import java.io.Serializable;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Builder
public record SignInRequest(
        @StringValidate(type = StringValidate.FieldType.EMAIL, fieldName = "Email")
        String email,
        @StringValidate(type = StringValidate.FieldType.PASSWORD, fieldName = "Password")
        String password) implements Serializable {
}
