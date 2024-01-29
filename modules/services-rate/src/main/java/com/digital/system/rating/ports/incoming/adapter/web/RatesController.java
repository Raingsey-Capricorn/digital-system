package com.digital.system.rating.ports.incoming.adapter.web;

import com.digital.system.rating.domain.vo.RateEntityVO;
import com.digital.system.rating.infrastructure.constant.RateType;
import com.digital.system.rating.ports.incoming.RatesAPI;
import com.digital.system.rating.ports.outgoing.RatesService;
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
@RequestMapping("/api/v1")
public class RatesController implements RatesAPI {

    private final RatesService service;

    @Override
    @GetMapping("/rates")
    public ResponseEntity<List<RateEntityVO>> getRates() {

        log.info(">>>> request for Rates");
        return ResponseEntity.of(service.getRates());
    }

    @Override
    @GetMapping("/rate")
    public ResponseEntity<RateEntityVO> getRates(@RequestParam("type") String type) {

        log.info(">>>> request for Rates with type specified");
        return ResponseEntity.of(service.getRates(RateType.valueOf(type)));
    }


}
