package com.info.dao;

import com.info.model.Dataset;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Repository
public interface DatasetDao {
    /**
     * 根据type获取数据集
     * @return
     */
    List<String> getAllDatasetName(Integer type);

    /**
     * 根据数据集名称获取数据集
     * @param name
     * @return
     */
    Dataset getDatasetByName(String name);

    /**
     * 插入一个数据集信息
     * @param dataset
     * @return
     */
    void addDataset(Dataset dataset);

    /**
     * 根据数据集名称删除数据集信息
     * @param name
     * @return
     */
    void deleteDataset(String name);
}
