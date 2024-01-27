package com.digital.system.loanservice.ports.outgoings.adapters.repositories;

import com.digital.system.loanservice.domain.vo.LoanEntityVO;
import com.digital.system.loanservice.infrastructure.constant.LoanType;
import com.digital.system.loanservice.infrastructure.database.repositories.LoanRepository;
import com.digital.system.loanservice.infrastructure.http.WebClientCommunicator;
import com.digital.system.loanservice.ports.outgoings.LoanService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.HashMap;
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
public class LoanServiceEnact implements LoanService {

    private final LoanRepository repository;

    /**
     * @param type : loan type
     * @return loans with calculated interest rate
     */
    @Override
    @SneakyThrows
    @CircuitBreaker(name = "services-loan", fallbackMethod = "getFallbackLoanResult")
    public Optional<List<LoanEntityVO>> getLoans(LoanType type) {

        final var rate = LoanServiceEnact.getRateData(type);
        return Optional.of(repository
                .findAll()
                .stream()
                .map(loanEntity -> {
                    if (loanEntity.getType().equals(type)) {
                        loanEntity.setInterest(rate * loanEntity.getAmount() / 100);
                    }
                    return new LoanEntityVO(loanEntity);
                })
                .toList());
    }

    /**
     * @param exception : webclient failed to connect
     * @return list of loans without rate calculation
     */
    private Optional<List<LoanEntityVO>> getFallbackLoanResult(Exception exception) {

        log.info("Default loans result is fetched due to {}", exception.getLocalizedMessage());
        return Optional.of(repository
                .findAll()
                .stream()
                .map(LoanEntityVO::new)
                .toList());
    }

    /**
     * @param type : loan-type
     * @return double value of rate
     * @throws JsonProcessingException
     */
    private static double getRateData(LoanType type) throws JsonProcessingException {

        var rateResult = WebClientCommunicator.request(
                        uriBuilder -> uriBuilder
                                .path("/api/v1/rate")
                                .queryParamIfPresent("type", Optional.ofNullable(type.toString()))
                                .build())
                .exchangeToMono(response ->
                        response.statusCode().is2xxSuccessful() ?
                                response.bodyToMono(String.class) :
                                response.createException().flatMap(Mono::error)
                )
                .doOnError(throwable -> log.error(throwable.getMessage()))
                .doOnSuccess(s -> log.info(" request success with data returned."))
                .block(Duration.ofSeconds(60));

        return Double.parseDouble(((HashMap<?, ?>) new ObjectMapper()
                .readValue(rateResult, HashMap.class)
                .get("data"))
                .get("rate")
                .toString()
        );

    }

}
