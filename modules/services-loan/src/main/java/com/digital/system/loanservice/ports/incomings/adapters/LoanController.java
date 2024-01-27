package com.digital.system.loanservice.ports.incomings.adapters;

import com.digital.system.loanservice.domain.vo.LoanEntityVO;
import com.digital.system.loanservice.infrastructure.constant.LoanType;
import com.digital.system.loanservice.ports.incomings.LoanAPI;
import com.digital.system.loanservice.ports.outgoings.LoanService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("api/v1")
public class LoanController implements LoanAPI {

    private final LoanService service;

    @Override
    @GetMapping("/loans")
    public ResponseEntity<List<LoanEntityVO>> getLoans(@RequestParam("type") String type) {
        log.info(">>>> get Loans");
        return ResponseEntity.of(service.getLoans(LoanType.valueOf(type)));
    }
}
