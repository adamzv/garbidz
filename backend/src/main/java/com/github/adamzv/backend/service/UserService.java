package com.github.adamzv.backend.service;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.*;
import com.github.adamzv.backend.model.dto.ContainerRegistrationDTO;
import com.github.adamzv.backend.model.dto.UserFinishDTO;
import com.github.adamzv.backend.model.dto.UserRegistrationDTO;
import com.github.adamzv.backend.repository.*;
import com.github.adamzv.backend.security.validation.PasswordConstraintValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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
    private PasswordConstraintValidator passwordValidator;

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



    // TODO: service method validations
    // TODO: refactor everything to return ResponseEntity
    public User createUser(UserRegistrationDTO userDTO) {
        if (userRepository.findUserByEmail(userDTO.getEmail()) != null) {
            throw new RuntimeException("Email is already used.");
        }
        User user = new User();
        user.setId(0L);
        user.setEmail(userDTO.getEmail());
        user.setName(userDTO.getName());
        user.setSurname(userDTO.getSurname());
        user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        user.setEnabled(false);

        // Set user role
        // only admin / moderators can add other roles
        Set<Role> roles = new HashSet<>();
        Role role = roleRepository.findByRole(ERole.ROLE_USER)
                .orElseThrow(() -> new RoleNotFoundException());
        roles.add(role);
        user.setRoles(roles);
        return userRepository.save(user);
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
        return userRepository.findById(id)
                .map(user -> {
                    user.setName(newUser.getName());
                    user.setSurname(newUser.getSurname());
                    user.setEmail(newUser.getEmail());
                    user.setPassword(newUser.getPassword());
                    user.setToken(newUser.getToken());

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
