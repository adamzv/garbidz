package com.github.adamzv.backend.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "container")
public class Container{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JoinColumn(name = "garbage_type", nullable = false)
    private String garbageType;

    @ManyToOne
    @JoinColumn(name = "id_address", nullable = false)
    private Address address;

    @ManyToOne
    @JoinColumn(name = "id_type", nullable = false)
    private ContainerType type;

    // TODO same as User <-> Role, check if there is a better way than using EAGER loading
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "schedule", cascade = CascadeType.ALL)
    private Set<ContainerSchedule> containerSchedule;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "container",cascade = CascadeType.ALL)
    private Set<ContainerUser> containerUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGarbageType() {
        return garbageType;
    }

    public void setGarbageType(String garbageType) {
        this.garbageType = garbageType;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public ContainerType getType() {
        return type;
    }

    public void setType(ContainerType type) {
        this.type = type;
    }

    public Set<ContainerSchedule> getContainerSchedule() {
        return containerSchedule;
    }

    public void setContainerSchedule(Set<ContainerSchedule> containerSchedule) {
        this.containerSchedule = containerSchedule;
    }

    public Set<ContainerUser> getContainerUser() {
        return containerUser;
    }

    public void setContainerUser(Set<ContainerUser> containerUser) {
        this.containerUser = containerUser;
    }

    @Override
    public String toString() {
        return "Container{" +
                "id=" + id +
                ", address=" + address +
                ", type=" + type +
                ", containerSchedule=" + containerSchedule +
                ", containerUser=" + containerUser +
                '}';
    }
}