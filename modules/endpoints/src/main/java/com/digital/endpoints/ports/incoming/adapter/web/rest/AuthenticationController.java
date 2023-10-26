package com.digital.endpoints.ports.incoming.adapter.web.rest;

import com.digital.endpoints.infrastructure.config.frameworks.security.service.AuthenticationService;
import com.digital.endpoints.infrastructure.web.request.SignInRequest;
import com.digital.endpoints.infrastructure.web.request.SignUpRequest;
import com.digital.endpoints.infrastructure.web.response.JwtAuthenticationResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 10/10/23
 * Project : com.digital.system
 */
@Slf4j
@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("/sign-up")
    public ResponseEntity<JwtAuthenticationResponse> signUp(@RequestBody @Valid SignUpRequest request) {
        log.info(">>>>>>> Request signing up a new user: {}", request.email());
        return ResponseEntity.ok(authenticationService.signUp(request));
    }

    @PostMapping("/sign-in")
    public ResponseEntity<JwtAuthenticationResponse> signIn(@RequestBody @Valid SignInRequest request) {
        log.info(">>>>>>> Request signing in existing user: {}", request.email());
        return ResponseEntity.ok(authenticationService.signIn(request));
    }
}
