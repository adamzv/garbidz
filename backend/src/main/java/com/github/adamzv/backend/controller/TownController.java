package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.TownNotFoundException;
import com.github.adamzv.backend.model.Town;
import com.github.adamzv.backend.repository.RegionRepository;
import com.github.adamzv.backend.repository.TownRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/towns")
public class TownController {

    private TownRepository townRepository;
    private RegionRepository regionRepository;

    public TownController(TownRepository townRepository, RegionRepository regionRepository) {
        this.townRepository = townRepository;
        this.regionRepository = regionRepository;
    }

    @GetMapping
    public List<Town> getAllTowns() {
        return townRepository.findAll();
    }

    @GetMapping("/{id}")
    public Town getTown(@PathVariable Long id) {
        return townRepository.findById(id)
                .orElseThrow(() -> new TownNotFoundException(id));
    }
}
