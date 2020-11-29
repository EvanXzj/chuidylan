# SQL结构化查询语言学习

SQL(Structured Query Language) 是结构化查询语言的简称，它最重要的是数据库的操作语言。 对于学习数据库而言，学习SQL的使用是相当的重要!

## 语句的分类

1. `DQL`: Data Query Language, 数据查询语句，用于数据的查询
2. `DML`: Data Manipulation Language, 数据库操作语言， 主要用于数据的插入、更新、删除等。
3. `DDL`: Data Definition Language, 即数据定义语言，主要用于表的创建、删除、修改等

## DDL语句

#### 建表语句

```sql
CREATE TABLE student ( -- student 
    id INT SERIAL PRIMARY KEY, -- PRIMARY KEY 代表表的主键，是行的唯一标识，不能重复。
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone varchar(32)
    age INT
);
```

#### 删除表

```sql
DROP TABLE table_name;
```

#### 创建索引

```sql
CREATE INDEX idx_student_phone ON student USING gin(phone);
```

## DDL语句

#### 插入数据

```sql
INSERT INTO student VALUES(1, 'Chui', 'Dylan', '131xxxxxxxx', 22);
INSERT INTO student VALUES(2, 'ming', 'xiao', '0123456789', 15);

-- or , 某些省略的字段会被置空
INSERT INTO student (first_name, last_name, phone, age) VALUES ('Chui', 'Dylan', '131xxxxxxxx', 22);
```

#### 更新数据

```sql
UPDATE student SET age = 21; -- 更新全部数据

-- 根据条件更新多列数据
UPDATE student SET age = 20, phone = '131zzzzzzzz' WHERE id = 1;
```

#### 删除数据

```sql
DELETE FROM student WHERE id = 2;

-- 删除全表数据
DELETE FROM student;

-- TRUNCATE 语句： 属于DDL, 相当于用重新定义的方法丢去原有的数据，
-- 而DETELE属于DML, 是一条一条数据的删除，所以truncate 执行会更快
TRUNCATE student;
```

## DQL语句

```sql
-- 单表查询
SELECT * FROM student; -- * 代表所有列

-- 查询指定列
SELECT id , first_name, last_name FROM student;

-- select expression
SELECT 2 + 3, id || first_name FROM student WHERE id = 2;

-- 过滤条件
SELECT id , first_name, last_name FROM student WHERE id = 2;

-- 排序
SELECT * FROM student ORDER BY id ASC; -- ASC 代表升序(默认排序方式)， DESC 代表降序

SELECT * FROM student WHERE first_name LIKE '%chui%' ORDER BY id ASC, age DESC; -- 先按id升序排序，再按age降序排序

-- 分组查询
SELECT age, COUNT(*) FROM student GROUP BY age; -- 使用GROUP BY时，需要使用聚合函数， 查询的字段需要写在GROUP BY 之后

-- JOIN
SELECT t1.uid, t1.user_name, t2.email, t2.auth_identifier FROM user_info t1, user_auth t2 WHERE t1.uid = t2.user_id; -- t1, t2 是表的别名

SELECT t1.*, t2.* FROM user_info t1 left join user_auth t2 on t1.uid = t2.user_id where t2.eamil like '%@biz.com';

-- insert into ... select from table_nme(需要先创建表),快捷备份表的一个方法
INSERT INTO student_bak SELECT * FROM student;

-- 联合
SELECT * FROM student WHERE id = 2 UNION SELECT * FROM student_bak WHERE id = 2;

-- UNION 会将两条相同的数据合并，如果不想合并，使用UNION ALL即可
SELECT * FROM student WHERE id = 2 UNION ALL SELECT * FROM student_bak WHERE id = 2;
```
