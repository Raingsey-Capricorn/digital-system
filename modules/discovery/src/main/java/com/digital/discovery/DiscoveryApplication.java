package com.digital.discovery;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * <a href="https://www.codersarts.com/post/building-seamless-communication-between-microservices-with-spring-cloud-implementation-tips">
 * Building Seamless Communication Between Microservices with Spring Cloud: Implementation tips
 * </a>
 */
@EnableEurekaServer
@SpringBootApplication
public class DiscoveryApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(DiscoveryApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(DiscoveryApplication.class, args);
    }

}
