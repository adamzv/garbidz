package com.github.adamzv.backend.exception;

public class EmptyPasswordException extends RuntimeException{
    public EmptyPasswordException(){
        super ("Password can't be empty!");
    }
}
