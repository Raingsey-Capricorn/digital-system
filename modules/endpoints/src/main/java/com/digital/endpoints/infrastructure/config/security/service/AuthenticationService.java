package com.digital.endpoints.infrastructure.config.security.service;

import com.digital.endpoints.domain.vo.UserEntityVO;
import com.digital.endpoints.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.endpoints.infrastructure.config.security.AuthenticationServiceProvider;
import com.digital.endpoints.infrastructure.config.security.JWTService;
import com.digital.endpoints.infrastructure.web.request.SignInRequest;
import com.digital.endpoints.infrastructure.web.request.SignUpRequest;
import com.digital.endpoints.infrastructure.web.response.JwtAuthenticationResponse;
import com.digital.endpoints.ports.outgoing.adapter.repository.RepositoryUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthenticationService implements AuthenticationServiceProvider<JwtAuthenticationResponse> {

    private final AuthenticationManager authenticationManager;
    private final RepositoryUserService userService;
    private final PasswordEncoder passwordEncoder;
    private final JWTService jwtService;

    /**
     * @param request : SignUpRequest
     * @return JwtAuthenticationResponse's instance
     * @see SignUpRequest#SignUpRequest(String, String, String, String, AuthorizationRole)
     */
    @Override
    public JwtAuthenticationResponse signUp(SignUpRequest request) {

        var user = new UserEntityVO()
                .setFirstName(request.firstName())
                .setLastName(request.lastName())
                .setEmail(request.email())
                .setPassword(passwordEncoder.encode(request.password()))
                .setRole(AuthorizationRole.valueOf(request.role().name()));

        AtomicReference<JwtAuthenticationResponse> response = new AtomicReference<>();
        Optional.ofNullable(userService.save(user))
                .ifPresent(entityVO -> response.set(JwtAuthenticationResponse
                        .builder()
                        .token(jwtService.generateToken(user))
                        .build()
                ));
        return response.get();
    }

    /**
     * @param request : SignInRequest
     * @return JwtAuthenticationResponse's instance
     * @see SignInRequest#SignInRequest(String, String)
     */
    @Override
    public JwtAuthenticationResponse signIn(SignInRequest request) {

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.email(),
                        request.password())
        );

        AtomicReference<JwtAuthenticationResponse> response = new AtomicReference<>();
        Optional.ofNullable(userService.userDetailsService()
                        .loadUserByUsername(request.email()))
                .ifPresent(entityVO -> response.set(JwtAuthenticationResponse
                        .builder()
                        .token(jwtService.generateToken(entityVO))
                        .build()
                ));
        return response.get();
    }
}
