package com.digital.system.service.authentication.infrastructure.web.validation;

import com.digital.system.service.authentication.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.system.service.authentication.infrastructure.web.validation.annotations.EnumValidate;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/10/23
 * Project : com.digital.system
 */
@Slf4j
public class EnumConstraintValidator implements ConstraintValidator<EnumValidate, Enum<?>> {

    /**
     * @param anEnum
     * @param constraintValidatorContext
     * @return
     */
    @Override
    @SneakyThrows
    public boolean isValid(Enum anEnum, ConstraintValidatorContext constraintValidatorContext) {
        return AuthorizationRole.list().contains(AuthorizationRole.valueOf(anEnum.name()));
    }
}
