package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.model.ERole;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.security.annotation.IsModerator;
import com.github.adamzv.backend.security.annotation.IsSpecificUserOrModerator;
import com.github.adamzv.backend.security.annotation.IsUser;
import com.github.adamzv.backend.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping(path = "/users")
public class UserController {

    private UserService userService;

    // use constructor base injection since using @Autowired is not recommended
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    @IsModerator
    public Page<User> getAllUsers(@PageableDefault(size = 50) Pageable pageable) {
        return userService.getUsers(pageable);
    }

    @GetMapping("/{id}")
    @IsUser
    @IsSpecificUserOrModerator
    public User getUser(@PathVariable Long id) {
        return userService.getUser(id);
    }

    @PutMapping("/{id}")
    @IsUser
    @IsSpecificUserOrModerator
    public User updateUser(@PathVariable Long id, @RequestBody User newUser) {
        return userService.updateUser(id, newUser);
    }

    @PostMapping("/upgrade/{id}")
    @IsModerator
    public ResponseEntity<?> upgradeUserRole(@PathVariable Long id, @RequestParam String role) {

        // Moderator can only upgrade user to moderator, admin can also upgrade user to admin
        Set<GrantedAuthority> modAuthorities = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getAuthorities()
                .stream().collect(Collectors.toSet());

        boolean isAdmin = modAuthorities.stream().filter(authority -> authority.getAuthority().equals(ERole.ROLE_ADMIN.toString())).findAny().isPresent();
        ERole eRole = ERole.valueOf(role);
        if (isAdmin) {
            return ResponseEntity.ok(userService.upgradeRole(id, eRole));
        } else {
            if (eRole == ERole.ROLE_ADMIN) {
                return ResponseEntity.badRequest().body("Insufficient Permission");
            } else {
                return ResponseEntity.ok(userService.upgradeRole(id, eRole));
            }
        }
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
    }
}
