package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.model.Role;
import com.github.adamzv.backend.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path = "/role")
public class RoleController {

    @Autowired
    private RoleRepository roleRepository;

    @GetMapping
    public @ResponseBody Iterable<Role> getAllRoles() {
        return roleRepository.findAll();
    }
}
