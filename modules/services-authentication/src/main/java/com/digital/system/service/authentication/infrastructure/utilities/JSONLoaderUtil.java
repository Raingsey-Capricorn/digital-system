package com.digital.system.service.authentication.infrastructure.utilities;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.java.Log;

import java.util.ArrayList;
import java.util.List;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 14/8/23
 * Project : lhtk
 */
@Log
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public abstract class JSONLoaderUtil {
    @Data
    @NoArgsConstructor
    public static class Keyword {
        @JsonProperty(value = "javaKeywords")
        private List<String> javaKeywords = new ArrayList<>();
        @JsonProperty(value = "sqlKeywords")
        private List<String> sqlKeywords = new ArrayList<>();
    }

}
