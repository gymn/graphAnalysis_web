package com.info.model;

public class Metrics {
    private Double precision;
    private Double auc;
    private Double recall;
    private Double f;

    public Double getPrecision() {
        return precision;
    }

    public void setPrecision(Double precision) {
        this.precision = precision;
    }

    public Double getAuc() {
        return auc;
    }

    public void setAuc(Double auc) {
        this.auc = auc;
    }

    public Double getRecall() {
        return recall;
    }

    public void setRecall(Double recall) {
        this.recall = recall;
    }

    public Double getF() {
        return f;
    }

    public void setF(Double f) {
        this.f = f;
    }
}
