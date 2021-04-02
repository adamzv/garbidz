package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.model.Region;
import com.github.adamzv.backend.repository.RegionRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/regions")
public class RegionController {

    private RegionRepository regionRepository;

    public RegionController(RegionRepository regionRepository) {
        this.regionRepository = regionRepository;
    }

    @GetMapping()
    public List<Region> getAllRegions() {
        return regionRepository.findAll();
    }
}
