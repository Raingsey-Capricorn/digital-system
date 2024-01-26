package com.digital.endpoints.infrastructure.web.validation;

import com.digital.endpoints.infrastructure.utilities.StringValidator;
import com.digital.endpoints.infrastructure.web.validation.annotations.Validate;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/10/23
 * Project : com.digital.system
 */
@Component
public class FieldConstraintValidation implements ConstraintValidator<Validate, String> {

    private Validate constraintAnnotation;

    @Override
    public void initialize(Validate constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
        this.constraintAnnotation = constraintAnnotation;
    }

    @SneakyThrows
    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {

        switch (constraintAnnotation.type()) {
            case PASSWORD -> {

            }
            case EMAIL -> {
                return StringValidator.isContainingSpecialSymbol(s) &&
                        StringValidator.isContainReservedWord(s) &&
                        StringValidator.isContainingEmoji(s) &&
                        StringValidator.isValidEmailPattern(s) &&
                        StringValidator.isEmpty(s);
            }
            case NAME -> {

                return StringValidator.isContainingSpecialSymbol(s) &&
                        StringValidator.isContainReservedWord(s) &&
                        StringValidator.isContainingEmoji(s) &&
                        StringValidator.isEmpty(s) &&
                        StringValidator.isLongerThan(16, s);
            }
        }
        return true;
    }
}
