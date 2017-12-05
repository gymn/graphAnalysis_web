package com.info.dao;

import com.info.model.Category;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CategoryDao {
    /**
     * 获取所有分类
     * @Param tableName
     * @return
     */
    List<Category> getCategoryList(@Param("tableName") String tableName);
}
