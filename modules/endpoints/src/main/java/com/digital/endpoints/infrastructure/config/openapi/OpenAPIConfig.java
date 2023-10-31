package com.digital.endpoints.infrastructure.config.openapi;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 30/10/23
 * Project : com.digital.system
 * <a href="https://medium.com/@pubuduc.14/swagger-openapi-specification-3-integration-with-spring-cloud-gateway-part-2-1d670d4ab69a">
 * Swagger(OpenAPI Specification 3)
 * </a>
 */
@Configuration
@OpenAPIDefinition(info =
@io.swagger.v3.oas.annotations.info.Info(title = "API Gateway", version = "1.0", description = "Documentation API Gateway v1.0"))
public class OpenAPIConfig {

    /**
     * @param serviceTitle   : service title from application.yml
     * @param serviceVersion : service version from application.yml
     * @param url            : web application context URL from application.yml
     * @return OpenAPI's instance
     */
    @Bean
    public OpenAPI buildOpenAPI(
            @Value("${openapi.service.title}") String serviceTitle,
            @Value("${openapi.service.version}") String serviceVersion,
            @Value("${openapi.service.url}") String url) {

        final String securitySchemeName = "bearerAuth";
        return new OpenAPI()
                .servers(List.of(new Server().url(url)))
                .components(new Components().addSecuritySchemes(
                        securitySchemeName, new SecurityScheme()
                                .type(SecurityScheme.Type.HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")))
                .security(List.of(new SecurityRequirement().addList(securitySchemeName)))
                .info(new Info().title(serviceTitle).version(serviceVersion));
    }

}
