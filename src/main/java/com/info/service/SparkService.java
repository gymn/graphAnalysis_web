package com.info.service;

public interface SparkService {
    Integer invokeSparkJob(String mainClass, String[] args);
}
