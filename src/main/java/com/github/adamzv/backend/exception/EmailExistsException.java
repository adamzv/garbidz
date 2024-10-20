package com.github.adamzv.backend.exception;

@SuppressWarnings("serial")
public class EmailExistsException extends RuntimeException{
    public EmailExistsException(){
        super("An account is already associated with this email address!");
    }
}
