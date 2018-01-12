package com.info.service.impl;

import com.info.dao.DatasetDao;
import com.info.model.Dataset;
import com.info.service.DatasetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DatasetServiceImpl implements DatasetService {
    @Autowired
    DatasetDao datasetDao;

    @Override
    public List<String> getNameListByType(int type) {
        return datasetDao.getAllDatasetName(type);
    }

    @Override
    public Dataset getDatasetByName(String name) {
        return datasetDao.getDatasetByName(name);
    }

    @Override
    public void addDataset(Dataset dataset) {
        datasetDao.addDataset(dataset);
    }

    @Override
    public void removeDataset(String name) {
        datasetDao.deleteDataset(name);
    }

    @Override
    public boolean exist(String name) {
        return !(datasetDao.getDatasetByName(name) == null);
    }
}
