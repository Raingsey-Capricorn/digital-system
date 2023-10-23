package com.digital.endpoints.infrastructure.config.security.service;

import com.digital.endpoints.infrastructure.config.constants.Authority;
import com.digital.endpoints.infrastructure.config.security.JWTService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 5/10/23
 * Project : com.digital.system
 */
@Slf4j
@Service
public class JWTUserDetailsService implements JWTService {

    @Value("${jwt.secret.key}")
    private String jwtSigningKey;
    private final long tokenExpiryDuration = 60 * 60 * 1000;
    private final Date tokenCreatedAt = new Date();
    private final Date tokenValidity = new Date(tokenCreatedAt.getTime() + TimeUnit.MINUTES.toMillis(tokenExpiryDuration));

    @Override
    public String extractUserName(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    @Override
    public String generateToken(UserDetails userDetails) {

        return this.generateToken(new HashMap<>() {{
            put("email", userDetails.getUsername());
            put("authorities", userDetails.getAuthorities());
        }}, userDetails);
    }

    @Override
    public boolean isTokenValid(String token, UserDetails userDetails) {
        return (extractUserName(token).equals(userDetails.getUsername()) && !isTokenExpired(token));
    }

    /**
     * @param token           : request token
     * @param claimsResolvers : JDK 17 function argument
     * @param <T>             : JWT claim's type
     * @return Claims's object
     */
    private <T> T extractClaim(String token, Function<Claims, T> claimsResolvers) {
        final Claims claims = Jwts.parser()
                .verifyWith(decodeHmacShaKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
        return claimsResolvers.apply(claims);
    }

    /**
     * @param extraClaims : JWT claims
     * @param userDetails : Spring security UserDetails
     * @return Jwt string
     */
    private String generateToken(Map<String, Object> extraClaims, UserDetails userDetails) {

        return Jwts.builder()
                .claims(extraClaims)
                .issuedAt(tokenCreatedAt)
                .expiration(tokenValidity)
                .encodePayload(true)
                .issuer(Authority.ROLE_ADMIN)
                .subject(userDetails.getUsername())
                .signWith(this.decodeHmacShaKey())
                .compact();
    }

    /**
     * @param token : request token
     * @return true/false imply is expired or valid
     */
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    /**
     * @param token : request token
     * @return date
     */
    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    /**
     * @return : decoded SecretKey
     */
    private SecretKey decodeHmacShaKey() {

        /* How to generate secretKey for calling the method below Keys.hmacShaKeyFor

        final var algorithm = "HmacSHA512";
        final var data = "what_ever_data";
        final var readableKey = "plain_text_secert_key";
        var secretKey = new org.apache.commons.codec.digest.HmacUtils(algorithm, readableKey.getBytes(StandardCharsets.UTF_8)).hmacHex(data);

        !!!save the secretKey to file for reading back to check JWT key-has comparison
        */

        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSigningKey));
    }

}
