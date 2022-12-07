package com.github.adamzv.backend.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.*;

@EnableWebSecurity
@Configuration
public class SecurityConfiguration {

    @Autowired
    private AuthEntryPointJwt unauthorizedHandler;

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // TODO
//    @Override
//    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
//    }


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> {
                    try {
                        auth
                                .requestMatchers(HttpMethod.POST, SIGN_UP_URL).permitAll()
                                .requestMatchers(HttpMethod.POST, SIGN_UP_URL).permitAll()
                                .requestMatchers(HttpMethod.POST, LOGIN_URL).permitAll()
                                .requestMatchers(HttpMethod.GET, CONFIRM_USER_URL).permitAll()
                                // AUTH_WHITELIST enables swagger
                                .requestMatchers(AUTH_WHITELIST).permitAll()
                                // since we want to use @PreAuthorize annotation to fine control method security
                                // we can't close API for not authenticated users here, because we won't be able to
                                // unlock method with @PreAuthorize
                                // https://dzone.com/articles/secure-a-spring-boot-app-with-spring-security-and
                                //.anyRequest().authenticated()
                                .and()
                                .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
                                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                });
        http.cors().and().csrf().disable();
        return http.build();
    }

}
