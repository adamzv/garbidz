package com.github.adamzv.backend.exception;

public class AddressNotFoundException extends RuntimeException {
    public AddressNotFoundException(Long id) {
        super ("Could not find region with id: " + id);
    }

}
