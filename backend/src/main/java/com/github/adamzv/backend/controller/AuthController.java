package com.github.adamzv.backend.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.github.adamzv.backend.event.OnRegistrationCompleteEvent;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.model.UserToken;
import com.github.adamzv.backend.model.dto.UserFinishDTO;
import com.github.adamzv.backend.model.dto.UserLoginDTO;
import com.github.adamzv.backend.model.dto.UserRegistrationDTO;
import com.github.adamzv.backend.service.UserService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private UserService userService;
    private AuthenticationManager authenticationManager;
    private ApplicationEventPublisher eventPublisher;

    public AuthController(UserService userService, AuthenticationManager authenticationManager, ApplicationEventPublisher eventPublisher) {
        this.userService = userService;
        this.authenticationManager = authenticationManager;
        this.eventPublisher = eventPublisher;
    }

    @PostMapping("/signup")
    public ResponseEntity<User> signupUser(@RequestBody UserRegistrationDTO userDTO) {
        User user = userService.createUser(userDTO);
        eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user));

        return ResponseEntity.ok(user);
    }

    @GetMapping("/confirm")
    public ResponseEntity<User> confirmUser(@RequestParam("token") String token) {
        return ResponseEntity.ok(userService.confirmUser(token));
    }

    @PostMapping("/signin")
    public ResponseEntity<User> signinUser(@RequestBody UserLoginDTO login) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(login.getUsername(), login.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwtToken = JWT.create()
                .withSubject(login.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + TOKEN_EXPIRATION))
                .sign(Algorithm.HMAC256(SECRET.getBytes()));

        User user = userService.getUserByEmail(login.getUsername());

        if (user.getToken() == null) {
            UserToken token = new UserToken();
            token.setToken(jwtToken);
            token.setRevoked(false);
            user.setToken(token);
        } else {
            user.getToken().setToken(jwtToken);
            user.getToken().setRevoked(false);
        }

        return ResponseEntity.ok(userService.updateUserToken(user.getId(), user));
    }

    @PostMapping("/finish")
    public ResponseEntity<User> finishUserRegistration(@RequestBody UserFinishDTO userDTO) {
        return ResponseEntity.ok(userService.finishUserRegistration(userDTO, SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString()));
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
                userService.saveChanges(user);
            } catch (TokenExpiredException e) {
                return ResponseEntity.ok("User is logged out");
            }
        }
        return ResponseEntity.ok("User is logged out");
    }
}
