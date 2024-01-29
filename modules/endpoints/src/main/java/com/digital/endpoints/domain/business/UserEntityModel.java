package com.digital.endpoints.domain.business;

import com.digital.endpoints.infrastructure.config.frameworks.security.constants.AuthorizationRole;
import com.digital.endpoints.infrastructure.database.entities.UserEntity;
import com.digital.endpoints.infrastructure.database.models.User;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collection;
import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 6/10/23
 * Project : com.digital.system
 */
@Getter
@NoArgsConstructor
@Accessors(chain = true)
public class UserEntityModel implements User {

    @Setter(AccessLevel.PRIVATE)
    private UserEntity user = new UserEntity();

    public UserEntityModel(UserEntity user) {
        this.user = user;
    }

    /**
     * @param role
     * @return
     */
    public UserEntityModel setRole(AuthorizationRole role) {
        this.user.setRole(role);
        return this;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(user.getRole().name()));
    }

    /**
     * @return
     */
    public String getFirstName() {
        return user.getFirstName();
    }

    /**
     * @param firstName
     */
    public UserEntityModel setFirstName(String firstName) {
        this.user.setFirstName(firstName);
        return this;
    }

    /**
     * @return
     */
    public String getLastName() {
        return user.getLastName();
    }

    /**
     * @param lastName
     */
    public UserEntityModel setLastName(String lastName) {
        this.user.setLastName(lastName);
        return this;
    }

    /**
     * @return
     */
    public String getEmail() {
        return user.getEmail();
    }

    /**
     * @param email
     */
    public UserEntityModel setEmail(String email) {
        this.user.setEmail(email);
        return this;
    }

    /**
     * @param password
     */
    public UserEntityModel setPassword(String password) {
        this.user.setPassword(password);
        return this;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getEmail();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
