package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.TownNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Town;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.TownRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/addresses")
public class AddressController {

    private AddressRepository addressRepository;
    private TownRepository townRepository;

    public AddressController(AddressRepository addressRepository, TownRepository townRepository) {
        this.addressRepository = addressRepository;
        this.townRepository = townRepository;
    }

    @GetMapping
    public Page<Address> getAddresses(@PageableDefault(size = 50)  Pageable pageable) {
        return addressRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Address getAddress(@PathVariable Long id) {
        return addressRepository.findById(id)
                .orElseThrow(() -> new AddressNotFoundException(id));
    }

    @PostMapping
    public Address newAddress(@RequestBody Address address) {
        address.setId(0L);

        Town town = townRepository.findById(address.getTown().getId())
                .orElseThrow(() -> new TownNotFoundException(address.getTown().getId()));
        address.setTown(town);
        return addressRepository.save(address);
    }

    @PutMapping("/{id}")
    public Address updateAddress(@PathVariable Long id, @RequestBody Address newAddress) {
        return addressRepository.findById(id)
                .map(address -> {
                    address.setAddress(newAddress.getAddress());
                    address.setTown(townRepository.findById(address.getTown().getId()).get());
                    return addressRepository.save(address);
                })
                .orElseThrow(() -> new TownNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    public void deleteTown(@PathVariable Long id) {
        addressRepository.deleteById(id);
    }
}
