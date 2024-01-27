package com.digital.endpoints.infrastructure.config.frameworks.security;

import com.digital.endpoints.infrastructure.config.frameworks.security.filter.JWTAuthenticationFilter;
import com.digital.endpoints.infrastructure.config.frameworks.security.constants.Authority;
import com.digital.endpoints.ports.outgoing.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 * Overall project implementation ->
 * <a href="https://medium.com/@truongbui95/jwt-authentication-and-authorization-with-spring-boot-3-and-spring-security-6-2f90f9337421">JWT Authentication and Authorization with Spring Boot 3 and Spring Security 6</a>
 * Login/Logout success :
 * <a href="https://springjavatutorial.medium.com/spring-security-customise-login-and-logout-in-spring-boot-b64550cde965">Spring Security Customise Login and Logout in Spring Boot</a>
 * Spring security modernized version :
 * <a href="https://spring.io/blog/2022/02/21/spring-security-without-the-websecurityconfigureradapter">Spring Security without the WebSecurityConfigurerAdapter</a>
 * Apply formLogin(...) :
 * <a href="https://stackoverflow.com/questions/76601152/spring-security-6-form-login-does-not-create-a-login-controller">Spring Security 6 Form Login does not create a login controller</a>
 * !!!>>>.formLogin(Customizer.withDefaults())
 * <p>
 *
 * <a href="https://docs.spring.io/spring-security/reference/5.8/migration/servlet/config.html">New implementation of spring authorizeRequest</a>
 * This is new implementation, and require to apply override
 * spring.main.allow-bean-definition-overriding= true
 */
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfiguration {
    public static final String LOGIN_URL = "/login";
    public static final String LOGOUT_URL = "/logout";
    public static final String LOGIN_FAIL_URL = LOGIN_URL + "?error";
    public static final String AUTHORIZED_VIEW_URL = "/api/v1/view/**";
    public static final String ADMIN_AUTHORIZED_URL = "/api/v1/admin/**";
    public static final String AUTHORIZATION_URL = "/api/v1/auth/**";
    public static final String HEALTH_CHECK = "/health";
    private static final String[] OPEN_APIS_V3 = {
            "configuration/**",
            "/api/auth/**",
            "/v3/api-docs/**",
            "/swagger*/**",
            "/swagger-ui/**",
            "/webjars/**"
    };

    private final UserService userService;
    private final JWTAuthenticationFilter filter;

    /**
     * @param httpSecurity
     * @return
     * @throws Exception
     */
    @Bean
    public SecurityFilterChain chain(
            final HttpSecurity httpSecurity
    ) throws Exception {

        httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .exceptionHandling(Customizer.withDefaults())
                .authorizeHttpRequests(matcherRegistry ->
                        matcherRegistry
                                .requestMatchers(ADMIN_AUTHORIZED_URL).hasAuthority(Authority.ROLE_ADMIN)
                                .requestMatchers(AUTHORIZATION_URL).permitAll()
                                .requestMatchers(HEALTH_CHECK).permitAll()
                                .requestMatchers(OPEN_APIS_V3).permitAll()
                                .anyRequest()
                                .authenticated()
                )
                .authenticationProvider(authenticationProvider())
                .addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class)
                .sessionManagement(manager -> manager.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        ;
        return httpSecurity.build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setPasswordEncoder(passwordEncoder());
        authProvider.setUserDetailsService(userService.userDetailsService());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(
            final AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}