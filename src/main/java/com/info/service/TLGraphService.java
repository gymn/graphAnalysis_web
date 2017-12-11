package com.info.service;

import com.info.model.*;

import java.util.List;

public interface TLGraphService {
    /**
     * 根据权重阈值获取连边
     * @param threshold
     * @return
     */
    public List<Link> getLinksOnThreshold(Double threshold);

    /**
     * 获取所有节点
     * @return
     */
    public List<Node> getNodes();

    /**
     * 获取所有分类
     * @return
     */
    public List<Category> getCategories();

    /**
     * 获取整个图
     * @return
     */
    public Graph getGraph(Double threshold);

    /**
     * 获取边权重的最大值
     * @return
     */
    public Double getMaxWeight();
}
