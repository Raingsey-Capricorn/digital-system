package com.digital.system.rating.domain.vo;

import com.digital.system.rating.infrastructure.constant.RateType;
import com.digital.system.rating.infrastructure.database.entities.RateEntity;
import com.digital.system.rating.infrastructure.database.models.Rate;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 24/1/24
 * Project : com.digital.system
 */
@Getter
@NoArgsConstructor
@Accessors(chain = true)
public class RateEntityVO implements Rate {

    @JsonProperty("data")
    @Setter(AccessLevel.PRIVATE)
    private RateEntity rate = new RateEntity();

    /**
     * For east loading entity from repository
     *
     * @param rate : rate value
     */
    public RateEntityVO(RateEntity rate) {
        this.rate = rate;
    }

    /**
     * For assigning data to entity without expose the entity to the client
     *
     * @param type : Rate type
     * @param rate : rate value
     */
    public RateEntityVO(RateType type, Double rate) {
        this.rate.setType(type);
        this.rate.setRate(rate);
    }

}
