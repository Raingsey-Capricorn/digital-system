package com.digital.endpoints.infrastructure.config.frameworks.security.constants;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 19/10/23
 * Project : com.digital.system
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public abstract class Authority {
    public static final String ROLE_PREFIX = "ROLE_";
    public static final String ROLE_ADMIN = "ADMIN";
    public static final String ROLE_USER = "USER";
}
