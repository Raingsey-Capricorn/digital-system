package com.digital.application.web;

import com.digital.application.api.ControllerBase;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */
@Component
public class WebClientCommunicator {

    public static String SERVER_URL;
    public static String TOKEN;

    @Value("${webclient.endpoints.base-url}")
    public void setServerURL(String serverURL) {
        SERVER_URL = serverURL;
    }

    @Value("${webclient.endpoints.authorization}")
    public void setToken(String token) {
        TOKEN = token;
    }

    /**
     * @param uri : endpoint's URI
     * @return WebClient.RequestHeadersSpec's object
     */
    public static WebClient.RequestHeadersSpec<?> request(final String uri) {

        return WebClient.builder()
                .filters(ControllerBase.exchangeRequestFilters())
                .baseUrl(SERVER_URL)
                .build()
                .get()
                .uri(uri)
                .headers(httpHeaders -> {
                    httpHeaders.setBearerAuth(TOKEN);
                    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
                })
                ;
    }
}
