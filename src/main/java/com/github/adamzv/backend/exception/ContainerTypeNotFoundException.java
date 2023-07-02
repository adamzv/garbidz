package com.github.adamzv.backend.exception;

public class ContainerTypeNotFoundException extends RuntimeException {
    public ContainerTypeNotFoundException(Long id) {
        super("Could not find container type with id: " + id);
    }
}