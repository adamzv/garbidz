package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.*;
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

    // TODO rework ManyToMany relationships
    @ManyToMany(cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    @JoinTable(name = "container_has_schedule",
    joinColumns = @JoinColumn(name = "id_container"),
    inverseJoinColumns = @JoinColumn(name = "id_schedule"))
    //@OneToMany(fetch = FetchType.EAGER, mappedBy = "schedule", cascade = CascadeType.ALL)
    @JsonBackReference
    private Set<Schedule> containerSchedule;
//    private Set<ContainerSchedule> containerSchedule;

    @JsonBackReference(value = "container-user")
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "container")
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

    public Set<Schedule> getContainerSchedule() {
        return containerSchedule;
    }

    public void setContainerSchedule(Set<Schedule> containerSchedule) {
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