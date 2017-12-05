package com.info.service;

import com.info.model.*;

import java.util.List;

public interface LCGraphService {
    /**
     * 获取所有连边
     * @return
     */
    public List<Link> getLinks();

    /**
     * 根据节点类型返回所有该类型节点
     * @param type 节点类型
     * @return 返回节点list
     */
    public List<Node> getNodesByType(LCNodeType type);

    /**
     * 获取图
     * @param type
     * @return
     */
    public Graph getGraph(LCNodeType type);
}
