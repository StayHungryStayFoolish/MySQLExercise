# 显示当前 MySQL 版本号
SELECT version();

SHOW DATABASES;

DROP DATABASE IF EXISTS `mysql_exercise`;
CREATE DATABASE IF NOT EXISTS `mysql_exercise` CHARACTER SET `utf8`;

USE `mysql_exercise`;

SHOW FULL TABLES FROM mysql_exercise;

DROP TABLE IF EXISTS product;
CREATE TABLE IF NOT EXISTS product
(
    pid   INT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(20),
    price DOUBLE,
    pdate DATE,
    cid   int
);

#目录表
DROP TABLE IF EXISTS category;
CREATE TABLE category
(
    id    INT PRIMARY KEY,
    cname VARCHAR(100)
);

INSERT INTO product
VALUES (NULL, '泰国大榴莲', 98, NULL, 1);
INSERT INTO product
VALUES (NULL, '新疆切糕', 68, NULL, 1);
INSERT INTO product
VALUES (NULL, '泰国大枣', 38, NULL, 1);
INSERT INTO product
VALUES (NULL, '新疆切糕', 68, NULL, 2);
INSERT INTO product
VALUES (NULL, '十三香', 10, NULL, 2);
INSERT INTO product
VALUES (NULL, '泰国大枣', 20, NULL, 2);

INSERT INTO product
VALUES (NULL, '泰国大枣', 98, NULL, 20); #没有对应
INSERT INTO product
VALUES (NULL, 'iPhone手机', 800, NULL, 30);#没有对应

INSERT INTO category
VALUES (1, '国外食品');
INSERT INTO category
VALUES (2, '国内食品');
INSERT INTO category
VALUES (3, '国内服装');
#没有对应

# 查询所有字段，其中 pname、price 去重。如果 group by 后边只有 pname 字段，则事实上只对 name 去重，只有 distinct 和 group by  后边字段保持一直，结果才会正确
SELECT *, count(DISTINCT pname, price)
FROM product
GROUP BY pname, price;

# Distinct 后边的字段都会并入去重条件，当两个字段值同时重复时，只显示一条数据
SELECT DISTINCT price, pname
FROM product
ORDER BY pid;

# Group By 后边的字段都会并入去重条件，当两个字段值同时重复时，只显示一条数据
# 结果同上
SELECT pname, price
FROM product
GROUP BY product.pname, product.price
ORDER BY pid;

SELECT *
FROM product
WHERE pname = '十三香';

SELECT *
FROM product
WHERE price > 60;

SELECT *
FROM product
WHERE pname LIKE '%新%';

SELECT *
FROM product
WHERE pid IN (2, 5, 8);

SELECT *
FROM product
WHERE pid BETWEEN 2 AND 8;

SELECT sum(price)
FROM product;

SELECT avg(price)
FROM product;

SELECT count(*)
FROM product;

# 分组统计每组商品的平均价格，并且平均价格> 60;
# 注意事项
# select 语句中的列（非聚合函数列），必须出现在 group by 子句中
# group by 子句中的列，不一定要出现在 select 语句中
# 聚合函数只能出现 select 语句中或者 having 语句中，一定不能出现在 where 语句中。
SELECT cid, avg(price)
FROM product
GROUP BY cid
HAVING avg(price) > 60;

EXPLAIN SELECT *
FROM product
WHERE exists
          (SELECT pname FROM product WHERE pid = 8);

EXPLAIN SELECT pname
        FROM product
        WHERE pid = 1;

## 查询是否支持分析功能
show variables like 'have_profiling';
## 查看开启状态
select @@profiling;
select @@profiling;
## 开启分析功能，默认是为0，关闭状态
SET profiling = 1;
## 列出所有数据
SHOW PROFILES;

show profile CPU ,block io for query 212;


