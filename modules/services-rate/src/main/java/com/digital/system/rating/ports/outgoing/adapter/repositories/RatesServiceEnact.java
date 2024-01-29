package com.digital.system.rating.ports.outgoing.adapter.repositories;

import com.digital.system.rating.domain.vo.RateEntityVO;
import com.digital.system.rating.infrastructure.constant.RateType;
import com.digital.system.rating.infrastructure.database.entities.RateEntity;
import com.digital.system.rating.infrastructure.database.repositories.RateRepository;
import com.digital.system.rating.ports.outgoing.RatesService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Slf4j
@Service
@AllArgsConstructor
public class RatesServiceEnact implements RatesService {

    private final RateRepository repository;

    @Override
    public Optional<List<RateEntityVO>> getRates() {

        return Optional.of(repository
                .findAll()
                .stream()
                .map(RateEntityVO::new)
                .toList());
    }

    @Override
    public Optional<RateEntityVO> getRates(RateType type) {

        final var rateEntity = new RateEntity();
        rateEntity.setType(type);
        return Optional.of(repository.findOne(Example.of(rateEntity)))
                .map(rate -> rate.map(RateEntityVO::new).
                        orElseGet(RateEntityVO::new)
                );
    }
}
