package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.RoleNotFoundException;
import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.repository.RoleRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/roles")
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
                // TODO: use orElseThrow instead of creating a new role
                .orElseGet(() -> {
                    newRole.setId(id);
                    return roleRepository.save(newRole);
                });
    }

    @DeleteMapping("/{id}")
    public void deleteRole(@PathVariable Long id) {
        roleRepository.deleteById(id);
    }
}
