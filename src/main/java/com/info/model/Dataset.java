package com.info.model;

public class Dataset {
    private String name;
    private Integer type;
    private String trainPath;
    private String testPath;

    public Dataset(String name, Integer type, String trainPath, String testPath) {
        this.name = name;
        this.type = type;
        this.trainPath = trainPath;
        this.testPath = testPath;
    }

    public Dataset() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getTrainPath() {
        return trainPath;
    }

    public void setTrainPath(String trainPath) {
        this.trainPath = trainPath;
    }

    public String getTestPath() {
        return testPath;
    }

    public void setTestPath(String testPath) {
        this.testPath = testPath;
    }
}
