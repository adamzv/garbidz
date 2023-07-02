package com.github.adamzv.backend.exception;

public class TownNotFoundException extends RuntimeException {
    public TownNotFoundException(Long id) {
        super("Could not find town with id: " + id);
    }
}
