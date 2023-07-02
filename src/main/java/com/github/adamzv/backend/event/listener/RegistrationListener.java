package com.github.adamzv.backend.event.listener;

import com.github.adamzv.backend.event.OnRegistrationCompleteEvent;
import com.github.adamzv.backend.model.ConfirmationToken;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.ConfirmationTokenRepository;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {

    private ConfirmationTokenRepository confirmationTokenRepository;
    private JavaMailSender mailSender;

    public RegistrationListener(ConfirmationTokenRepository confirmationTokenRepository, JavaMailSender mailSender) {
        this.confirmationTokenRepository = confirmationTokenRepository;
        this.mailSender = mailSender;
    }

    @Override
    @Async
    public void onApplicationEvent(OnRegistrationCompleteEvent onRegistrationCompleteEvent) {
        sendConfirmationEmail(onRegistrationCompleteEvent);
    }

    private void sendConfirmationEmail(OnRegistrationCompleteEvent event) {
        User user = event.getUser();

        ConfirmationToken token = new ConfirmationToken();
        token.setUser(user);
        token.setToken(generateToken());

        confirmationTokenRepository.save(token);

        String userEmail = user.getEmail();
        String subject = "Garbidž | Complete registration";
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(userEmail);
        email.setSubject(subject);
        email.setText("Your verification code is: " + token.getToken());
        mailSender.send(email);
    }

    private String generateToken() {

        // random != unique
        // amazing verification code generation (✿◠‿◠)
        String token = RandomStringUtils.randomAlphanumeric(6).toUpperCase();

        // since there is a possibility of token collision we will keep checking until a new token is generated
        while (!confirmationTokenRepository.findByToken(token).isEmpty()) {
            token = RandomStringUtils.randomAlphanumeric(6).toUpperCase();
        }
        return token;
    }
}
