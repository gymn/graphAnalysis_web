package com.info.service.impl;

import com.info.service.SparkService;
import com.info.utils.AppConfig;
import com.info.utils.StreamProcessorRunnable;
import org.apache.spark.launcher.SparkLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class SparkServiceImpl implements SparkService {
    @Autowired
    private AppConfig appConfig;

    @Override
    public Integer invokeSparkJob(String mainClass, String[] args) {
        SparkLauncher launcher = new SparkLauncher()
                .addSparkArg("--jars",appConfig.jdbcDriver)
                .addSparkArg("--driver-class-path",appConfig.jdbcDriver)
                .setSparkHome(appConfig.sparkHome)
                .setAppResource(appConfig.appResource)
                .setMaster(appConfig.masterUrl)
                .setMainClass(mainClass)
                .addAppArgs(args);
        try {
            Process process = launcher.launch();
            StreamProcessorRunnable inputStreamProcessor = new StreamProcessorRunnable(process.getInputStream(),appConfig.sparkOutPutPath);
            StreamProcessorRunnable errorStreamProcessor = new StreamProcessorRunnable(process.getErrorStream(),appConfig.sparkErrorPath);
            new Thread(inputStreamProcessor).start();
            new Thread(errorStreamProcessor).start();

            int existCode = process.waitFor();
            System.out.println(existCode);
            return existCode;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
