package com.digital.endpoints.infrastructure.web.response;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */

@Builder
public record JwtAuthenticationResponse(
        @Schema(name = "token", description = "Access Token")
        String token) {
}
