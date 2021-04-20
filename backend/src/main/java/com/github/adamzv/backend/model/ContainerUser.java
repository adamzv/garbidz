package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "container_has_user")
public class ContainerUser implements Serializable {

    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonBackReference
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "id_container")
    private Container container;

    @ManyToOne(optional = false)
    @JoinColumn(name = "id_user")
    @JsonBackReference
    private User user;

    public ContainerUser() {
    }

    public ContainerUser(Container container, User user) {
        this.container = container;
        this.user = user;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "ContainerUser{" +
                "container=" + container +
                ", user=" + user +
                '}';
    }
}