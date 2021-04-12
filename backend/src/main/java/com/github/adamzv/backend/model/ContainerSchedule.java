package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "container_has_schedule")
public class ContainerSchedule{

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_container")
    private Container container;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_schedule")
    private Schedule schedule;

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