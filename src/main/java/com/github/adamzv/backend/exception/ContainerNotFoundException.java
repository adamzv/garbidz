package com.github.adamzv.backend.exception;

public class ContainerNotFoundException extends RuntimeException {
    public ContainerNotFoundException(Long id) {
        super("Could not find container with id: " + id);
    }
}