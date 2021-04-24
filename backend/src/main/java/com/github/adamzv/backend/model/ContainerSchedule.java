package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "container_has_schedule")
public class ContainerSchedule implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "id_container")
    private Container container;

    @ManyToOne(optional = false)
    @JoinColumn(name = "id_schedule")
    private Schedule schedule;

    public ContainerSchedule() {
    }

    public ContainerSchedule(Container container, Schedule schedule) {
        this.container = container;
        this.schedule = schedule;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Container getContainer() {
        return container;
    }

    public void setContainer(Container container) {
        this.container = container;
    }

    public Schedule getSchedule() {
        return schedule;
    }

    public void setSchedule(Schedule schedule) {
        this.schedule = schedule;
    }

    @Override
    public String toString() {
        return "ContainerSchedule{" +
                "container=" + container +
                ", schedule=" + schedule +
                '}';
    }
}