package com.digital.system.service.loan.domain.vo;

import com.digital.system.service.loan.infrastructure.constant.LoanType;
import com.digital.system.service.loan.infrastructure.database.entities.LoanEntity;
import com.digital.system.service.loan.infrastructure.database.models.Loan;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Getter
@NoArgsConstructor
@Accessors(chain = true)
public class LoanEntityVO implements Loan {

    @Setter(AccessLevel.PRIVATE)
    private LoanEntity loan = new LoanEntity();

    /**
     * @param loan
     */
    public LoanEntityVO(LoanEntity loan) {
        this.loan = loan;
    }

    /**
     * @param type
     * @param amount
     * @param interest
     */
    public LoanEntityVO(
            LoanType type,
            Double amount,
            Double interest
    ) {
        this.loan.setAmount(amount);
        this.loan.setType(type);
        this.loan.setInterest(interest);

    }
}
