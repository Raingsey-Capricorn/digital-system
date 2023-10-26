package com.digital.configuration;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

/**
 * <a href="https://cloud.spring.io/spring-cloud-static/spring-cloud-config/2.2.2.RELEASE/reference/html/?ref=thomasvitale.com#config-first-bootstrap">Spring Cloud Config</a>
 * https://stackoverflow.com/questions/5762491/how-to-print-color-in-console-using-system-out-println
 * Console color
 */
@EnableConfigServer
@SpringBootApplication
public class ConfigurationApplication {

    public static void main(String[] args) {
        SpringApplication.run(ConfigurationApplication.class, args);
    }

}
