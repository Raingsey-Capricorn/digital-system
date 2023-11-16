package com.digital.endpoints.ports.outgoing.adapter.repository;

import com.digital.endpoints.domain.vo.UserEntityVO;
import com.digital.endpoints.infrastructure.database.repositories.UserRepository;
import com.digital.endpoints.ports.outgoing.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Primary;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Primary
@Slf4j
@Service
@RequiredArgsConstructor
public class RepositoryUserService implements UserService {

    private final UserRepository repository;

    /**
     * @param details :
     */
    public UserEntityVO save(UserEntityVO details) {

        if (repository.findByEmail(details.getEmail()).isEmpty()) {
            log.info(">>>> Saving new user : {}", details.getUser().getEmail());
            return new UserEntityVO(repository.save(details.getUser()));
        } else log.info("<<<< User {} is existed, return the data from repository.", details.getEmail());
        return details;
    }

    /**
     * @return
     */
    @Override
    public UserDetailsService userDetailsService() {

        log.info("<<<< loaded user from database repository");
        return username -> repository.findByEmail(username)
                .map(UserEntityVO::new)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
