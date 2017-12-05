package com.info.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/spark")
public class SparkJobController {
    @RequestMapping("/temporalPrediction")
    public void submitLinkPredictionJob(){
        System.out.println("111");
    }
}
