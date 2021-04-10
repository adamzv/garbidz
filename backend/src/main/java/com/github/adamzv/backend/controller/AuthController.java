package com.github.adamzv.backend.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.model.UserLogin;
import com.github.adamzv.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.*;

// TODO: logout endpoint with spring provided logout functionality probably won't work properly,
// so we have to figure out a way to invalidate token when user wants to logout.
// Token expiration is handled automatically, for manual invalidation we will probably have to create a blacklist
// eg.: https://stackoverflow.com/questions/21978658/invalidating-json-web-tokens
// or https://stackoverflow.com/questions/43569723/jwt-authentication-how-to-implement-logout

@RestController
@RequestMapping("/auth")
public class AuthController {

    private UserService userService;
    private AuthenticationManager authenticationManager;

    public AuthController(UserService userService, AuthenticationManager authenticationManager) {
        this.userService = userService;
        this.authenticationManager = authenticationManager;
    }

    // TODO: validation
    @PostMapping("/signup")
    public ResponseEntity<User> signupUser(@RequestBody User user) {
        return ResponseEntity.ok(userService.createUser(user));
    }

    @PostMapping("/signin")
    // TODO: use Map<String, String> instead of UserLogin model
    // TODO: validation
    public ResponseEntity<String> signinUser(@RequestBody UserLogin login) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(login.getUsername(), login.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwtToken = JWT.create()
                .withSubject(login.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + TOKEN_EXPIRATION))
                .sign(Algorithm.HMAC256(SECRET.getBytes()));

        User user = userService.getUserByEmail(login.getUsername());
        user.getToken().setToken(jwtToken);
        user.getToken().setRevoked(false);

        userService.updateUser(user.getId(), user);
        return ResponseEntity.ok(jwtToken);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logoutUser(HttpServletRequest request) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(null, null, null));

        String token = request.getHeader(HEADER_STRING);
        if (token != null) {
            try {
                String userSubject = JWT.require(Algorithm.HMAC256(SECRET.getBytes()))
                        .build()
                        .verify(token.replace(TOKEN_PREFIX, ""))
                        .getSubject();

                // revoke token in DB
                User user = userService.getUserByEmail(userSubject);
                user.getToken().setRevoked(true);
                userService.updateUser(user.getId(), user);
            } catch (TokenExpiredException e) {
                return ResponseEntity.ok("User is logged out");
            }
        }
        return ResponseEntity.ok("User is logged out");
    }
}
