package com.github.adamzv.backend.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.model.UserLogin;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.RoleRepository;
import com.github.adamzv.backend.repository.UserRepository;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.SECRET;
import static com.github.adamzv.backend.security.configuration.SecurityConfigurationConstants.TOKEN_EXPIRATION;

@RestController
@RequestMapping(path = "/users")
public class UserController {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private AddressRepository addressRepository;
    private PasswordEncoder passwordEncoder;
    // TODO: move login and signup features to a separate controller
    private AuthenticationManager authenticationManager;

    // use constructor base injection since using @Autowired is not recommended
    public UserController(UserRepository userRepository, RoleRepository roleRepository, AddressRepository addressRepository, PasswordEncoder passwordEncoder, AuthenticationManager authenticationManager) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.addressRepository = addressRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
    }

    @GetMapping
    public Page<User> getAllUsers(@PageableDefault(size = 50) Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    @PostMapping
    public Long newUser(@RequestBody User user) {
        user.setId(0L);

        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // set user role
        Role role = roleRepository.findById(user.getRole().getId())
                .orElseThrow(() -> new RoleNotFoundException(user.getRole().getId()));
        user.setRole(role);

        // set user address
        Address address = addressRepository.findById(user.getAddress().getId())
                .orElseThrow(() -> new AddressNotFoundException(user.getAddress().getId()));
        user.setAddress(address);

        return userRepository.save(user).getId();
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody UserLogin login) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(login.getUsername(), login.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwtToken = JWT.create()
                .withSubject(login.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + TOKEN_EXPIRATION))
                .sign(Algorithm.HMAC256(SECRET.getBytes()));
        LoggerFactory.getLogger(UserController.class).error(jwtToken);
        return ResponseEntity.ok(jwtToken);
    }

    @PutMapping("/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody User newUser) {
        return userRepository.findById(id)
                .map(user -> {
                    user.setName(newUser.getName());
                    user.setSurname(newUser.getSurname());
                    user.setEmail(newUser.getEmail());
                    user.setPassword(newUser.getPassword());
                    user.setRole(roleRepository.findById(newUser.getRole().getId())
                            .orElseThrow(() -> new RoleNotFoundException(newUser.getRole().getId())));
                    user.setAddress(addressRepository.findById(newUser.getAddress().getId())
                            .orElseThrow(() -> new AddressNotFoundException(newUser.getAddress().getId())));
                    return userRepository.save(user);
                })
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id) {
        userRepository.deleteById(id);
    }
}
