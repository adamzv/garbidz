package com.github.adamzv.backend.exception;

public class RoleNotFoundException extends RuntimeException {
    public RoleNotFoundException() {
        super("Could not find role.");
    }
}
