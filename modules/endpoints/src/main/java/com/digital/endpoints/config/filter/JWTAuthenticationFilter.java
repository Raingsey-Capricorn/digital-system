package com.digital.endpoints.config.filter;

import com.digital.endpoints.config.security.JWTService;
import com.digital.endpoints.ports.outgoing.adapter.repository.RepositoryUserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Objects;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 7/10/23
 * Project : com.digital.system
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class JWTAuthenticationFilter extends OncePerRequestFilter {

    private final JWTService jwtService;
    private final RepositoryUserService userService;

    /**
     * @param request
     * @param response
     * @param filterChain
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain) throws ServletException, IOException {


        final String authHeader = request.getHeader("Authorization");
        if (StringUtils.isEmpty(authHeader) || !StringUtils.startsWith(authHeader, "Bearer")) {
            filterChain.doFilter(request, response);
            log.warn("Header doesn't have has key Authorization : {}", authHeader);
            return;
        }
        try {
            final var jwtBearerValue = authHeader.substring(7);
            final var userEmail = jwtService.extractUserName(jwtBearerValue);
            if (StringUtils.isNotEmpty(userEmail)
                    && Objects.isNull(SecurityContextHolder.getContext().getAuthentication())) {
                UserDetails userDetails = userService.userDetailsService().loadUserByUsername(userEmail);
                if (jwtService.isTokenValid(jwtBearerValue, userDetails)) {
                    final var context = SecurityContextHolder.createEmptyContext();
                    final var authToken = new UsernamePasswordAuthenticationToken(
                            userDetails,
                            userEmail,
                            userDetails.getAuthorities()
                    );
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    context.setAuthentication(authToken);
                    SecurityContextHolder.setContext(context);
                }
            }
        } catch (Exception e) {
            log.warn("Authorization Bearer has no info: {}", e.getMessage());
        }
        filterChain.doFilter(request, response);
    }
}
