package com.digital.system.service.authentication.infrastructure.utilities;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.regex.Pattern;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/10/23
 * Project : com.digital.system
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public abstract class RegExpressionUtil {

    /**
     * @param regExp           : regular express to compile
     * @param exceptionMessage : exception message to match
     * @return result of the matched exception message
     */
    public static String getValue(String regExp, String exceptionMessage) {
        final var value = Pattern.compile(regExp).matcher(exceptionMessage);
        return value.find() ? value.group(0).trim() : "";
    }
}
