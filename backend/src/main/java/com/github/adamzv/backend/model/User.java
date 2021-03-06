package com.github.adamzv.backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.github.adamzv.backend.validation.ValidEmail;
import com.sun.istack.NotNull;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Entity(name = "user_account")
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

    @JsonManagedReference(value = "container-user")
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
    private Set<ContainerUser> containerUser = new HashSet<>();

    public User() {
        super();
        this.enabled = false;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserToken getToken() {
        return token;
    }

    public void setToken(UserToken token) {
        this.token = token;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Set<ContainerUser> getContainerUser() {
        return containerUser;
    }

    public void setContainerUser(Set<ContainerUser> containerUser) {
        this.containerUser = containerUser;
    }

    // UserDetails getters
    @JsonIgnore
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getRole().name()))
                .collect(Collectors.toList());
    }

    public String getPassword() {
        return password;
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

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", enabled=" + enabled +
                ", token=" + token +
                ", roles=" + roles +
                ", address=" + address +
                ", containerUser=" + containerUser +
                '}';
    }
}
