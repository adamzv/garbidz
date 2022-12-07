package com.github.adamzv.backend.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "town")
public class Town {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @NotBlank(message = "Town is mandatory field!")
    @Size(min = 1, max = 255, message = "Town must have between 1 and 255 characters!")
    private String town;

    // problems with circular dependencies were solved by using unidirectional mapping
    @ManyToOne
    @JoinColumn(name = "id_region", nullable = false)
    private Region region;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }

    @Override
    public String toString() {
        return "Town{" +
                "id=" + id +
                ", town='" + town + '\'' +
                ", region=" + region +
                '}';
    }
}
