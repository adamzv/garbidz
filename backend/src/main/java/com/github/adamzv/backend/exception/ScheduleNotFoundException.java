package com.github.adamzv.backend.exception;

public class ScheduleNotFoundException extends RuntimeException {
    public AddressNotFoundException(Long id) {
        super("Could not find schedule type with id: " + id);
    }
}