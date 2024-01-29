package com.digital.system.rating.infrastructure.routine;

import com.digital.system.rating.domain.vo.RateEntityVO;
import com.digital.system.rating.infrastructure.constant.RateType;
import com.digital.system.rating.infrastructure.database.repositories.RateRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/1/24
 * Project : com.digital.system
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DataSeeding {

    private final RateRepository repository;

    @EventListener(ApplicationReadyEvent.class)
    public void migrateSuperLiveParticipant() {

        List.of(
                new RateEntityVO(RateType.PERSONAL, 0.3),
                new RateEntityVO(RateType.GROUP, 0.5),
                new RateEntityVO(RateType.COMPANY, 0.8)
        ).forEach(
                rateEntityVO -> {
                    var entity = rateEntityVO.getRate();
                    if (!repository.exists(Example.of(entity)))
                        repository.save(rateEntityVO.getRate());
                }
        );
    }
}