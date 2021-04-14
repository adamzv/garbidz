package com.github.adamzv.backend.service;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.ERole;
import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.RoleRepository;
import com.github.adamzv.backend.repository.UserRepository;
import com.github.adamzv.backend.security.service.UserDetailsServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private AddressRepository addressRepository;
    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);


    public UserService(UserRepository userRepository, RoleRepository roleRepository, AddressRepository addressRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.addressRepository = addressRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // TODO: service method validations
    // TODO: refactor everything to return ResponseEntity
    // TODO: create request entity for registration
    public User createUser(User user) {
        user.setId(0L);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // set user role
        Set<Role> reqRoles = user.getRoles();
        Set<Role> roles = new HashSet<>();
        if (reqRoles == null) {
            Role role = roleRepository.findByRole(ERole.ROLE_USER)
                    .orElseThrow(() -> new RoleNotFoundException());
            roles.add(role);
        } else {
            reqRoles.forEach(role -> {
                switch (role.getRole().name()) {
                    case "ROLE_ADMIN":
                        Role adminRole = roleRepository.findByRole(ERole.ROLE_ADMIN)
                                .orElseThrow(() -> new RoleNotFoundException());
                        roles.add(adminRole);
                        break;
                    case "ROLE_MODERATOR":
                        Role moderatorRole = roleRepository.findByRole(ERole.ROLE_MODERATOR)
                                .orElseThrow(() -> new RoleNotFoundException());
                        roles.add(moderatorRole);
                        break;
                    default:
                        Role userRole = roleRepository.findByRole(ERole.ROLE_USER)
                                .orElseThrow(() -> new RoleNotFoundException());
                        roles.add(userRole);
                        break;
                }
            });
        }

        user.setRoles(roles);

        // set user address
        Address address = addressRepository.findById(user.getAddress().getId())
                .orElseThrow(() -> new AddressNotFoundException(user.getAddress().getId()));
        user.setAddress(address);

        return userRepository.save(user);
    }

    public User updateUser(Long id, User newUser) {
        return userRepository.findById(id)
                .map(user -> {
                    user.setName(newUser.getName());
                    user.setSurname(newUser.getSurname());
                    user.setEmail(newUser.getEmail());
                    user.setPassword(newUser.getPassword());
                    user.setToken(newUser.getToken());
                    // TODO: update setting roles
                    // maybe dont change role and add a separate method for adding roles

//                    user.setRole(roleRepository.findById(newUser.getRole().getId())
//                            .orElseThrow(() -> new RoleNotFoundException(newUser.getRole().getId())));
                    user.setAddress(addressRepository.findById(newUser.getAddress().getId())
                            .orElseThrow(() -> new AddressNotFoundException(newUser.getAddress().getId())));
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
}
