package com.info.controller;

import com.alibaba.fastjson.JSONObject;
import com.info.model.Dataset;
import com.info.service.DatasetService;
import com.info.service.SparkService;
import org.jboss.netty.handler.codec.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/spark")
public class SparkJobController {
    @Autowired
    SparkService sparkService;

    @Autowired
    DatasetService datasetService;

    @RequestMapping(value = "/tlp",method = RequestMethod.POST)
    @ResponseBody
    public Integer submitLinkPredictionJob(@RequestBody JSONObject requestJson){
        String mainClass = "com.hunan.tlp.TlpMain";
        String name = requestJson.getString("name");
        Dataset dataset = datasetService.getDatasetByName(name);
        String graphFilePath = dataset.getTrainPath();
        String testFilePath = dataset.getTestPath();

        String narrowIndex = requestJson.getString("narrowIndex");
        String numberOfWindows = requestJson.getString("numberOfWindows");
        String[] args={graphFilePath,testFilePath, narrowIndex,numberOfWindows};
        return sparkService.invokeSparkJob(mainClass,args);
    }

    @RequestMapping(value = "/lcd" ,method = RequestMethod.POST)
    @ResponseBody
    public Integer submitLocalCommunityDetectionJob(@RequestBody JSONObject requestJson){
        String mainClass = "com.hunan.lcd.LcdMain";
        String name = requestJson.getString("name");
        Dataset dataset = datasetService.getDatasetByName(name);
        String graphFilePath = dataset.getTrainPath();
        String testFilePath = dataset.getTestPath();

        String attractThreshold = requestJson.getString("attractThreshold");
        String maxSteps = requestJson.getString("maxSteps");
        String seeds = requestJson.getString("seeds");
        String[] args = {graphFilePath,testFilePath, attractThreshold,maxSteps,seeds};
        return sparkService.invokeSparkJob(mainClass,args);
    }
}
