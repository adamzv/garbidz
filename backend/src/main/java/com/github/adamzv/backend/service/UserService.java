package com.github.adamzv.backend.service;

import com.github.adamzv.backend.exception.*;
import com.github.adamzv.backend.model.*;
import com.github.adamzv.backend.model.dto.ContainerRegistrationDTO;
import com.github.adamzv.backend.model.dto.UserFinishDTO;
import com.github.adamzv.backend.model.dto.UserRegistrationDTO;
import com.github.adamzv.backend.repository.*;
import org.passay.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private AddressRepository addressRepository;
    private ContainerRepository containerRepository;
    private ConfirmationTokenRepository confirmationTokenRepository;
    private ContainerUserRepository containerUserRepository;


    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    public UserService(UserRepository userRepository, RoleRepository roleRepository, AddressRepository addressRepository,
                       ContainerRepository containerRepository, ConfirmationTokenRepository confirmationTokenRepository,
                       ContainerUserRepository containerUserRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.addressRepository = addressRepository;
        this.containerRepository = containerRepository;
        this.confirmationTokenRepository = confirmationTokenRepository;
        this.containerUserRepository = containerUserRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // TODO: refactor everything to return ResponseEntity
    public User createUser(UserRegistrationDTO userDTO) {
        try {
            User user = new User();
            user.setId(0L);

            //validate the password
            if (isValid(userDTO.getPassword(), false)) {
                user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
            }

            user.setEmail(userDTO.getEmail());
            user.setName(userDTO.getName());
            user.setSurname(userDTO.getSurname());
            user.setEnabled(false);

            // Set user role
            // only admin / moderators can add other roles
            Set<Role> roles = new HashSet<>();
            Role role = roleRepository.findByRole(ERole.ROLE_USER)
                    .orElseThrow(() -> new RoleNotFoundException());
            roles.add(role);
            user.setRoles(roles);
            return userRepository.save(user);
        } catch (Exception e) {
            if (e.getMessage().contains("email")) {
                throw new EmailExistsException();
            } else {
                throw e;
            }
        }
    }

    public User finishUserRegistration(UserFinishDTO userDTO, String email) {
        User user = userRepository.findUserByEmail(email);

        Address address = addressRepository.findById(userDTO.getAddressId())
                .orElseThrow(() -> new AddressNotFoundException(userDTO.getAddressId()));
        user.setAddress(address);

        // let's do some magic here with containers
        // according to design containers are already assigned to address before user is registered
        // so for assigning containers to users, frontend has to send address id and type (String)
        Set<Container> containers = containerRepository.findAllByAddress_Id(userDTO.getAddressId());
        Set<Container> userContainers = containers.stream().filter(container -> userDTO.getContainers().stream()
                .map(ContainerRegistrationDTO::getType)
                .collect(Collectors.toSet())
                .contains(container.getType()))
                .collect(Collectors.toSet());

        Set<ContainerUser> set = userContainers.stream()
                .map(container -> new ContainerUser(container, user))
                .collect(Collectors.toSet());
        user.setContainerUser(set);
        set.forEach(s -> containerUserRepository.save(s));
        return user;
    }

    public User upgradeRole(Long id, ERole role) {
        // TODO: update setting roles
        return null;
    }

    public User updateUser(Long id, User newUser) {
        User oldUser = this.getUser(id);
        return userRepository.findById(id)
                .map(user -> {
                    if (!newUser.getName().isEmpty()) {
                        user.setName(newUser.getName().substring(0, 1).toUpperCase() + newUser.getName().substring(1));
                    } else {
                        user.setName(oldUser.getName());
                    }
                    if (!newUser.getSurname().isEmpty()) {
                        user.setSurname(newUser.getSurname().substring(0, 1).toUpperCase() + newUser.getSurname().substring(1));
                    } else {
                        user.setSurname(oldUser.getSurname());
                    }
                    if (!newUser.getEmail().isEmpty()) {
                        user.setEmail(newUser.getEmail());
                    } else {
                        user.setEmail(oldUser.getEmail());
                    }
                    if (!newUser.getPassword().isEmpty()) {
                        if (!(newUser.getPassword().length() >= 60)) {
                            if (isValid(newUser.getPassword(), true)) {
                                user.setPassword(passwordEncoder.encode(newUser.getPassword()));
                            }
                        }
                    } else {
                        user.setPassword(oldUser.getPassword());
                    }
                    if (!newUser.getToken().getToken().isEmpty()) {
                        user.setToken(newUser.getToken());
                    } else {
                        user.setToken(oldUser.getToken());
                    }

                    user.setAddress(addressRepository.findById(newUser.getAddress().getId())
                            .orElseThrow(() -> new AddressNotFoundException(newUser.getAddress().getId())));
                    return userRepository.save(user);
                })
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    public User updateUserToken(Long id, User newUser) {
        return userRepository.findById(id)
                .map(user -> {
                    user.setToken(newUser.getToken());
                    return userRepository.save(user);
                })
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public User getUser(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    public User getUserByEmail(String email) {
        return userRepository.findUserByEmail(email);
    }

    public Page<User> getUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    public boolean isValid(final String password, final boolean update) {
        if (!password.isEmpty()) {
            final PasswordValidator validator;
            final RuleResult result;
            if (!update) {
                validator = new PasswordValidator(Arrays.asList(
                        new WhitespaceRule(),
                        new LengthRule(8, 16),
                        new CharacterRule(EnglishCharacterData.UpperCase, 1),
                        new CharacterRule(EnglishCharacterData.Digit, 1),
                        new CharacterRule(EnglishCharacterData.Special, 1)));

            } else {
                validator = new PasswordValidator(Arrays.asList(
                        new WhitespaceRule(),
                        new LengthRule(1, 60),
                        new CharacterRule(EnglishCharacterData.UpperCase, 1),
                        new CharacterRule(EnglishCharacterData.Digit, 1),
                        new CharacterRule(EnglishCharacterData.Special, 1)));
            }
            result = validator.validate(new PasswordData(password));
            if (result.isValid()) {
                return true;
            } else {
                throw new InvalidPasswordException(validator.getMessages(result));
            }
        } else {
            throw new EmptyPasswordException();
        }
    }

    public User confirmUser(String token) {
        ConfirmationToken cToken = confirmationTokenRepository.findByToken(token).orElseThrow(() -> new RuntimeException("Token not found"));

        if (!cToken.getUser().isEnabled()) {
            User user = getUserByEmail(cToken.getUser().getEmail());
            user.setEnabled(true);
            return userRepository.save(user);
        } else {
            return cToken.getUser();
        }
    }

}