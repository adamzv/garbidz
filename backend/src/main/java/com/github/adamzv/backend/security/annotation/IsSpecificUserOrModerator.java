package com.github.adamzv.backend.security.annotation;

import org.springframework.security.access.prepost.PostAuthorize;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@PostAuthorize("returnObject.username == authentication.principal || hasRole('MODERATOR')")
public @interface IsSpecificUserOrModerator {
}
