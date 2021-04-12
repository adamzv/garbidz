package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "container")
public class Container{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_address", nullable = false)
    private Address address;

    @ManyToOne
    @JoinColumn(name = "id_type", nullable = false)
    private ContainerType type;

    @NotNull
    private int number;

    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL)
    private Set<ContainerSchedule> containerSchedule;

    @OneToMany(mappedBy = " ",cascade = CascadeType.All)
    private Set<ContainerUser> containerUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
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
                ", number=" + number +
                ", containerSchedule=" + containerSchedule +
                ", containerUser=" + containerUser +
                '}';
    }
}