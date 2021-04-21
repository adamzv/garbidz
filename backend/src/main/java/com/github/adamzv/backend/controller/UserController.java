package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.security.annotation.IsModerator;
import com.github.adamzv.backend.security.annotation.IsUser;
import com.github.adamzv.backend.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.web.bind.annotation.*;

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
    // TODO: try to move hasRole('MODERATOR') from @PostAuthorize
    @PostAuthorize("returnObject.username == authentication.principal || hasRole('MODERATOR')")
    public User getUser(@PathVariable Long id) {
        return userService.getUser(id);
    }

    @PutMapping("/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody User newUser) {
        return userService.updateUser(id, newUser);
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
    }
}
