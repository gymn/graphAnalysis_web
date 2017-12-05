package com.info.model;

public class Graph {
    private String type;
    private Category[] categories;
    private Node[] nodes;
    private Link[] links;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Category[] getCategories() {
        return categories;
    }

    public void setCategories(Category[] categories) {
        this.categories = categories;
    }

    public Node[] getNodes() {
        return nodes;
    }

    public void setNodes(Node[] nodes) {
        this.nodes = nodes;
    }

    public Link[] getLinks() {
        return links;
    }

    public void setLinks(Link[] links) {
        this.links = links;
    }
}
