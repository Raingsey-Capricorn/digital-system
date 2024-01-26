package com.digital.endpoints.infrastructure.models;

import org.springframework.security.core.userdetails.UserDetails;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 6/10/23
 * Project : com.digital.system
 */
public interface User extends UserDetails {

    @Override
    default boolean isAccountNonExpired() {
        return true;
    }

    @Override
    default boolean isAccountNonLocked() {
        return true;
    }

    @Override
    default boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    default boolean isEnabled() {
        return true;
    }

}
