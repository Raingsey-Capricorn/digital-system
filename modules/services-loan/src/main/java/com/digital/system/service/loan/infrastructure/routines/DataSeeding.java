package com.digital.system.service.loan.infrastructure.routines;

import com.digital.system.service.loan.domain.vo.LoanEntityVO;
import com.digital.system.service.loan.infrastructure.constant.LoanType;
import com.digital.system.service.loan.infrastructure.database.repositories.LoanRepository;
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

    private final LoanRepository repository;

    @EventListener(ApplicationReadyEvent.class)
    public void migrateSuperLiveParticipant() {

        List.of(
                new LoanEntityVO(LoanType.PERSONAL, 1670D, 0D),
                new LoanEntityVO(LoanType.GROUP, 50000D, 0D),
                new LoanEntityVO(LoanType.COMPANY, 1000000D, 00D)
        ).forEach(
                loanEntityVO -> {
                    var entity = loanEntityVO.getLoan();
                    if (!repository.exists(Example.of(entity)))
                        repository.save(loanEntityVO.getLoan());
                }
        );
    }
}