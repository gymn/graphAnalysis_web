package com.info.model;

public class Node {
    private String name;
    private Integer value;
    private Integer category;
    private Double symbolSize;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public Double getSymbolSize() {
        return symbolSize;
    }

    public void setSymbolSize(Double symbolSize) {
        this.symbolSize = symbolSize;
    }
}
