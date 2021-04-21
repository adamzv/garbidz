package com.github.adamzv.backend.model.dto;

import com.github.adamzv.backend.model.ContainerType;

public class ContainerRegistrationDTO {

    private Long addressId;
    private String garbageType;

    public ContainerRegistrationDTO() {
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public String getGarbageType() {
        return garbageType;
    }

    public void setGarbageType(String garbageType) {
        this.garbageType = garbageType;
    }
}
