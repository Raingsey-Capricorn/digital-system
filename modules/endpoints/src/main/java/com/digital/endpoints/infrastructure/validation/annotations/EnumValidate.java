package com.digital.endpoints.infrastructure.validation.annotations;

import com.digital.endpoints.infrastructure.validation.EnumConstraintValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;


@Documented
@Target({ElementType.ANNOTATION_TYPE,
        ElementType.CONSTRUCTOR,
        ElementType.PARAMETER,
        ElementType.TYPE_USE,
        ElementType.METHOD,
        ElementType.FIELD,
})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = EnumConstraintValidator.class)
public @interface EnumValidate {
    Class<? extends Payload>[] payload() default {};

    String fieldName();

    String message() default " is invalid";

    Class<?>[] groups() default {};
}
