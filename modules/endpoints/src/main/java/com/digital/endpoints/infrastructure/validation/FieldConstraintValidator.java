package com.digital.endpoints.infrastructure.validation;

import com.digital.endpoints.infrastructure.utilities.StringValidatorUtil;
import com.digital.endpoints.infrastructure.validation.annotations.StringValidate;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.SneakyThrows;

/**
 * <a href="https://stackoverflow.com/questions/6802483/how-to-directly-initialize-a-hashmap-in-a-literal-way">
 * directly initialize a HashMap (in a literal way)?
 * </a>
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/10/23
 * Project : com.digital.system
 */

public class FieldConstraintValidator implements ConstraintValidator<StringValidate, String> {

    private StringValidate annotation;
    private static final String MESSAGE_EMPTY = "is empty";
    private static final String MESSAGE_LONGER_THAN = "longer than %d";
    private static final String MESSAGE_EMOJI = "contain Emotion Icon";
    private static final String MESSAGE_EMAIL = "invalid email pattern";
    private static final String MESSAGE_RESERVED_WORD = "contain reserved word";
    private static final String MESSAGE_SPECIAL_CHARACTER = "contain special character";

    /**
     * @param constraintAnnotation
     */
    @Override
    public void initialize(StringValidate constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
        this.annotation = constraintAnnotation;
    }

    /**
     * @param value   : validating value of annotated field
     * @param context : ConstraintValidatorContext
     * @return false/true - valid/invalid
     */
    @SneakyThrows
    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {

        switch (annotation.type()) {
            case STRING -> {
                final var limit = 16;
                if (StringValidatorUtil.isEmpty(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMPTY);
                } else if (StringValidatorUtil.isContainingEmoji(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMOJI);
                } else if (StringValidatorUtil.isContainingReservedWord(value)) {
                    return reApplyViolationMessage(context, MESSAGE_RESERVED_WORD);
                } else if (StringValidatorUtil.isContainingSpecialSymbol(value)) {
                    return reApplyViolationMessage(context, MESSAGE_SPECIAL_CHARACTER);
                } else if (StringValidatorUtil.isLongerThan(value, limit)) {
                    return reApplyViolationMessage(context, String.format(MESSAGE_LONGER_THAN, limit));
                } else return true;
            }
            case EMAIL -> {
                if (StringValidatorUtil.isEmpty(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMPTY);
                } else if (StringValidatorUtil.isContainingEmoji(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMOJI);
                } else if (StringValidatorUtil.isInValidEmailPattern(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMAIL);
                } else if (StringValidatorUtil.isContainingReservedWord(value)) {
                    return reApplyViolationMessage(context, MESSAGE_RESERVED_WORD);
                } else return true;
            }
            case PASSWORD -> {
                if (StringValidatorUtil.isEmpty(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMPTY);
                } else if (StringValidatorUtil.isContainingEmoji(value)) {
                    return reApplyViolationMessage(context, MESSAGE_EMOJI);
                } else if (StringValidatorUtil.isContainingReservedWord(value)) {
                    return reApplyViolationMessage(context, MESSAGE_RESERVED_WORD);
                } else return true;
            }
        }
        return false;
    }

    /**
     * @param context    : ConstraintValidatorContext
     * @param newMessage : specified error message for the invalidity of parameters
     * @return false to indicate invalidity
     */
    private boolean reApplyViolationMessage(
            final ConstraintValidatorContext context,
            final String newMessage) {

        context.disableDefaultConstraintViolation();
        context.buildConstraintViolationWithTemplate(
                        annotation.message()
                                .transform(s -> s.replaceFirst("(.*)", newMessage)))
                .addConstraintViolation();
        return false;
    }
}