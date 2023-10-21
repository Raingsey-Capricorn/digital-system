package com.digital.endpoints.config.security;

import com.digital.endpoints.ports.incoming.request.SignInRequest;
import com.digital.endpoints.ports.incoming.request.SignUpRequest;

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
