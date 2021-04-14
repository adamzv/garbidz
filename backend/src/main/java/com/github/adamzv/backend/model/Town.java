package com.github.adamzv.backend.model;

import com.sun.istack.NotNull;

import javax.persistence.*;

@Entity
@Table(name = "town")
public class Town {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String town;

    @Column(length = 5)
    @NotNull
    private String zipcode;

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

    @Override
    public String toString() {
        return "Town{" +
                "id=" + id +
                ", town='" + town + '\'' +
                ", zipcode='" + zipcode + '\'' +
                ", region=" + region +
                '}';
    }
}
