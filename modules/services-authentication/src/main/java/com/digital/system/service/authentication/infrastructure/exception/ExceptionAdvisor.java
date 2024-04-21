package com.digital.system.service.authentication.infrastructure.exception;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

import java.net.URI;
import java.util.HashMap;
import java.util.Objects;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/10/23
 * Project : com.digital.system
 */
@Slf4j
@RestControllerAdvice
public class ExceptionAdvisor {

    /**
     * @param ex
     * @param request
     * @return
     */
    @SneakyThrows
    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            final MethodArgumentNotValidException ex,
            final WebRequest request) {

        var detailsBodyMap = new HashMap<>();
        ex.getAllErrors().forEach(objectError ->
                detailsBodyMap.put(
                        Objects.requireNonNull(objectError.getArguments())[1],
                        objectError.getDefaultMessage()
                )
        );

        var uri = new URI(((ServletWebRequest) request).getRequest().getRequestURI());
        var errorBody = ex.getBody();
        errorBody.setTitle(ex.getMessage().substring(0, 10));
        errorBody.setInstance(uri);
        errorBody.setType(uri);
        errorBody.setStatus(HttpStatus.BAD_REQUEST);
        errorBody.setStatus(HttpStatus.BAD_REQUEST.value());
        errorBody.setDetail(detailsBodyMap.toString());

        return ResponseEntity
                .badRequest()
                .body(errorBody);
    }
}
