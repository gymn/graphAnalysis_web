package com.info.utils;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

@Component
public class FileUtil {
    public void upload(HttpServletRequest request) throws IllegalStateException, IOException {

        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if(multipartResolver.isMultipart(request))
        {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
            //获取multiRequest 中所有的文件名
            Iterator iter = multiRequest.getFileNames();

            while(iter.hasNext())
            {
                //一次遍历所有文件
                MultipartFile file = multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                    CommonsMultipartFile cf= (CommonsMultipartFile)file;
                    DiskFileItem fi = (DiskFileItem)cf.getFileItem();
                    File inputFile = fi.getStoreLocation();
                    HdfsFileSystem.createFile(inputFile, "hdfs://localhost:9000/tmp/upload/temporal/temporalLinks.csv");
                }
            }
        }
    }
}
