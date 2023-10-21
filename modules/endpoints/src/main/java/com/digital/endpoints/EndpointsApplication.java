package com.digital.endpoints;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * <a href="https://medium.com/@truongbui95/jwt-authentication-and-authorization-with-spring-boot-3-and-spring-security-6-2f90f9337421">Original Spring security - DB repository with JWT demo</a>
 * <a href="https://medium.com/code-with-farhan/spring-security-jwt-authentication-authorization-a2c6860be3cf">Original Spring security - DB repository with JWT demo - similar</a>
 * <a href="https://www.baeldung.com/java-hmac">HMAC in Java - how to generate <strong>hmacShaKey</strong></a>
 * <a href="https://www.javadevjournal.com/spring/spring-security-success-handler/">Original Spring security - DB repository demo</a>
 * <a href="https://www.kindsonthegenius.com/introduction-to-spring-security-a-practical-tutorial/">Original Spring security - InMemory repository demo</a>
 * <a href="https://docs.spring.io/spring-security/reference/5.8/migration/servlet/config.html">Configuration Migrations 5.8.8</a>
 * <a href="https://docs.spring.io/spring-security/reference/servlet/authorization/authorize-http-requests.html">New implementation for SS v6.1.5</a>
 */
@EnableDiscoveryClient
@SpringBootApplication
public class EndpointsApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(EndpointsApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(EndpointsApplication.class, args);
    }

}
