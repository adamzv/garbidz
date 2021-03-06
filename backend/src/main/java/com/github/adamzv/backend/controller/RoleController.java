package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.repository.RoleRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/roles")
@PreAuthorize("hasRole('MODERATOR')")
public class RoleController {

    private RoleRepository roleRepository;

    // use constructor base injection since using @Autowired is not recommended
    public RoleController(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @GetMapping
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    @GetMapping("/{id}")
    public Role getRole(@PathVariable Long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new RoleNotFoundException());
    }

    @PostMapping
    public Role newRole(@RequestBody Role role) {
        role.setId(0L);
        return roleRepository.save(role);
    }

    @PutMapping("/{id}")
    public Role updateRole(@PathVariable Long id, @RequestBody Role newRole) {
        return roleRepository.findById(id)
                .map(role -> {
                    role.setRole(newRole.getRole());
                    return roleRepository.save(role);
                })
                .orElseThrow(() -> new RoleNotFoundException());
    }

    @DeleteMapping("/{id}")
    public void deleteRole(@PathVariable Long id) {
        roleRepository.deleteById(id);
    }
}
