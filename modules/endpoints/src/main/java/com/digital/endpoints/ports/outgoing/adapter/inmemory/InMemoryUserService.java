package com.digital.endpoints.ports.outgoing.adapter.inmemory;

import com.digital.endpoints.domain.business.UserEntityModel;
import com.digital.endpoints.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.endpoints.ports.outgoing.UserService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 * In-memory UserDetails auth :
 * <a href="https://www.baeldung.com/spring-security-login">Spring Security Form Login</a>
 */

@Slf4j
@Getter
@Service
@RequiredArgsConstructor
public class InMemoryUserService implements UserService {

    @Value("${spring.security.user.name}")
    private String username;

    @Value("${spring.security.user.password}")
    private String password;

    /**
     * In-memory users for testing, non-database execution
     * New implementation, we don't recommend using <strong>User.withDefaultPasswordEncoder()....</strong>
     *
     * @return Users with authentication and roles,
     */
    @Override
    public UserDetailsService userDetailsService() {

        log.info(">>> load in-memory user details for authentication");
        final List<UserDetails> dummyUsers = Arrays.asList(
                buildUserDetails(
                        String.format("%s@sample.com", username),
                        username,
                        String.format("%s-Sample", username),
                        password,
                        AuthorizationRole.SYSTEM),
                buildUserDetails(
                        "admin@digitalsystem.com",
                        "Admin_lastName",
                        "Admin_firstName",
                        "admin@123ADMIN",
                        AuthorizationRole.ADMIN),
                buildUserDetails(
                        "user@digitalsystem.com",
                        "User_lastName",
                        "User_firstName",
                        "user@123USER",
                        AuthorizationRole.USER),
                buildUserDetails(
                        "anonymous@sample.com",
                        "anonymous",
                        "anonymous",
                        "anonymous",
                        AuthorizationRole.ANONYMOUS)
        );
        return new InMemoryUserDetailsManager(dummyUsers);
    }

    /**
     * @param email    : parameter email
     * @param fistName : parameter fistName
     * @param lastName : parameter lastName
     * @param password : parameter password
     * @param role     : parameter role
     * @return UserDetails instance
     */
    private UserDetails buildUserDetails(
            final String email,
            final String fistName,
            final String lastName,
            final String password,
            final AuthorizationRole role) {

        final PasswordEncoder encoder = new BCryptPasswordEncoder();
        return User.withUserDetails(new UserEntityModel()
                .setEmail(email)
                .setLastName(lastName)
                .setFirstName(fistName)
                .setRole(role)
                .setPassword(encoder.encode(password))
        ).build();
    }
}
