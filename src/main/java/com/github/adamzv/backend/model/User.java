package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.github.adamzv.backend.validation.ValidEmail;
import com.sun.istack.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Entity(name = "user_account")
@Getter
@Setter
@ToString
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @NotBlank(message = "Name is a mandatory field!")
    @Size(min = 1, max = 255, message = "Name must have between 1 and 255 characters!")
    private String name;

    @NotNull
    @NotBlank(message = "Surname is a mandatory field!")
    @Size(min = 1, max = 255, message = "Surname must have between 1 and 255 characters!")
    private String surname;

    @NotNull
    @Column(unique = true)
    @NotBlank(message = "Email is a mandatory field!")
    @Size(min = 1, max = 255, message = "Email must be between 1 and 255 characters!")
    @ValidEmail
    private String email;

    @NotNull
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @NotBlank(message = "Password is a mandatory field!")
    @Size(min = 8, max = 255, message = "Password must have between 8 to 255 characters!")
    private String password;

    private boolean enabled;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_token_id")
    private UserToken token;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "user_has_role",
            joinColumns = @JoinColumn(name = "id_user"),
            inverseJoinColumns = @JoinColumn(name = "id_role"))
    private Set<Role> roles = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "id_address")
    private Address address;

    @ManyToMany(fetch = FetchType.EAGER,
            cascade = {
                    CascadeType.PERSIST,
                    CascadeType.MERGE
            })
    // TODO change table name to "user_has_containers"
    @JoinTable(name = "container_has_user",
            joinColumns = @JoinColumn(name = "id_user"),
            inverseJoinColumns = @JoinColumn(name = "id_container"))
    @Fetch(FetchMode.SUBSELECT)
    private Set<Container> containers = new HashSet<>();

    public User() {
        super();
        this.enabled = false;
    }

    // TODO hashcode/equals for both entities

    public void addContainer(Container container) {
        this.containers.add(container);
        container.getUsers().add(this);
    }

    public void removeContainer(Container container) {
        this.containers.remove(container);
        container.getUsers().remove(this);
    }

    // UserDetails getters
    @JsonIgnore
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getRole().name()))
                .collect(Collectors.toList());
    }

    // we are returing email as username
    @Override
    public String getUsername() {
        return email;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @JsonIgnore
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }
}
