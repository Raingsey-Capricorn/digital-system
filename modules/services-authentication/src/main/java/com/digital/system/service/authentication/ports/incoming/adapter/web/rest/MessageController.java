package com.digital.system.service.authentication.ports.incoming.adapter.web.rest;

import com.digital.system.service.authentication.infrastructure.web.response.PersonResponse;
import com.digital.system.service.authentication.ports.incoming.MessageInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/public")
@PreAuthorize(value = "hasAnyAuthority('ADMIN','SYSTEM','USER')")
public class MessageController implements MessageInterface {

    @Override
    @GetMapping("/message")
    public ResponseEntity<?> getMessage() {
        log.info(">>>> Simple message from endpoint.");
        return ResponseEntity.ok("Hello from Endpoint");
    }

    @Override
    @GetMapping("/person")
    public ResponseEntity<?> getResponseBody() {
        log.info(">>>> Simple response data from endpoint.");
        return ResponseEntity.ok(
                PersonResponse
                        .builder()
                        .id(UUID.randomUUID())
                        .gender("M")
                        .firstName("Sok")
                        .lastName("Chanrotha")
                        .build()
        );
    }
}
