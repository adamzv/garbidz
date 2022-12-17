package com.github.adamzv.backend.service;

import com.github.adamzv.backend.exception.*;
import com.github.adamzv.backend.model.*;
import com.github.adamzv.backend.model.dto.ContainerRegistrationDTO;
import com.github.adamzv.backend.model.dto.UserFinishDTO;
import com.github.adamzv.backend.model.dto.UserRegistrationDTO;
import com.github.adamzv.backend.model.dto.UserUpdateDTO;
import com.github.adamzv.backend.repository.*;
import lombok.AllArgsConstructor;
import org.passay.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private AddressRepository addressRepository;
    private ContainerRepository containerRepository;
    private ConfirmationTokenRepository confirmationTokenRepository;


    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

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
            user.setName(userDTO.getName().substring(0, 1).toUpperCase() + userDTO.getName().substring(1));
            user.setSurname(userDTO.getSurname().substring(0, 1).toUpperCase() + userDTO.getSurname().substring(1));
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

        setContainersToUser(user, userDTO.getAddressId(), userDTO.getContainers());
        return userRepository.save(user);
    }

    public User upgradeRole(Long id, ERole role) {
        User user = userRepository.findById(id).orElseThrow(() -> new UserNotFoundException(id));
        Role newRole = roleRepository.findByRole(role).orElseThrow(() -> new RoleNotFoundException());
        Set<Role> roles = user.getRoles();
        roles.add(newRole);
        if (roles.stream().filter(role1 -> role1.getRole().equals(ERole.ROLE_ADMIN)).findAny().isPresent() &&
                roles.stream().filter(role1 -> role1.getRole().equals(ERole.ROLE_MODERATOR)).findAny().isEmpty()) {
            roles.add(roleRepository.findByRole(ERole.ROLE_MODERATOR).orElseThrow(() -> new RoleNotFoundException()));
        }
        user.setRoles(roles);
        return userRepository.save(user);
    }

    public User saveChanges(User user) {
        return userRepository.save(user);
    }

    public User updateUser(Long id, UserUpdateDTO newUser) {
        User oldUser = this.getUser(id);
        return userRepository.findById(id)
                .map(user -> {
                    // TODO Optional
                    if (newUser.getName() != null) {
                        user.setName(newUser.getName().substring(0, 1).toUpperCase() + newUser.getName().substring(1));
                    } else {
                        user.setName(oldUser.getName());
                    }
                    if (newUser.getSurname() != null) {
                        user.setSurname(newUser.getSurname().substring(0, 1).toUpperCase() + newUser.getSurname().substring(1));
                    } else {
                        user.setSurname(oldUser.getSurname());
                    }
                    if (newUser.getAddress() != null) {
                        user.setAddress(addressRepository.findAddressByAddress(newUser.getAddress())
                                .orElseThrow(() -> new AddressNotFoundException(0L)));
                    }
                    if (newUser.getPassword() != null) {
                        if (!(newUser.getPassword().length() >= 60)) {
                            if (isValid(newUser.getPassword(), true)) {
                                user.setPassword(passwordEncoder.encode(newUser.getPassword()));
                            }
                        }
                    }
                    if (newUser.getContainers().size() > 0) {

                        // since users can change which containers belong to them / they can change address
                        // we have to remove outdated containers

                        // remove user dependency to container
                        user.getContainers().forEach(user::removeContainer);
                        // add new containers to the user
                        setContainersToUser(user, newUser.getContainers());
                    }
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

    private void setContainersToUser(User user, List<ContainerRegistrationDTO> c) {
        setContainersToUser(user, user.getAddress().getId(), c);
    }

    private void setContainersToUser(User user, Long addressId, List<ContainerRegistrationDTO> c) {

        // let's do some magic here with containers
        // according to design containers are already assigned to address before user is registered
        // so for assigning containers to users, frontend has to send address id and type (String)
        Set<Container> containers = containerRepository.findAllByAddress_Id(addressId);
        Set<Container> userContainers = containers.stream().filter(container -> c.stream()
                .map(ContainerRegistrationDTO::getGarbageType)
                .collect(Collectors.toSet())
                .contains(container.getGarbageType()))
                .collect(Collectors.toSet());

        user.setContainers(userContainers);
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