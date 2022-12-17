package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "container")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Container {

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

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "schedule", cascade = CascadeType.ALL)
    @JsonBackReference
    private Set<ContainerSchedule> containerSchedule;

    @ManyToMany(mappedBy = "containers")
    private Set<User> users = new HashSet<>();
}