package com.digital.endpoints.config.security.service;

import com.digital.endpoints.config.constants.AuthorizationRole;
import com.digital.endpoints.config.security.AuthenticationServiceProvider;
import com.digital.endpoints.config.security.JWTService;
import com.digital.endpoints.domain.vo.UserEntityVO;
import com.digital.endpoints.ports.incoming.request.SignInRequest;
import com.digital.endpoints.ports.incoming.request.SignUpRequest;
import com.digital.endpoints.ports.incoming.response.JwtAuthenticationResponse;
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

    private final JWTService jwtService;
    private final PasswordEncoder passwordEncoder;
    private final RepositoryUserService userService;
    private final AuthenticationManager authenticationManager;

    /**
     * @param request : SignUpRequest
     * @return JwtAuthenticationResponse's instance
     * @see SignUpRequest#SignUpRequest(String, String, String, String)
     */
    @Override
    public JwtAuthenticationResponse signUp(SignUpRequest request) {

        AtomicReference<JwtAuthenticationResponse> response = new AtomicReference<>();
        var user = new UserEntityVO()
                .setFirstName(request.getFirstName())
                .setLastName(request.getLastName())
                .setEmail(request.getEmail())
                .setPassword(passwordEncoder.encode(request.getPassword()))
                .setRole(AuthorizationRole.USER);

        Optional.ofNullable(userService.save(user))
                .ifPresent(entityVO -> response.set(JwtAuthenticationResponse
                        .builder()
                        .token(jwtService.generateToken(user))
                        .build()
                ));
        log.info("<<<<<<< User {} signed up successfully.", user.getEmail());
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
                        request.getEmail(),
                        request.getPassword())
        );
        AtomicReference<JwtAuthenticationResponse> response = new AtomicReference<>();
        Optional.ofNullable(userService.userDetailsService()
                        .loadUserByUsername(request.getEmail()))
                .ifPresent(entityVO -> response.set(JwtAuthenticationResponse
                        .builder()
                        .token(jwtService.generateToken(entityVO))
                        .build()
                ));
        log.info("<<<<<<< User {} signed in successfully.", request.getEmail());
        return response.get();
    }
}
