package com.info.utils;

public class AppConfig {
    public String sparkHome;
    public String appResource;
    public String masterUrl;
    public String jdbcDriver;
    public String sparkOutPutPath;
    public String sparkErrorPath;

    public String getSparkErrorPath() {
        return sparkErrorPath;
    }

    public void setSparkErrorPath(String sparkErrorPath) {
        this.sparkErrorPath = sparkErrorPath;
    }

    public String getSparkOutPutPath() {
        return sparkOutPutPath;
    }

    public void setSparkOutPutPath(String sparkOutPutPath) {
        this.sparkOutPutPath = sparkOutPutPath;
    }
    public String getJdbcDriver() {
        return jdbcDriver;
    }

    public void setJdbcDriver(String jdbcDriver) {
        this.jdbcDriver = jdbcDriver;
    }

    public String getSparkHome() {
        return sparkHome;
    }

    public void setSparkHome(String sparkHome) {
        this.sparkHome = sparkHome;
    }

    public String getAppResource() {
        return appResource;
    }

    public void setAppResource(String appResource) {
        this.appResource = appResource;
    }

    public String getMasterUrl() {
        return masterUrl;
    }

    public void setMasterUrl(String masterUrl) {
        this.masterUrl = masterUrl;
    }
}
