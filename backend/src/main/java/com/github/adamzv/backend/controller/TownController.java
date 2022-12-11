package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.RegionNotFoundException;
import com.github.adamzv.backend.exception.TownNotFoundException;
import com.github.adamzv.backend.model.Region;
import com.github.adamzv.backend.model.Town;
import com.github.adamzv.backend.repository.RegionRepository;
import com.github.adamzv.backend.repository.TownRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

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
    public List<Town> getTowns(@RequestParam(name = "region_id", required = false) Optional<Long> id) {
        return id.map(townRepository::findAllByRegionId).orElseGet(() -> townRepository.findAll());
    }

    @GetMapping("/{id}")
    public Town getTown(@PathVariable Long id) {
        return townRepository.findById(id)
                .orElseThrow(() -> new TownNotFoundException(id));
    }

    @PostMapping
    @IsModerator
    public Town newTown(@RequestBody Town town) {

        // setting town id to 0 forces JPA to generate a new id
        // this prevents users from setting their own id for object in request
        town.setId(0L);
        // JSON request may not include whole region object, so we'll search for the region object
        // and then set it to town object, otherwise throw an exception because the object with specified id
        // does not exist in db
        Region region = regionRepository.findById(town.getRegion().getId())
                .orElseThrow(() -> new RegionNotFoundException(town.getRegion().getId()));
        town.setRegion(region);
        return townRepository.save(town);
    }

    @PutMapping("/{id}")
    @IsModerator
    public Town updateTown(@PathVariable Long id, @RequestBody Town newTown) {
        return townRepository.findById(id)
                .map(town -> {
                    town.setTown(newTown.getTown());
                    // TODO refactor
                    town.setRegion(regionRepository.findById(newTown.getRegion().getId()).get());
                    return townRepository.save(town);
                })
                .orElseThrow(() -> new RuntimeException("Town with id " + id + " can not be updated!"));
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteTown(@PathVariable Long id) {
        townRepository.deleteById(id);
    }
}
