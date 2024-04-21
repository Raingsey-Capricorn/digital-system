package com.digital.system.service.authentication.infrastructure.web.validation.annotations;

import com.digital.system.service.authentication.infrastructure.web.validation.FieldConstraintValidation;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;


@Documented
@Target({
        ElementType.ANNOTATION_TYPE,
        ElementType.CONSTRUCTOR,
        ElementType.PARAMETER,
        ElementType.TYPE_USE,
        ElementType.METHOD,
        ElementType.FIELD,
})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = FieldConstraintValidation.class)
public @interface Validate {

    Type type();

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    String fieldName() default " is invalid";

    String message() default " is invalid";

    enum Type {
        NAME, EMAIL, PASSWORD;
    }
}
