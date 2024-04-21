package com.digital.system.service.authentication.infrastructure.config.frameworks.security.constants;

import java.util.Arrays;
import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
public enum AuthorizationRole {
    USER,
    ADMIN,
    SYSTEM,
    ANONYMOUS;

    /**
     * @return list of enumerated roles
     */
    public static List<AuthorizationRole> list() {
        return Arrays.asList(USER, ADMIN, SYSTEM, ANONYMOUS);
    }
}
