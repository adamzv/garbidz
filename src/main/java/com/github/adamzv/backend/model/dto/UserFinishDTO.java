package com.github.adamzv.backend.model.dto;

import java.util.List;

public class UserFinishDTO {

    private Long addressId;
    private List<ContainerRegistrationDTO> containers;

    public UserFinishDTO() {
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public List<ContainerRegistrationDTO> getContainers() {
        return containers;
    }

    public void setContainers(List<ContainerRegistrationDTO> containers) {
        this.containers = containers;
    }
}
