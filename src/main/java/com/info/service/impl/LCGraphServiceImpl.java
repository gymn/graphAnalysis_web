package com.info.service.impl;

import com.info.dao.CategoryDao;
import com.info.dao.LinkDao;
import com.info.dao.NodeDao;
import com.info.model.*;
import com.info.service.LCGraphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LCGraphServiceImpl implements LCGraphService {
    private String nodeTableName = "lc_node";
    private String linkTableName = "lc_link";
    private String categoryTableName = "lc_category";

    @Autowired
    NodeDao nodeDao;

    @Autowired
    LinkDao linkDao;

    @Autowired
    CategoryDao categoryDao;

    @Override
    public List<Link> getLinks() {
        return linkDao.getLinkList(linkTableName);
    }

    @Override
    public List<Node> getNodesByType(LCNodeType type) {
        if(type==LCNodeType.IN || type==LCNodeType.OUT) {
            System.out.println("获取部分节点-------------------------------------------");
            return nodeDao.getNodesByType(nodeTableName, type.getTypeCode());
        }
        else {
            System.out.println("获取所有节点----------------------------------------------");
            return nodeDao.getNodeList(nodeTableName);
        }
    }

    @Override
    public Graph getGraph(LCNodeType type) {
        Graph graph = new Graph();
        graph.setType("force");

        List<Category> categoryList = categoryDao.getCategoryList(categoryTableName);
        graph.setCategories(categoryList.toArray(new Category[categoryList.size()]));

        List<Node> nodeList = this.getNodesByType(type);
        graph.setNodes(nodeList.toArray(new Node[nodeList.size()]));

        List<Link> linkList = this.getLinks();
        graph.setLinks(linkList.toArray(new Link[linkList.size()]));
        return graph;
    }
}
