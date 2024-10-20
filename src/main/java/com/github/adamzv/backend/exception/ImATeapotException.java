package com.github.adamzv.backend.exception;

public class ImATeapotException extends RuntimeException{
    public ImATeapotException(){
        super("I am a Teapot!");
    }
}
