package com.digital.system.service.authentication.ports.incoming;

import org.springframework.http.ResponseEntity;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
public interface MessageInterface {

    ResponseEntity<?> getMessage();
    ResponseEntity<?> getResponseBody();
}
