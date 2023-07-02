package com.github.adamzv.backend.exception;

public class RegionNotFoundException extends RuntimeException {
    public RegionNotFoundException(Long id) {
        super("Could not find region with id: " + id);
    }
}
