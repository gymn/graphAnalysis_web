package com.info.controller;

import com.info.service.SparkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/spark")
public class SparkJobController {
    @Autowired
    SparkService sparkService;

    @RequestMapping("/tl")
    @ResponseBody
    public Integer submitLinkPredictionJob(String graphFilePath, String narrowIndex, String numberOfWindows){
        System.out.println(narrowIndex+"-------"+numberOfWindows);
        String mainClass = "com.hunan.tlp.TlpMain";
        String[] args={graphFilePath,narrowIndex,numberOfWindows};
        return sparkService.invokeSparkJob(mainClass,args);
    }

    @RequestMapping("/lc")
    @ResponseBody
    public Integer submitLocalCommunityDetectionJob(String graphFilePath,String seeds,String maxSteps,String attractThreshold){
        String mainClass = "com.hunan.lcd.LcdMain";
        String[] args = {graphFilePath,attractThreshold,maxSteps,seeds};
        return sparkService.invokeSparkJob(mainClass,args);
    }
}
