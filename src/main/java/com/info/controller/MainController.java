package com.info.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.info.model.*;
import com.info.service.CommonGraphService;
import com.info.service.DatasetService;
import com.info.service.LCGraphService;
import com.info.service.TLGraphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("file")
public class MainController {
    @Autowired
    LCGraphService lcGraphService;

    @Autowired
    TLGraphService tlGraphService;

    @Autowired
    CommonGraphService testGraphService;

    @Autowired
    DatasetService datasetService;

    @RequestMapping("/tlp/data")
    @ResponseBody
    public String getTLGraphJson(Double threshold){
        String panel = "tlp";
        Graph graph = tlGraphService.getGraph(threshold);
        Graph testGraph = testGraphService.getTestGraph(panel);
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
    public String getLCGraphJson(String nodeType){
        String panel = "lcd";
        Graph graph = lcGraphService.getGraph(LCNodeType.valueOf(nodeType.toUpperCase()));
        Graph testGraph = testGraphService.getTestGraph(panel);
        Metrics metrics = testGraphService.getMetricsLCD(graph,testGraph);
        Data data = new Data(graph,testGraph,metrics);
        return JSON.toJSONString(data);
    }

    @RequestMapping("/tlp/maxWeight")
    @ResponseBody
    public Integer getMaxWeight(){
        return tlGraphService.getMaxWeight().intValue()+1;
    }

    @RequestMapping(value = "/dataset/add",method = RequestMethod.POST)
    @ResponseBody
    public String addDataset(@RequestBody JSONObject requestJson){
        String name = requestJson.getString("name");
        if(datasetService.exist(name)){
            return "no";
        }else{
            int type = requestJson.getInteger("type");
            String trainPath = requestJson.getString("trainPath");
            String testPath = requestJson.getString("testPath");
            datasetService.addDataset(new Dataset(name,type,trainPath,testPath));
            return "ok";
        }
    }
}
