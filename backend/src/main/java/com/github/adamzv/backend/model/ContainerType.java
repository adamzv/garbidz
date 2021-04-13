package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;

@Entity
@Table(name = "container_type")
public class ContainerType{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length=255)
    @NotNull
    private String type;

    @Column(length=30)
    @NotNull
    private String size;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    @Override
    public String toString() {
        return "ContainerType{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", size='" + size + '\'' +
                '}';
    }
}