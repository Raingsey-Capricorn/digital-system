package com.digital.endpoints;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;
import org.junit.jupiter.api.Test;

import java.nio.charset.StandardCharsets;

@Slf4j
class EndpointsApplicationTest {

    @Test
    void tokenGeneratorTest() {

        /* How to generate secretKey for calling the method below Keys.hmacShaKeyFor */
        final var data = "digital-system-secret";
        final var readableKey = "digital.system";
        final var secretKey = new HmacUtils(
                HmacAlgorithms.HMAC_SHA_512,
                readableKey.getBytes(StandardCharsets.UTF_8)
        ).hmacHex(data);

        log.warn("Save the secretKey to file (application.yml) or secretKey file for reading back to check JWT key-has comparison");
        log.info("jwt.secret.key: : {}", secretKey);
    }
}