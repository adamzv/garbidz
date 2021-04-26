package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.sun.istack.NotNull;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "schedule")
public class Schedule{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private Date datetime;

    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL)
    @JsonBackReference
    private Set<ContainerSchedule> containerSchedule = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Schedule() {
    }

    public Schedule(Date datetime) {
        this.datetime = datetime;
    }

    public Date getDatetime() {
        return datetime;
    }

    public void setDatetime(Date datetime) {
        this.datetime = datetime;
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
                '}';
    }
}