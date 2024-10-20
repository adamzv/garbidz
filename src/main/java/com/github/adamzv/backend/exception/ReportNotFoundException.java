package com.github.adamzv.backend.exception;

public class ReportNotFoundException extends RuntimeException {
    public ReportNotFoundException(Long id) {
        super("Could not find user report with id: " + id);
    }
}
