package com.info.service.impl;

import com.info.dao.CategoryDao;
import com.info.dao.LinkDao;
import com.info.dao.NodeDao;
import com.info.model.Category;
import com.info.model.Graph;
import com.info.model.Link;
import com.info.model.Node;
import com.info.service.TLGraphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TLGraphServiceImpl implements TLGraphService{
    private String nodeTableName = "tl_node";
    private String linkTableName = "tl_link";
    private String categoryTableName = "tl_category";

    @Autowired
    NodeDao nodeDao;

    @Autowired
    LinkDao linkDao;

    @Autowired
    CategoryDao categoryDao;

    @Override
    public List<Link> getLinksOnThreshold(Double threshold) {
        return linkDao.getLinksOnThreshold(linkTableName,threshold);
    }

    @Override
    public List<Node> getNodes() {
        return nodeDao.getNodeList(nodeTableName);
    }

    @Override
    public List<Category> getCategories() {
        return categoryDao.getCategoryList(categoryTableName);
    }

    @Override
    public Graph getGraph(Double threshold) {
        Graph graph = new Graph();
        graph.setType("force");

        List<Category> categoryList = this.getCategories();
        graph.setCategories(categoryList.toArray(new Category[categoryList.size()]));

        List<Node> nodeList = this.getNodes();
        graph.setNodes(nodeList.toArray(new Node[nodeList.size()]));

        List<Link> linkList = this.getLinksOnThreshold(threshold);
        graph.setLinks(linkList.toArray(new Link[linkList.size()]));

        return graph;
    }

    @Override
    public Double getMaxWeight() {
        return linkDao.getMaxWeight(linkTableName);
    }
}
