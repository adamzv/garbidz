package com.github.adamzv.backend.model.dto;

import com.github.adamzv.backend.model.ContainerType;

public class ContainerRegistrationDTO {

    private Long addressId;
    private ContainerType type;

    public ContainerRegistrationDTO() {
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public ContainerType getType() {
        return type;
    }

    public void setType(ContainerType type) {
        this.type = type;
    }
}
