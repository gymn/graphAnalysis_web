package com.info.utils;

import java.io.*;

public class StreamProcessorRunnable implements Runnable {
    private String filePath = null;
    private BufferedReader reader = null;
    public StreamProcessorRunnable(InputStream is,String filePath){
        this.filePath = filePath;
        this.reader = new BufferedReader(new InputStreamReader(is));
    }

    @Override
    public void run() {
        PrintWriter pw;
        try {
            pw = new PrintWriter(filePath);

            String line = reader.readLine();

            while(line!=null){
                pw.write(line+"\n");
                line = reader.readLine();
            }
            pw.close();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                reader.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
