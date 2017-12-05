DROP DATABASE IF EXISTS graph;
CREATE DATABASE graph DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

--创建时序链路预测结果数据表
CREATE TABLE tl_category(
  id INT,
  name varchar(50)
);

CREATE TABLE tl_node (
  id BIGINT,
  name VARCHAR(50),
  category INT,
  symbolSize INT,
  type INT
);

CREATE TABLE tl_link(
  source VARCHAR(20),
  target VARCHAR(20),
  weight NUMERIC(2,4)
);

--创建局部社团挖掘结果预测表
CREATE TABLE lc_category(
  id INT,
  name varchar(50)
);

CREATE TABLE lc_node (
  id BIGINT,
  name VARCHAR(50),
  category INT,
  symbolSize INT,
  type INT
);

CREATE TABLE lc_link(
  source INT,
  target INT,
  weight NUMERIC(2,4)
);