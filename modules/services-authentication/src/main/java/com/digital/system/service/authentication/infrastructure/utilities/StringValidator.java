package com.digital.system.service.authentication.infrastructure.utilities;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

import java.util.Objects;
import java.util.regex.Pattern;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 1/9/23
 * Project : lhtk
 */
@Slf4j
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class StringValidator {

    /**
     * @param value
     * @return
     */
    public static boolean isEmpty(String value) {
        return Objects.isNull(value) || value.isEmpty();
    }

    /**
     * @param value
     * @return
     */
    @SneakyThrows
    public static boolean isContainReservedWord(String value) {

        final JSONLoaderUtil.Keyword keyword = new ObjectMapper()
                .readValue(JSONLoaderUtil.Keyword.class.getResourceAsStream("/json/reserve-words.json")
                        , JSONLoaderUtil.Keyword.class
                );
        return keyword.getJavaKeywords().contains(value) ||
                keyword.getSqlKeywords().contains(value.toUpperCase());
    }

    /**
     * @param value
     * @return
     */
    public static boolean isContainingEmoji(String value) {
        return value.chars()
                .mapToObj(c -> (char) c)
                .toList()
                .stream()
                .anyMatch(StringValidator::isEmojiCharacter);
    }

    /**
     * @param text
     * @return true - for
     */
    public static boolean isContainingSpecialSymbol(String text) {
        return !Pattern.compile("^([a-zA-Z0-9.\\s_-])*$").matcher(text).find();
    }

    public static boolean isLongerThan(int lengthAllowance, String text) {
        return text.length() > lengthAllowance;
    }

    /**
     * @param text
     * @return true - for valid email, false - for none email pattern
     */
    public static boolean isValidEmailPattern(String text) {
        return !Pattern.compile("^(.+)@(\\\\S+)$").matcher(text).find();
    }

    /**
     * a
     *
     * @param codePoint
     * @return
     */
    private static boolean isEmojiCharacter(char codePoint) {
        return !(codePoint == 0x0
                || codePoint == 0x9
                || codePoint == 0xA
                || codePoint == 0xD
                || codePoint >= 0x20 && codePoint <= 0xD7FF
                || codePoint >= 0xE000 && codePoint <= 0xFFFD
        );
    }


}
