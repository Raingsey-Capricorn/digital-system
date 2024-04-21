package com.digital.system.rating.ports.incoming;

import com.digital.system.rating.domain.vo.RateEntityVO;
import org.springframework.http.ResponseEntity;

import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
public interface RatesAPI {
    ResponseEntity<List<RateEntityVO>> getRates();

    ResponseEntity<RateEntityVO> getRates(String type);
}