package com.digital.endpoints.infrastructure.utilities;

import java.util.regex.Pattern;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/10/23
 * Project : com.digital.system
 */
public abstract class RegExpressionUtil {

    /**
     * @param exceptionMessage
     * @return
     */
    public static String getValue(String regExp, String exceptionMessage) {
        final var value = Pattern.compile(regExp).matcher(exceptionMessage);
        return value.find() ? value.group(0).trim() : "";
    }
}
