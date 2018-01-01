package com.info.controller;

import com.alibaba.fastjson.JSON;
import com.info.model.Graph;
import com.info.model.LCNodeType;
import com.info.service.LCGraphService;
import com.info.service.TLGraphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("file")
public class MainController {
    @Autowired
    LCGraphService lcGraphService;

    @Autowired
    TLGraphService tlGraphService;

    @RequestMapping("/json/tl")
    @ResponseBody
    public String getTLGraphJson(Double threshold, String graphType){
        Graph graph = tlGraphService.getGraph(threshold);
        graph.setType(graphType);
        return JSON.toJSONString(graph);
    }

    /**
     * 获取局部社团挖掘的结果
     * @param nodeType ：in:特征节点，out:非特征节点，all:所有节点
     * @return
     */
    @RequestMapping("/json/lc")
    @ResponseBody
    public String getLCGraphJson(String nodeType, String graphType){
        Graph graph = lcGraphService.getGraph(LCNodeType.valueOf(nodeType.toUpperCase()));
        graph.setType(graphType);
        return JSON.toJSONString(graph);
    }

    @RequestMapping("/maxWeight")
    @ResponseBody
    public Integer getMaxWeight(){
        return tlGraphService.getMaxWeight().intValue()+1;
    }
}
