package com.info.service.impl;

import com.info.service.SparkService;
import org.apache.spark.sql.SparkSession;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class SparkServiceImpl implements SparkService {
    private static String master = "local[*]";
    private static SparkSession spark;

    private SparkSession getSparkSession(){
        if(spark==null){
            synchronized (SparkServiceImpl.class){
                if(spark==null){
                    spark = SparkSession.builder().master(master).getOrCreate();
                }
            }
        }
        return spark;
    }

    @Override
    public void invokeTLJob(Properties algorithmProperties) {
        SparkSession spark = this.getSparkSession();

    }

    @Override
    public void invokeLCJob(Properties algorithmProperties) {

    }
}
