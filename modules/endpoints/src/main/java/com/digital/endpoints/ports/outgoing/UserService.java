package com.digital.endpoints.ports.outgoing;

import org.springframework.security.core.userdetails.ReactiveUserDetailsService;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
public interface UserService {
    UserDetailsService userDetailsService();

}
