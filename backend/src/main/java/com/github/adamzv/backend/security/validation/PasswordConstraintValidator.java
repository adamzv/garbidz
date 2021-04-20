package com.github.adamzv.backend.security.validation;

import org.passay.*;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Arrays;

public class PasswordConstraintValidator implements ConstraintValidator<ValidPassword, String> {

    @Override
    public void initialize(final ValidPassword arg0) {

    }

    @Override
    public boolean isValid(final String password, final ConstraintValidatorContext context) {
        if (password.isEmpty() == false) {
            final PasswordValidator validator = new PasswordValidator(Arrays.asList(
                    new WhitespaceRule(),
                    new LengthRule(8, 16),
                    new CharacterRule(EnglishCharacterData.UpperCase, 1),
                    new CharacterRule(EnglishCharacterData.Digit, 1),
                    new CharacterRule(EnglishCharacterData.Special, 1)));
            final RuleResult result = validator.validate(new PasswordData(password));
            if (result.isValid()) {
                return true;
            } else {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Invalid password: " + validator.getMessages(result)).addConstraintViolation();
                return false;
            }
        }
        else{
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Invalid password: Password can't be empty!").addConstraintViolation();
            return false;
        }
    }
}
