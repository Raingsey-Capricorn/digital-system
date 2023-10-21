package com.digital.endpoints.ports.incoming.adapter.web.view;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Author  : pisethraringsey.suon
 * Email   : pisethraingsey@dr-tech.com
 * Date    : 10/10/23
 * Project : com.digital.system
 */
@Slf4j
@Controller
@RequestMapping("/api/v1/view")
public class IndexViewController {

    @GetMapping
    public String returnIndexView(Model model) {
        log.info(">>> Default index.jsp is loaded.");
        return "/views/index";
    }
}
