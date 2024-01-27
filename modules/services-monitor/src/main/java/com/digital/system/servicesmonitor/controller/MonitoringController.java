package com.digital.system.servicesmonitor.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 26/1/24
 * Project : com.digital.system
 */
@RestController
@RequestMapping("/monitor")
public class MonitoringController {
    @GetMapping()
    public ResponseEntity<?> getIndex() {
        return ResponseEntity.ok("Hello ! Monitor");
    }
}
