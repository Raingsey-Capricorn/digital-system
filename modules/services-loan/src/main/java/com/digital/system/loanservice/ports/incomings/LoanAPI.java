package com.digital.system.loanservice.ports.incomings;

import com.digital.system.loanservice.domain.vo.LoanEntityVO;
import org.springframework.http.ResponseEntity;

import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
public interface LoanAPI {
    /**
     * @param type
     * @return
     */
    ResponseEntity<List<LoanEntityVO>> getLoans(String type);
}
