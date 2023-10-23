package com.digital.endpoints.ports.incoming.adapter.authorized.rest;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 18/10/23
 * Project : com.digital.system
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admin")
@PreAuthorize(value = "hasAuthority('ADMIN')")
public class AuthorizedController {

    @GetMapping
    public ResponseEntity<?> defaultMessage() {

        log.info(">>>> Admin access - requested");
        return ResponseEntity.ok("ADMIN - access");
    }
}