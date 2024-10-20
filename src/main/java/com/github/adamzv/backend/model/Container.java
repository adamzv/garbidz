package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

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

    @JsonManagedReference
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "container_has_schedule",
            joinColumns = @JoinColumn(name = "id_container"),
            inverseJoinColumns = @JoinColumn(name = "id_schedule"))
    @Fetch(FetchMode.SUBSELECT)
    private Set<Schedule> containerSchedule;

    @ManyToMany(mappedBy = "containers", fetch = FetchType.EAGER)
    @Fetch(FetchMode.SUBSELECT)
    private Set<User> users = new HashSet<>();

}