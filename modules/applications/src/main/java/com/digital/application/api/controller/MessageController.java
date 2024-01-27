package com.digital.application.api.controller;

import com.digital.application.api.ControllerBase;
import com.digital.application.response.PersonResponse;
import com.digital.application.utils.TimeConversionUtil;
import com.digital.application.web.WebClientCommunicator;
import lombok.extern.java.Log;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.logging.Level;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 19/1/24
 * Project : com.digital.system
 */
@Log
@Component
@RestController
@RequestMapping("/message")
public class MessageController extends ControllerBase {

    @GetMapping("/")
    public ResponseEntity<?> getMessage() {

        var result = WebClientCommunicator
                .request("/api/v1/public/message")
                .exchangeToMono(response ->
                        response.statusCode().is2xxSuccessful() ?
                                response.bodyToMono(String.class) :
                                response.createException().flatMap(Mono::error)
                )
                .doOnError(throwable -> log.log(Level.FINER, throwable.getMessage()))
                .block(Duration.ofSeconds(60));
        return ResponseEntity.ok(result);
    }

    @GetMapping("/data")
    public ResponseEntity<?> getPerson() {

        var result = WebClientCommunicator
                .request("/api/v1/public/person")
                .exchangeToMono(response ->
                        response.statusCode().is2xxSuccessful() ?
                                response.bodyToMono(PersonResponse.class) :
                                response.createException().flatMap(Mono::error)
                ).doOnError(throwable -> log.log(Level.FINER, throwable.getMessage()))
                .block(Duration.ofSeconds(60));
        return ResponseEntity.ok(result);
    }

    @GetMapping("/hour-to-cardinal")
    public ResponseEntity<String> getCardinalTime(@RequestParam("time") String time) {
        return ResponseEntity.ok(TimeConversionUtil.numericToCardinalHours(time));
    }

}
