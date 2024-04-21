package com.digital.system.service.authentication.infrastructure.config.frameworks.security;

import com.digital.system.service.authentication.infrastructure.web.request.SignInRequest;
import com.digital.system.service.authentication.infrastructure.web.request.SignUpRequest;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
public interface AuthenticationServiceProvider<T> {
    T signUp(SignUpRequest request);

    T signIn(SignInRequest request);
}
