package com.digital.endpoints.infrastructure.web.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

import java.util.UUID;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 22/1/24
 * Project : com.digital.system
 */

@Builder
public record PersonResponse(

        @Schema(name = "ID", description = "UUID of this record")
        UUID id,
        @Schema(name = "firstName", description = "FirstName of this User")
        String firstName,
        @Schema(name = "lastName", description = "LastName of this User")
        String lastName,
        @Schema(name = "gender", description = "Gender of this User")
        String gender) {
}
