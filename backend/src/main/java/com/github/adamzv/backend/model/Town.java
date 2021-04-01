package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import javax.persistence.*;

@Entity
@Table(name = "town")
// TODO: research problems with circular dependencies
// temp. solution: https://dzone.com/articles/circular-dependencies-jackson
@JsonIdentityInfo(generator= ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Town {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String town;

    @Column(length = 5)
    private String zipcode;

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

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }
}
