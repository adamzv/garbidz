package com.github.adamzv.backend.exception;

public class ComplaintNotFoundException extends RuntimeException {
    public ComplaintNotFoundException(Long id) {
        super("Could not find user complaint with id: " + id);
    }
}
