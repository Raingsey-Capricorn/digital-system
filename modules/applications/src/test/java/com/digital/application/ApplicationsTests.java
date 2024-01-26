package com.digital.application;

import com.digital.application.utils.TimeConversionUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@AllArgsConstructor
@SpringBootTest(classes = Applications.class)
class ApplicationsTests {

    @Test
    void contextLoads() {

        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("7:24 AM"),
                "It's twenty-four past seven in the morning");
        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("7:24 PM"),
                "It's twenty-four past seven in the evening");
        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("7:00 PM"),
                "It's seven in the evening");
        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("12:24PM"),
                "It's twenty-four past zero in the evening");
        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("12:24 PM"),
                "It's twenty-four past zero in the evening");
        Assertions.assertEquals(
                TimeConversionUtil.numericToCardinalHours("11:04PM"),
                "It's four past eleven in the evening");

    }
}


