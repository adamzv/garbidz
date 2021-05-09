package com.github.adamzv.backend.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {

    @Autowired
    private SimpMessagingTemplate template;

    @Scheduled(cron = "0 15 22 * * ?")
    public void cronJobSch() {
        template.convertAndSend("/topic/greetings", "Hello");
    }

    private void getListOfFutureSchedules() {

    }
}