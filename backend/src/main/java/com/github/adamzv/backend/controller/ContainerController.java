package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.ContainerTypeNotFoundException;
import com.github.adamzv.backend.exception.ContainerNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.ContainerType;
import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.ContainerTypeRepository;
import com.github.adamzv.backend.repository.ContainerRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/container")
public class ContainerController {

    private ContainerRepository containerRepository;
    private AddressRepository addressRepository;
    private ContainerTypeRepository containerTypeRepository;

    public ContainerController(ContainerRepository containerRepository, AddressRepository addressRepository, ContainerTypeRepository containerTypeRepository) {
        this.containerRepository = containerRepository;
        this.addressRepository = addressRepository;
        this.containerTypeRepository = containerRepository;
    }

    @GetMapping
    public Page<Container> getContainer(@PageableDefault(size = 50) Pageable pageable) {
        return containerRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Container getContainer(@PathViable Long id) {
        return containerRepository.findById(id)
                .orElseThrow(() -> new ContainerNotFoundException(id));
    }

    @PostMapping
    public Container newContainer(@RequestBody Container container) {
        container.setId(0L);

        Address address = addressRepository.findByid(container.getAddress().getId())
                .orElseThrow(() -> new AddressNotFoundException(container.getAddress().getId()))
        container.setAddress(address);

        ContainerType containerType = containerTypeRepository.findById(container.getType().getId())
                .orElseThrow(() -> new ContainerTypeNotFoundException(container.getType().getId()))
        container.setType(containerType)

        return containerRepository.save(container);
    }

    @PutMapping("/{id}")
    public Container updateContainer(@PathVariable Long id, @RequestBody Container newContainer) {
        return containerRepository.findById(id)
                .map(container -> {
                    container.setadress(addressRepository.findById(newContainer.getAdress().getId()))
                            .orElseThrow(() -> new AdressNotFoundException(newContainer.getAdress().getId()));
                    container.settype(containerTypeRepository.findById(newContainer.getType().getId()))
                            .orElseThrow(() -> new ContainerTypeNotFoundException(newContainer.getType().getId()));
                    container.setnumber(newContainer.getNumber());
                    return containerRepository.save(container)
                })
                .orElseThrow(() -> new ContainerNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    public void deleteContainer(@PathVariable Long id){
        containerRepository.deleteById(id);
    }
}