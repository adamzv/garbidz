package com.github.adamzv.backend.security.configuration;

public class SecurityConfigurationConstants {
    public static final String SECRET = "SUPER_SECRET_STRING_PLEASE_CHANGE_ME";
    public static final String SIGN_UP_URL = "/auth/signup";
    public static final String LOGIN_URL = "/auth/signin";
    public static final String CONFIRM_USER_URL = "/auth/confirm";
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";

    // expiration length is set to one year (currently we don't have implemented refresh token)
    // and FE team does not want to handle sending request to /signin in background when token is about to expire
    public static final long TOKEN_EXPIRATION = 31_556_952_000L;//3_600_000;
    public static final String[] AUTH_WHITELIST = {
            // -- Swagger UI v2
            "/v2/api-docs",
            "/swagger-resources",
            "/swagger-resources/**",
            "/configuration/ui",
            "/configuration/security",
            "/swagger-ui.html",
            "/webjars/**",
            "/api/v2/api-docs",
            "/api/swagger-resources",
            "/api/swagger-resources/**",
            "/api/configuration/ui",
            "/api/configuration/security",
            "/api/swagger-ui.html",
            "/api/webjars/**",
            // -- Swagger UI v3 (OpenAPI)
            "/v3/api-docs/**",
            "/swagger-ui/**",
            "/api/v3/api-docs/**",
            "/api/swagger-ui/**"
    };

}
