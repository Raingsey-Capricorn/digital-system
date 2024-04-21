package com.digital.system.service.authentication.infrastructure.exception;

import com.digital.system.service.authentication.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.system.service.authentication.infrastructure.utilities.RegExpressionUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

import java.net.URI;
import java.security.SignatureException;
import java.util.HashMap;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/10/23
 * Project : com.digital.system
 */
@Slf4j
@RestControllerAdvice
public class ExceptionControllerAdvisor {

    @SneakyThrows
    @ExceptionHandler(value = SignatureException.class)
    public ResponseEntity<Object> handleJWTSignatureException(
            final WebRequest request) {

        final var errorResponseMap = new HashMap<String, String>();
        final var uri = new URI(((ServletWebRequest) request).getRequest().getRequestURI());
        final var errorBody = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        errorBody.setProperty("details", errorResponseMap);
        errorBody.setTitle(SignatureException.class.getSimpleName());
        errorBody.setStatus(HttpStatus.BAD_REQUEST.value());
        errorBody.setStatus(HttpStatus.BAD_REQUEST);
        errorBody.setInstance(uri);
        errorBody.setType(uri);
        return ResponseEntity.badRequest().body(errorBody);
    }

    /**
     * @param notValidException
     * @param request
     * @return
     */
    @SneakyThrows
    @ExceptionHandler(value = {MethodArgumentNotValidException.class})
    public ResponseEntity<Object> handleInvalidMethodArguments(
            final MethodArgumentNotValidException notValidException,
            final WebRequest request) {

        final var errorResponseMap = new HashMap<String, String>();
        notValidException
                .getFieldErrors()
                .forEach(objectError -> errorResponseMap.put(
                        objectError.getField(),
                        objectError.getDefaultMessage())
                );

        final var uri = new URI(((ServletWebRequest) request).getRequest().getRequestURI());
        final var errorBody = notValidException.getBody();
        errorBody.setProperty("details", errorResponseMap);
        errorBody.setTitle(notValidException.getMessage().substring(0, 10));
        errorBody.setStatus(HttpStatus.BAD_REQUEST.value());
        errorBody.setStatus(HttpStatus.BAD_REQUEST);
        errorBody.setInstance(uri);
        errorBody.setType(uri);
        return ResponseEntity.badRequest().body(errorBody);
    }

    /**
     * @param notReadableException ; this exception is thrown when enumeration value are used in the request body
     * @param request
     * @return
     */
    @SneakyThrows
    @ExceptionHandler({HttpMessageNotReadableException.class})
    protected ResponseEntity<Object> handleMethodArgumentUnreadable(
            final HttpMessageNotReadableException notReadableException,
            final WebRequest request) {

        final var errorResponseMap = new HashMap<String, String>();
        final var details = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        final var uri = new URI(((ServletWebRequest) request).getRequest().getRequestURI());
        final var exMessage = notReadableException.getMostSpecificCause().getMessage();
        final var regOfClass = RegExpressionUtil.getValue("\\`.*?\\`", exMessage).replace("`", "");

        if (Class.forName(regOfClass).isAssignableFrom(AuthorizationRole.class)) {
            final var regOfRequestField = RegExpressionUtil.getValue("(\\[\").*(\"\\])", exMessage)
                    .replace("[\"", "").replace("\"]", "");
            errorResponseMap.put(regOfRequestField, "Is invalid");
            details.setTitle("Invalid request content type");
            details.setDetail("Authority value : accept only {ADMIN,USER,SYSTEM,ANONYMOUS}");
            details.setProperty("details", errorResponseMap);
            details.setStatus(HttpStatus.BAD_REQUEST.value());
            details.setStatus(HttpStatus.BAD_REQUEST);
            details.setInstance(uri);
            details.setType(uri);
        }
        return ResponseEntity.badRequest().body(details);
    }
}
