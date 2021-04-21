package com.github.adamzv.backend.exception;

import java.util.List;

public class InvalidPasswordException extends RuntimeException{
    public InvalidPasswordException (List message) {super("Invalid password: " + message);}
}
