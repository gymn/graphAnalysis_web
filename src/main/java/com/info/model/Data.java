package com.info.model;

public class Data {
    Graph graph;
    Graph testGraph;
    Metrics metrics;

    public Data(Graph graph, Graph testGraph, Metrics metrics) {
        this.graph = graph;
        this.testGraph = testGraph;
        this.metrics = metrics;
    }

    public Graph getGraph() {
        return graph;
    }

    public void setGraph(Graph graph) {
        this.graph = graph;
    }

    public Graph getTestGraph() {
        return testGraph;
    }

    public void setTestGraph(Graph testGraph) {
        this.testGraph = testGraph;
    }

    public Metrics getMetrics() {
        return metrics;
    }

    public void setMetrics(Metrics metrics) {
        this.metrics = metrics;
    }
}
