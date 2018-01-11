package com.info.model;

public class Link {
    String source;
    String target;
    Double weight;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    @Override
    public boolean equals(Object o) {
        if(o.getClass().equals(this.getClass())) {
            Link other = (Link)o;
            return this.source.equals(other.source) && this.target.equals(other.target);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
