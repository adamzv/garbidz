package com.github.adamzv.backend.exception;

import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class GlobalControllerAdvice extends ResponseEntityExceptionHandler {

    //400
    // TODO java: method does not override or implement a method from a supertype
    protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        String error = "Malformed JSON request";
        return buildResponseEntity(new ApiError(HttpStatus.BAD_REQUEST, error, ex));
    }

    private ResponseEntity<Object> buildResponseEntity(ApiError apiError) {
        return new ResponseEntity<>(apiError, apiError.getStatus());
    }

    //404
    @ExceptionHandler(AddressNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            AddressNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ComplaintNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            ComplaintNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ContainerNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            ContainerNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ContainerTypeNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            ContainerTypeNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(RegionNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            RegionNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ReportNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            ReportNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(RoleNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            RoleNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ScheduleNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            ScheduleNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(ImATeapotException.class)
    protected ResponseEntity<Object> handleTeaúptInternalErrorException(ImATeapotException ex){
        ApiError apiError = new ApiError(HttpStatus.I_AM_A_TEAPOT);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(TownNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            TownNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(UserNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            UserNotFoundException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    @ExceptionHandler(RuntimeException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            RuntimeException ex) {
        ApiError apiError = new ApiError(HttpStatus.NOT_FOUND);
        apiError.setMessage(ex.getMessage());
        return buildResponseEntity(apiError);
    }

    //401
    @ExceptionHandler(HttpClientErrorException.Unauthorized.class)
    protected ResponseEntity<Object> handleUnauthorized(){
        ApiError apiError = new ApiError(HttpStatus.UNAUTHORIZED);
        apiError.setMessage("Unauthorized access!");
        return buildResponseEntity(apiError);
    }

    //403
    @ExceptionHandler(HttpClientErrorException.Forbidden.class)
    protected ResponseEntity<Object> handleForbidden(){
        ApiError apiError = new ApiError(HttpStatus.FORBIDDEN);
        apiError.setMessage("Forbidden request!");
        return buildResponseEntity(apiError);
    }

    //409
    @ExceptionHandler(DataIntegrityViolationException.class)
    protected ResponseEntity<Object> handleConflict(){
        ApiError apiError = new ApiError(HttpStatus.CONFLICT);
        apiError.setMessage("There is a conflict with the current state of the target resource!");
        return buildResponseEntity(apiError);
    }

    //410
    @ExceptionHandler(HttpClientErrorException.Gone.class)
    protected ResponseEntity<Object> handleGone(){
        ApiError apiError = new ApiError(HttpStatus.GONE);
        apiError.setMessage("Gone!");
        return buildResponseEntity(apiError);
    }

    //500
    @ExceptionHandler(HttpServerErrorException.InternalServerError.class)
    protected ResponseEntity<Object> handleUncaughtException(){
        ApiError apiError = new ApiError(HttpStatus.INTERNAL_SERVER_ERROR);
        apiError.setMessage("Internal server error!");
        return buildResponseEntity(apiError);
    }

    //501
    @ExceptionHandler(HttpServerErrorException.NotImplemented.class)
    protected ResponseEntity<Object> handleNotImplemented(){
        ApiError apiError = new ApiError(HttpStatus.NOT_IMPLEMENTED);
        apiError.setMessage("Functionality is not implemented in the system!");
        return buildResponseEntity(apiError);
    }

    //502
    @ExceptionHandler(HttpServerErrorException.BadGateway.class)
    protected ResponseEntity<Object> handleBadGateway(){
        ApiError apiError = new ApiError(HttpStatus.BAD_GATEWAY);
        apiError.setMessage("Bad Gateway!");
        return buildResponseEntity(apiError);
    }

    //503
    @ExceptionHandler(HttpServerErrorException.ServiceUnavailable.class)
    protected ResponseEntity<Object> handleServiceUnavailable(){
        ApiError apiError = new ApiError(HttpStatus.SERVICE_UNAVAILABLE);
        apiError.setMessage("Server is currently unavailable!");
        return buildResponseEntity(apiError);
    }
}
