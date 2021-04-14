package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "container_has_user")
public class ContainerUser implements Serializable {

    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name = "id_container")
    private Container container;

    @Id
    @ManyToOne(optional = false)
    @JoinColumn(name = "id_user")
    private User user;

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