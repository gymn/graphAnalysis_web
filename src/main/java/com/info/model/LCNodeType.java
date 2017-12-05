package com.info.model;

public enum LCNodeType {
    /**
     * 特征节点
     */
    IN(1),
    /**
     * 非特征节点
     */
    OUT(0),

    /**
     * 所有节点
     */
    ALL(2);

    LCNodeType(int _typeCode){
        this.typeCode = _typeCode;
    }

    private int typeCode;

    public int getTypeCode(){
        return typeCode;
    }
}
