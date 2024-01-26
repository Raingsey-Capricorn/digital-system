package com.digital.system.loanservice.infrastructure.http;

import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriBuilder;

import java.net.URI;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.logging.Level;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
@Log
@Component
public class WebClientCommunicator {

    public static String SERVER_URL;

    @Value("${webclient.endpoints.base-url}")
    public void setServerURL(String serverURL) {
        SERVER_URL = serverURL;
    }

    /**
     * @param uri : endpoint's URI
     * @return WebClient.RequestHeadersSpec's object
     */
    public static WebClient.RequestHeadersSpec<?> request(final String uri) {

        return WebClient.builder()
                .filters(exchangeRequestFilters())
                .baseUrl(SERVER_URL)
                .build()
                .get()
                .uri(uri)
                .headers(httpHeaders -> httpHeaders.setContentType(MediaType.APPLICATION_JSON));
    }

    /**
     * @param uriFunction
     * @return
     */
    public static WebClient.RequestHeadersSpec<?> request(final Function<UriBuilder, URI> uriFunction) {

        return WebClient.builder()
                .filters(exchangeRequestFilters())
                .baseUrl(SERVER_URL)
                .build()
                .get()
                .uri(uriFunction)
                .headers(httpHeaders -> httpHeaders.setContentType(MediaType.APPLICATION_JSON));
    }

    /**
     * @return
     */
    private static Consumer<List<ExchangeFilterFunction>> exchangeRequestFilters() {
        return exchangeFilterFunctions ->
                exchangeFilterFunctions.add((clientRequest, next) -> {
                    clientRequest.headers().forEach((name, values) -> log.log(Level.INFO, String.format("%s : %s", name, values)));
                    log.log(Level.INFO, String.format("Request: '%3s' to %3s", clientRequest.method(), clientRequest.url()));
                    return next.exchange(clientRequest);
                });
    }
}
