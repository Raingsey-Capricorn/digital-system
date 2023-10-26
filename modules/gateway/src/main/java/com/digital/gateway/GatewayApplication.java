package com.digital.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * <a href="https://www.toptal.com/spring/spring-security-tutorial">Spring Security with JWT for REST API</a>
 * <a href="https://www.linkedin.com/pulse/securing-resources-apigatewayspring-cloud-gateway-rodrigo-rodrigues">Securing resources with ApiGateway(spring-cloud-gateway)</a>
 * <a href="https://auth0.com/blog/spring-boot-authorization-tutorial-secure-an-api-java/">Spring Boot Authorization Tutorial: Secure an API (Java)</a>
 * <a href="https://www.bezkoder.com/spring-boot-jwt-authentication/">Spring Boot Token based Authentication with Spring Security & JWT</a>
 * <a href="https://medium.com/@rajithgama/spring-cloud-gateway-security-with-jwt-23045ba59b8a">Spring Cloud Gateway security with JWT</a>
 * <a href="https://roytuts.com/spring-cloud-gateway-security-with-jwt-json-web-token/">Spring Cloud Gateway Security with JWT (JSON Web Token)</a>
 */
@EnableDiscoveryClient
@SpringBootApplication
public class GatewayApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(GatewayApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }

}
