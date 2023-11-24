package com.digital.endpoints.infrastructure.config.security;

import com.digital.endpoints.infrastructure.web.request.SignInRequest;
import com.digital.endpoints.infrastructure.web.request.SignUpRequest;

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
