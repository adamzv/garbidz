package com.github.adamzv.backend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalControllerAdvice {

    @ExceptionHandler(RoleNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    String roleNotFoundHandler(RoleNotFoundException ex) {
        return ex.getMessage();
    }

    @ExceptionHandler(TownNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    String townNotFoundHandler(TownNotFoundException ex) {
        return ex.getMessage();
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    String runtimeException(RuntimeException ex) {
        return ex.getMessage();
    }
}
