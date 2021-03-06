package com.github.adamzv.backend.model.dto;

import java.util.List;

public class UserUpdateDTO {
    private Long id;
    private String name;
    private String surname;
    private String password;
    private String address;
    private List<ContainerRegistrationDTO> containers;

    public UserUpdateDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<ContainerRegistrationDTO> getContainers() {
        return containers;
    }

    public void setContainers(List<ContainerRegistrationDTO> containers) {
        this.containers = containers;
    }
}
