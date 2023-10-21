package com.digital.endpoints.ports.incoming.adapter.web.rest;

import com.digital.endpoints.ports.incoming.MessageInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Slf4j
@RestController
@RequestMapping("/api/v1")
public class MessageController implements MessageInterface {

    @Override
    @GetMapping("/message")
    public ResponseEntity<?> testMessage() {
        log.info(">>>> Simple message from endpoint.");
        return ResponseEntity.ok("Hello");
    }
}
