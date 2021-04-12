package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.ContainerTypeNotFoundException;
import com.github.adamzv.backend.model.ContainerType;
import com.github.adamzv.backend.repository.ContainerTypeRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/container_type")
public class ContainerTypeController {

    private ContainerTypeRepository containerTypeRepository;

    public ContainerTypeController(ContainerTypeRepository containerTypeRepository) {
        this.containerTypeRepository = containerTypeRepository;
    }

    @GetMapping
    public Page<ContainerType> getContainerTypes(@PageableDefault(size = 50) Pageable pageable) {
        return containerTypeRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public ContainerType getContainerType(@PathVariable Long id){
        return containerTypeRepository.findById(id)
                .orElseThrow(() -> new ContainerTypeNotFoundException(id));
    }

    @PostMapping
    public ContainerType newContainerType(@RequestBody ContainerType containerType){
        containerType.setId(0L);
        return containerTypeRepository.save(containerType);
    }

    @PutMapping("/{id}")
    public ContainerType updateContainerType(@PathVariable Long id, @RequestBody ContainerType newContainerType){
        return containerTypeRepository.findById(id)
                .map(containerType -> {
                    containerType.setType(newContainerType.getContainerType());
                    containerType.setSize(newContainerType.getContainerSize());
                    return containerTypeRepository.save(containerType)
                })
                .orElseThrow(() -> new ContainerTypeNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    public void deleteContainerType(@PathVariable Long id){
        containerTypeRepository.deleteById(id);
    }

}