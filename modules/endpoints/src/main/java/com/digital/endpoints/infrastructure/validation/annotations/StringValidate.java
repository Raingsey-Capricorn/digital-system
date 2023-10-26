package com.digital.endpoints.infrastructure.validation.annotations;

import com.digital.endpoints.infrastructure.validation.FieldConstraintValidator;
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
@Constraint(validatedBy = FieldConstraintValidator.class)
public @interface StringValidate {

    FieldType type();

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    String fieldName();

    String message() default "";

    enum FieldType {
        STRING, EMAIL, PASSWORD
    }
}
