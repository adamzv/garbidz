package com.github.adamzv.backend.exception;

public class RoleNotFoundException extends RuntimeException {
    public RoleNotFoundException(Long id) {
        super("Could not find role with id: " + id);
    }
}
