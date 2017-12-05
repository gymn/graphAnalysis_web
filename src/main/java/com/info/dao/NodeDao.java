package com.info.dao;

import com.info.model.Node;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NodeDao {
    /**
     * 根据id获取Node
     * @param tableName
     * @param id
     * @return
     */
    Node getNodeById(@Param("tableName") String tableName, @Param("id") Long id);

    /**
     * 根据种类获取节点
     * @Param tableName
     * @param type 1:特征节点 0：非特征节点
     * @return
     */
    List<Node> getNodesByType(@Param("tableName") String tableName, @Param("type") int type);

    /**
     * 获取所有节点
     * @Param tableName
     * @return
     */
    List<Node> getNodeList(@Param("tableName") String tableName);
}
