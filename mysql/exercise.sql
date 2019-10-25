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
VALUES (3, '国内服装'); #没有对应

DESC product;

SELECT *
FROM product;

SELECT version();
