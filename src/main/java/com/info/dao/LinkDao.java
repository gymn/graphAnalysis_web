package com.info.dao;

import com.info.model.Link;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LinkDao {
    /**
     * 根据权重阈值过滤出连边
     * @param threshold
     * @return
     */
    List<Link> getLinksOnThreshold(@Param("tableName") String tableName, @Param("threshold") Double threshold);

    /**
     * 获取连边权重最大值
     * @return
     */
    Double getMaxWeight(@Param("tableName") String tableName);

    /**
     * 获取连边权重最小值
     * @return
     */
    Double getMinWeight(@Param("tableName") String tableName);

    /**
     * 获取所有连边
     * @return
     */
    List<Link> getLinkList(@Param("tableName") String tableName);
}
