package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.RegionNotFoundException;
import com.github.adamzv.backend.model.Region;
import com.github.adamzv.backend.repository.RegionRepository;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/{id}")
    public Region getRegion(@RequestParam Long id) {
        return regionRepository.findById(id)
                .orElseThrow(() -> new RegionNotFoundException(id));
    }

    @PostMapping
    public Region newRegion(@RequestBody Region region) {
        region.setId(0L);
        return regionRepository.save(region);
    }

    @PutMapping("/{id}")
    public Region updateRegion(@PathVariable Long id, @RequestBody Region newRegion) {
        return regionRepository.findById(id)
                .map(region -> {
                    region.setRegion(newRegion.getRegion());
                    return regionRepository.save(region);
                })
                .orElseThrow(() -> new RuntimeException("Region with id " + id + " can not be updated!"));
    }

    @DeleteMapping("/{id}")
    public void deleteRegion(@PathVariable Long id) {
        regionRepository.deleteById(id);
    }
}
