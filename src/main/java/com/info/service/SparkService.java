package com.info.service;

import java.util.Properties;

public interface SparkService {
    void invokeTLJob(Properties algorithmProperties);
    void invokeLCJob(Properties algorithmProperties);
}
