package com.github.adamzv.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class GarbidzApplication {

    public static void main(String[] args) {
        SpringApplication.run(GarbidzApplication.class, args);
    }

}
