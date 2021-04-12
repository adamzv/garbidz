package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;
import java.util.Set;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "schedule")
public class Schedule{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private LocalDateTime datetime;

    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL)
    private Set<ContainerSchedule> containerSchedule = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getDatetime() {
        return datetime;
    }

    public void setDatetime(LocalDateTime datetime) {
        this.datetime = datetime;
    }

    public Set<Container> getContainer() {
        return container;
    }

    public void setContainer(Set<Container> container) {
        this.container = container;
    }

    public Set<ContainerSchedule> getContainerSchedule() {
        return containerSchedule;
    }

    public void setContainerSchedule(Set<ContainerSchedule> containerSchedule) {
        this.containerSchedule = containerSchedule;
    }

    @Override
    public String toString() {
        return "Schedule{" +
                "id=" + id +
                ", datetime=" + datetime +
                ", container=" + container +
                '}';
    }
}