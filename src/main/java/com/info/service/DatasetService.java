package com.info.service;

import com.info.dao.DatasetDao;
import com.info.model.Data;
import com.info.model.Dataset;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface DatasetService {
    /**
     * 获取某一类型的所有数据集名称
     * @param type
     * @return
     */
    public List<String> getNameListByType(int type);

    /**
     * 根据数据集名称获取数据集对象
     * @param name
     * @return
     */
    public Dataset getDatasetByName(String name);

    /**
     * 插入一条数据集信息
     * @param dataset
     */
    public void addDataset(Dataset dataset);

    /**
     * 删除一条数据集信息
     * @param name
     */
    public void removeDataset(String name);

    /**
     * 判断数据名称是否已经存在
     * @param name
     * @return
     */
    public boolean exist(String name);
}
