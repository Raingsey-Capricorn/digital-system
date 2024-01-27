package com.digital.application.utils;

import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoField;
import java.time.temporal.TemporalAccessor;
import java.util.HashMap;
import java.util.Locale;
import java.util.Objects;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
public final class TimeConversionUtil {
    private static final HashMap<Integer, String> NUMBER_MAP = new HashMap<>() {{
        put(0, "zero");
        put(1, "one");
        put(2, "two");
        put(3, "three");
        put(4, "four");
        put(5, "five");
        put(6, "six");
        put(7, "seven");
        put(8, "eight");
        put(9, "nine");
        put(10, "ten");
        put(11, "eleven");
        put(12, "twelve");
        put(13, "thirteen");
        put(14, "fourteen");
        put(15, "fifteen");
        put(16, "sixteen");
        put(17, "seventeen,");
        put(18, "eighteen,");
        put(19, "nineteen,");
        put(20, "twenty");
        put(21, "twenty-one");
        put(22, "twenty-two");
        put(23, "twenty-three");
        put(24, "twenty-four");
        put(25, "twenty-five");
        put(26, "twenty-six");
        put(27, "twenty-seven");
        put(28, "twenty-eight");
        put(29, "twenty-nine");
        put(30, "thirty");
        put(31, "thirty-one");
        put(32, "thirty-two");
        put(33, "thirty-three");
        put(34, "thirty-four");
        put(35, "thirty-five");
        put(36, "thirty-six");
        put(37, "thirty-seven");
        put(38, "thirty-eight");
        put(39, "thirty-nine");
        put(40, "forty");
        put(41, "forty-one");
        put(42, "forty-two");
        put(43, "forty-three");
        put(44, "forty-four");
        put(45, "forty-five");
        put(46, "forty-six");
        put(47, "forty-seven");
        put(48, "forty-eight");
        put(49, "forty-nine");
        put(50, "fifty");
        put(51, "fifty-one");
        put(52, "fifty-two");
        put(53, "fifty-three");
        put(54, "fifty-four");
        put(55, "fifty-five");
        put(56, "fifty-six");
        put(57, "fifty-seven");
        put(58, "fifty-eight");
        put(59, "fifty-nine");
    }};

    /**
     * @param hourWithDayPeriod
     * @return
     */
    public static String numericToCardinalHours(String hourWithDayPeriod) {

        if (isValidPattern(hourWithDayPeriod) != null) {
            var timeFormat = isValidPattern(hourWithDayPeriod);
            var hourFromAM_PM = Objects.requireNonNull(timeFormat).get(ChronoField.HOUR_OF_AMPM);
            var minuteOfHour = timeFormat.get(ChronoField.MINUTE_OF_HOUR);
            var periodOfDay = timeFormat.get(ChronoField.AMPM_OF_DAY);

            var messagePast3Parameters = String.format("It's %s past %s in the %s",
                    NUMBER_MAP.get(minuteOfHour),
                    NUMBER_MAP.get(hourFromAM_PM),
                    periodOfDay == 0 ? "morning" : "evening");
            var messageQuarterPastParameters = String.format("It's quarter past %s in the %s",
                    NUMBER_MAP.get(hourFromAM_PM),
                    periodOfDay == 0 ? "morning" : "evening");
            var messageHalfPastParameters = String.format("It's half-past %s in the %s",
                    NUMBER_MAP.get(hourFromAM_PM),
                    periodOfDay == 0 ? "morning" : "evening");
            var messageTo3Parameters = String.format("It's %s to %s in the %s",
                    NUMBER_MAP.get(60 - minuteOfHour),
                    NUMBER_MAP.get(hourFromAM_PM + 1),
                    periodOfDay == 0 ? "morning" : "evening");
            var messageQuarterToParameters = String.format("It's quarter to %s in the %s",
                    NUMBER_MAP.get(hourFromAM_PM + 1),
                    periodOfDay == 0 ? "morning" : "evening");

            if (NUMBER_MAP.containsKey(hourFromAM_PM)) {
                if (minuteOfHour == 0) {
                    return String.format("It's %s in the %s",
                            NUMBER_MAP.get(hourFromAM_PM),
                            periodOfDay == 0 ? "morning" : "evening");
                } else if (minuteOfHour < 30) {
                    return minuteOfHour == 15 ? messageQuarterPastParameters : messagePast3Parameters;
                } else if (minuteOfHour == 30) {
                    return messageHalfPastParameters;
                } else if (minuteOfHour < 59) {
                    return minuteOfHour == 45 ? messageQuarterToParameters : messageTo3Parameters;
                }
            }
        }
        return null;
    }

    private static TemporalAccessor isValidPattern(String time) {
        try {
            return DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH).parse(time.toUpperCase(Locale.ROOT));
        } catch (DateTimeParseException e) {
            try {
                return DateTimeFormatter.ofPattern("h:mma", Locale.ENGLISH).parse(time.toUpperCase(Locale.ROOT));
            } catch (DateTimeParseException ex) {
                return null;
            }
        }
    }
}
