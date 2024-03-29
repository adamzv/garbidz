package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "schedule")
@Getter
@Setter
@AllArgsConstructor
public class Schedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private Date datetime;

    //    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL)
    @JsonBackReference
    @Fetch(FetchMode.SUBSELECT)
    @ManyToMany(mappedBy = "containerSchedule", fetch = FetchType.EAGER)
    private Set<Container> scheduleContainer = new HashSet<>();

    public Schedule() {
    }

    public Schedule(Date datetime) {
        this.datetime = datetime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDatetime() {
        return datetime;
    }

    public void setDatetime(Date datetime) {
        this.datetime = datetime;
    }

    @Override
    public String toString() {
        return "Schedule{" +
                "id=" + id +
                ", datetime=" + datetime +
                '}';
    }

}