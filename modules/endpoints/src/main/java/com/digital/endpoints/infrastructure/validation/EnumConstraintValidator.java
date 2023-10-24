package com.digital.endpoints.infrastructure.validation;

import com.digital.endpoints.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.endpoints.infrastructure.validation.annotations.EnumValidate;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

import java.util.Objects;

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
        return !Objects.isNull(AuthorizationRole.valueOf(anEnum.name()));
    }
}
