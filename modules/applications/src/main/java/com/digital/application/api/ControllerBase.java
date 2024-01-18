package com.digital.application.api;

import lombok.extern.java.Log;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;

import java.util.List;
import java.util.function.Consumer;
import java.util.logging.Level;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
@Log
public abstract class ControllerBase {

    /**
     * @return
     */
    public static Consumer<List<ExchangeFilterFunction>> exchangeRequestFilters() {
        return exchangeFilterFunctions ->
                exchangeFilterFunctions.add((clientRequest, next) -> {
                    clientRequest.headers().forEach((name, values) -> log.log(Level.INFO, String.format("%s : %s", name, values)));
                    log.log(Level.INFO, String.format("Request: '%3s' to %3s", clientRequest.method(), clientRequest.url()));
                    return next.exchange(clientRequest);
                });
    }

}
