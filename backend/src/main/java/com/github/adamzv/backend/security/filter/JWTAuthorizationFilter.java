package com.github.adamzv.backend.security.filter;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.model.UserToken;
import com.github.adamzv.backend.security.service.UserDetailsServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.*;

public class JWTAuthorizationFilter extends BasicAuthenticationFilter {

    private static final Logger logger = LoggerFactory.getLogger(JWTAuthorizationFilter.class);

    private UserDetailsServiceImpl userService;

    public JWTAuthorizationFilter(AuthenticationManager authenticationManager, UserDetailsServiceImpl userService) {
        super(authenticationManager);
        this.userService = userService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String header = request.getHeader(HEADER_STRING);

        if (header == null || !header.startsWith(TOKEN_PREFIX)) {
            chain.doFilter(request, response);
            return;
        }

        UsernamePasswordAuthenticationToken authentication = getAuthentication(request);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        String token = request.getHeader(HEADER_STRING);
        if (token != null) {
            try {
                token = token.replace(TOKEN_PREFIX, "");
                String userFromToken = JWT.require(Algorithm.HMAC256(SECRET.getBytes()))
                        .build()
                        .verify(token.replace(TOKEN_PREFIX, ""))
                        .getSubject();

                if (userFromToken != null) {
                    User user = (User) userService.loadUserByUsername(userFromToken);

                    // check if token is not in blacklist
                    UserToken userToken = user.getToken();
                    if (!userToken.getRevoked()) {
                        if (token.equals(userToken.getToken())) {
                            return new UsernamePasswordAuthenticationToken(user.getUsername(), null, user.getAuthorities());
                        }
                    } else {
                        return null;
                    }
                }
            } catch (TokenExpiredException e) {
                // TODO: refresh token
                logger.error("TokenExpiredException");
                logger.error(e.getMessage());
                return null;
            } catch (JWTVerificationException ex) {
                logger.error("JWTVerificationException");
                logger.error(ex.getMessage());
                return null;
            }
            return null;
        }
        return null;
    }
}
