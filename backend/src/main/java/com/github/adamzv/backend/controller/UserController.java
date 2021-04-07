package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.RoleRepository;
import com.github.adamzv.backend.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/users")
public class UserController {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private AddressRepository addressRepository;
    private PasswordEncoder passwordEncoder;

    // use constructor base injection since using @Autowired is not recommended
    public UserController(UserRepository userRepository, RoleRepository roleRepository, AddressRepository addressRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.addressRepository = addressRepository;
        this.passwordEncoder = passwordEncoder;
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
