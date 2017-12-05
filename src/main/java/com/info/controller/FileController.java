package com.info.controller;

import com.alibaba.fastjson.JSON;
import com.info.model.Graph;
import com.info.model.LCNodeType;
import com.info.service.LCGraphService;
import com.info.service.TLGraphService;
import com.info.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequestMapping("file")
public class FileController {
    @Autowired
    FileUtil fileUtil;

    @Autowired
    LCGraphService lcGraphService;

    @Autowired
    TLGraphService tlGraphService;

    @RequestMapping("/upload")
    @ResponseBody
    public String springUpload(HttpServletRequest request) throws IllegalStateException, IOException
    {
        fileUtil.upload(request);
        return "File upload success!";
    }

    @RequestMapping("/json/tl")
    @ResponseBody
    public String getTLGraphJson(Double threshold, String graphType){
        Graph graph = tlGraphService.getGraph(threshold);
        graph.setType(graphType);
        System.out.println(JSON.toJSONString(graph));
        return JSON.toJSONString(graph);
    }

    @RequestMapping("/json/lc")
    @ResponseBody
    public String getLCGraphJson(String nodeType){
        Graph graph = lcGraphService.getGraph(LCNodeType.valueOf(nodeType.toUpperCase()));
        System.out.println(JSON.toJSONString(graph));
        return JSON.toJSONString(graph);
    }
}
