package com.info.controller;

import com.info.service.DatasetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class PageController {
    @Autowired
    DatasetService datasetService;

    @RequestMapping("/main")
    public String getMain(Model model){
        List<String > tlpDatasetList = datasetService.getNameListByType(0);
        List<String> lcdDatasetList = datasetService.getNameListByType(1);
        model.addAttribute("tlpDatasetList",tlpDatasetList);
        model.addAttribute("lcdDatasetList",lcdDatasetList);
        return "main";
    }
}