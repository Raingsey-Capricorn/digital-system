package com.digital.system.ratingservices.ports.outgoing;

import com.digital.system.ratingservices.domain.vo.RateEntityVO;
import com.digital.system.ratingservices.infrastructure.constant.RateType;

import java.util.List;
import java.util.Optional;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 23/1/24
 * Project : com.digital.system
 * Provide optional value to prevent NPE
 */
public interface RatesService {
    /**
     * @return
     */
    Optional<List<RateEntityVO>> getRates();

    /**
     * @param type
     * @return
     */
    Optional<RateEntityVO> getRates(RateType type);
}
