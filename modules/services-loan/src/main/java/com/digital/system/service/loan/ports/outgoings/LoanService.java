package com.digital.system.service.loan.ports.outgoings;

import com.digital.system.service.loan.domain.vo.LoanEntityVO;
import com.digital.system.service.loan.infrastructure.constant.LoanType;

import java.util.List;
import java.util.Optional;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */

public interface LoanService {
    /**
     * @param type
     * @return
     */
    Optional<List<LoanEntityVO>> getLoans(LoanType type);
}
