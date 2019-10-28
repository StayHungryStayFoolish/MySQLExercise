## MySQL 语法

## SQL 语法顺序

```mysql
SELECT DISTINCT <select_list>
FROM <left_table>
<join_type> JOIN <right_table>
ON <join_condition>
WHERE <where_condition>
GROUP BY <group_by_list>
HAVING <having_condition>
ORDER BY <order_by_condition>
LIMIT <limit_number>
```

## SQL 解析顺序

```mysql
# 行过滤
1 FROM <left_table>
2 ON <join_condition> # 第二步和第三步会循环执行
3 <join_type> JOIN <right_table> # 第二步和第三步会循环执行
4 WHERE <where_condition> # 第四步会循环执行，多个条件的执行顺序是从左往右的
5 GROUP BY <group_by_list> 
6 HAVING <having_condition>
# 列过滤 
7 SELECT  # 分组之后才会执行SELECT
8 DISTINCT <select_list>
# 排序 
9 ORDER BY <order_by_condition>
# MySQL附加 
10 LIMIT <limit_number> # 前9步都是SQL92标准语法。LIMIT 是MySQL的独有语法。
```

## 基础语法

1.  **Constraint**

    | Primary Key     | 主键约束     | 唯一约束+非空约束=主键约束 |
    | --------------- | ------------ | -------------------------- |
    | **Not Null**    | **非空约束** |                            |
    | **Unique**      | **唯一约束** |                            |
    | **Foreign Key** | **外检约束** |                            |
    | **Unsigned**    | **非负约束** | **MySQL 自定义标准**       |

    

2.  **DDL** `Data Definition Language` 

    ```mysql
    # 关键词
    CREATE
    DROP
    ALTER
    
    # CREATE 
    # 创建数据库
    CREATE DATABASE database_name;
    
    # 创建表
    CREATE TABLE database_name.table_name (
      id     INT AUTO_INCREMENT PRIMARY KEY
      COMMENT 'ID PK',
      name   VARCHAR(255)              NOT NULL
      COMMENT '姓名',
      age    INT UNSIGNED              NOT NULL
      COMMENT '年龄',
      gender VARCHAR(6) DEFAULT 'Male' NOT NULL
      COMMENT '性别',
      cardId INT UNSIGNED UNIQUE       NOT NULL
      COMMENT '身份证'
    )
      COMMENT '测试表格';
    
    # DROP 
    # 删除数据库
    DROP DATABASE IF EXISTS database_name;
    # 删除表
    DROP TABLE IF EXISTS database_name.table_name;
    
    # ALETER
    # ADD COLUMN 添加列，在某一个位置后边 AFTER ，如果没有 AFTER，默认出现在最后一个。
    ALTER TABLE database_name.table_name
        ADD COLUMN new_column INT  AFTER column_name;
    
    # RENAME 更改表格名字
    ALTER TABLE database_name.table_name
        RENAME database_name.new_table_name;
    
    # MODIFY 更改列的数据类型
    ALTER TABLE database_name.table_name
      MODIFY COLUMN column_name VARCHAR(255);
      
    # 删除指定字段 
    ALTER TABLE database_name.table_name DROP column_name;  
    ```

3.  **DML** `Data Manipulate Language` 改变数据

    ```mysql
    # 关键词
    INSERT （语句关键词 VALUE ）
    UPDATE （语句关键词 SET WHERE ）
    DELETE （语句关键词 WHERE ）
    
    # INSERT 
    INSERT INTO database_name.table_name VALUES (NULL, 'Bo', 18, 'Male' ,20010101);
    # UPDATE
    UPDATE database_name.table_name SET name = 'Tom', age = 20 WHERE id = 1;
    # DELETE 
    DELETE FROM database_name.table_name WHERE id = 1;
    DELETE FROM database_name.table_name WHERE gender IS NULL;
    ```

4.  **DQL** `Data Query Language` 不改变数据

    ```mysql
    # 关键词
    SHOW
    SELECT
    
    # SHOW
    SHOW DATABASES;
    SHOW TABLES FROME database_name;
    # 显示该数据库所有表详细信息，包含引擎、索引、自增、表格注释
    SHOW TABLE STATUS FROM database_name;
    # 显示表格的详细信息，包含字段、数据类型、字符集、权限等
    SHOW FULL COLUMNS FROM table_name; 
    # 显示外检开启状态
    SHOW VARIABLES LIKE '%FOREIGN%';
    # 显示字符集
    SHOW VARIABLES LIKE 'char%';
    # 显示索引信息
    SHOW INDEX FROM table_name;
    ```

5.  **DTL** `Data Transaction Language`

    ```mysql
    # 事务的 ACID 特性
    # A 原子性 Atomicity
    # 一个事务中所有操作，不会结束再中间的环节，要么全部完成，要么都不完成
    
    # C 一致性 Consistency
    # 在事务开启前和结束后，数据库的完整性没有被破坏。
    
    # I 隔离性 Isolation 
    # 数据库允许多个并发事务对其数据进行读写、修改能力。隔离性则是为了防止多个事务并发执行时，由于交叉执行而导致的数据不一致。
    
    # D 持久性 Durability
    # 事务处理结束后，对数据的修改是永久性的，即使系统故障也不会丢失。
    
    # 事务开启语句
    START TRANSACTION ;
    
    # 事务处理语句就是 DML 语句 INSERT、UPDATE、DELETE
    
    # 显示结束事务  COMMIT; 提交、 ROLLBACK; 回滚操作
    # 隐式结束事务  DDL 语句 DROP、CREATE、ALTER 可以显示结束。
    
    # 事务设置保留点(还原点)
    SAVEPOINT  save_point_name;
    # 回滚到保留点，前提是不能结束当前事务。事务一旦结束，就会自动提交 COMMIT
    ROLLBACK TO save_point_name;
    
    # 设置事务自动提交 1 与关闭 0
    SET AOTOCOMMIT = 1; -- 开启
    SET AOTOCOMMIT = 0; -- 关闭
    
    # 注意:
    # 如果期间出现 DML语句，即 DROP、CREATE、ALTER关键词，则会隐式提交事务！
    ```

    

## 数据去重

1.  **Distinct** 官方解释：`排除重复的行`

2.  位置：

    2.1 单独的 `Distinct` 只能放在开头，后边的字段都会并入去重条件。

    ```mysql
    # Distinct 后边的字段都会并入去重条件，当两个字段值同时重复时，只显示一条数据
    SELECT DISTINCT price, pname
    FROM product;
    ```

    2.2 配合 `count()` 函数位置不必放在最前，但是要配合 `Group By` 函数使用，并且后边的字段要和 `Distinct` 一致。

    ```mysql
    # 查询所有字段，其中 pname、price 去重。如果 group by 后边只有 pname 字段，则事实上只对 name 去重，只有 distinct 和 group by  后边字段保持一直，结果才会正确
    SELECT *, count(DISTINCT pname, price)
    FROM product
    GROUP BY pname,price;
    ```

3.  **Group By** 官方解释：`对查询结果进行分组`

    ```mysql
    # Distinct 后边的字段都会并入去重条件，当两个字段值同时重复时，只显示一条数据
    SELECT DISTINCT price, pname
    FROM product ORDER BY pid;
    
    # Group By 后边的字段都会并入去重条件，当两个字段值同时重复时，只显示一条数据
    # 结果同上
    SELECT pname, price
    FROM product
    GROUP BY product.pname, product.price ORDER BY pid;
    ```

4.  **区别：**

    1.  单纯去重，`Distinct` 效率要快于 `Group By`，因为 `Distinct` 是查询时根据行直接去重，`Group By` 是根据结果分组。
    2.  `Distinct` 定义就是去重，`Group By` 定义主要用来聚合统计。

    

    

