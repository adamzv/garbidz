package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.ContainerNotFoundException;
import com.github.adamzv.backend.exception.ContainerTypeNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.ContainerType;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.ContainerRepository;
import com.github.adamzv.backend.repository.ContainerTypeRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/containers")
public class ContainerController {

    private ContainerRepository containerRepository;
    private AddressRepository addressRepository;
    private ContainerTypeRepository containerTypeRepository;

    public ContainerController(ContainerRepository containerRepository, AddressRepository addressRepository, ContainerTypeRepository containerTypeRepository) {
        this.containerRepository = containerRepository;
        this.addressRepository = addressRepository;
        this.containerTypeRepository = containerTypeRepository;
    }

    @GetMapping
    public Page<Container> getContainers(@PageableDefault(size = 50) Pageable pageable) {
        return containerRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Container getContainer(@PathVariable Long id) {
        return containerRepository.findById(id)
                .orElseThrow(() -> new ContainerNotFoundException(id));
    }

    @GetMapping("/address/{id}")
    public Set<Container> getAddressContainers(@PathVariable Long id) {
        return containerRepository.findAllByAddress_Id(id);
    }

    @PostMapping
    @IsModerator
    public Container newContainer(@RequestBody Container container) {
        container.setId(0L);

        Address address = addressRepository.findById(container.getAddress().getId())
                .orElseThrow(() -> new AddressNotFoundException(container.getAddress().getId()));
        container.setAddress(address);

        ContainerType containerType = containerTypeRepository.findById(container.getType().getId())
                .orElseThrow(() -> new ContainerTypeNotFoundException(container.getType().getId()));
        container.setType(containerType);

        return containerRepository.save(container);
    }

    @PutMapping("/{id}")
    @IsModerator
    public Container updateContainer(@PathVariable Long id, @RequestBody Container newContainer) {
        return containerRepository.findById(id)
                .map(container -> {
                    container.setGarbageType(newContainer.getGarbageType());
                    container.setAddress(addressRepository.findById(newContainer.getAddress().getId())
                            .orElseThrow(() -> new AddressNotFoundException(newContainer.getAddress().getId())));
                    container.setType(containerTypeRepository.findById(newContainer.getType().getId())
                            .orElseThrow(() -> new ContainerTypeNotFoundException(newContainer.getType().getId())));
                    return containerRepository.save(container);
                })
                .orElseThrow(() -> new ContainerNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteContainer(@PathVariable Long id) {
        containerRepository.deleteById(id);
    }
}