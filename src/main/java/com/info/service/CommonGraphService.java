package com.info.service;

import com.info.model.Graph;
import com.info.model.Metrics;

public interface CommonGraphService {
    /**
     * 获取整个图
     * @return
     */
    public Graph getTestGraph(String panel);

    /**
     * 计算时序链路预测AUC和准确率
     * @return
     */
    public Metrics getMetricsTLP(Graph graph, Graph testGraph);

    /**
     * 计算局部社团挖掘的准确率、召回率和F值
     * @return
     */
    public Metrics getMetricsLCD(Graph graph, Graph testGraph);
}
