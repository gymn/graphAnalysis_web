package com.info.controller;

import com.alibaba.fastjson.JSON;
import com.info.model.Data;
import com.info.model.Graph;
import com.info.model.LCNodeType;
import com.info.model.Metrics;
import com.info.service.LCGraphService;
import com.info.service.TLGraphService;
import com.info.service.impl.TestGraphServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Member;

@Controller
@RequestMapping("file")
public class MainController {
    @Autowired
    LCGraphService lcGraphService;

    @Autowired
    TLGraphService tlGraphService;

    @Autowired
    TestGraphServiceImpl testGraphService;

    @RequestMapping("/tlp/data")
    @ResponseBody
    public String getTLGraphJson(Double threshold, String dataset){
        Graph graph = tlGraphService.getGraph(threshold);
        Graph testGraph = testGraphService.getGraph(dataset);
        Metrics metrics = testGraphService.getMetricsTLP(graph,testGraph);
        Data data = new Data(graph,testGraph,metrics);
        return JSON.toJSONString(data);
    }

    /**
     * 获取局部社团挖掘的结果
     * @param nodeType ：in:特征节点，out:非特征节点，all:所有节点
     * @return
     */
    @RequestMapping("/lcd/data")
    @ResponseBody
    public String getLCGraphJson(String nodeType, String dataset){
        Graph graph = lcGraphService.getGraph(LCNodeType.valueOf(nodeType.toUpperCase()));
        Graph testGraph = testGraphService.getGraph(dataset);
        Metrics metrics = testGraphService.getMetricsLCD(graph,testGraph);
        Data data = new Data(graph,testGraph,metrics);
        return JSON.toJSONString(data);
    }

    @RequestMapping("/maxWeight")
    @ResponseBody
    public Integer getMaxWeight(){
        return tlGraphService.getMaxWeight().intValue()+1;
    }
}
