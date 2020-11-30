# 如何编写SQL，第1部分:命名约定

[原文链接](https://launchbylunch.com/posts/2014/Feb/16/sql-naming-conventions/)

> "There are only two hard problems in Computer Science: cache invalidation and naming things."  
> — Phil Karlton


## 1. 背景

在本文中，我将讨论后者。具体来说是数据库对象的命名约定，它们为什么如此重要，以及你应该和不应该做什么。

## 2. 目标数据库
我的公司[JackDB](https://www.jackdb.com/)内部使用PostgreSQL存储持久化状态，本文中的命名约定是针对PostgreSQL写的,但是对于其他关系数据库(如MySQL、Oracle或Microsoft SQL Server)，大多数建议应该同样有效的。

其中的一部分也能应用到NoSQL数据库中，虽然不是一切。例如下面在MongoDB中使用全英文单词来代替[推荐方式](http://docs.mongodb.org/manual/faq/developers/#how-do-i-optimize-storage-use-for-small-documents)的建议。 当你有疑问时，可以查找特定类型数据库的指南。

## 3. 为什么命名约定是重要的

### 3.1 名称是永久存在的

数据结构要比应用程序代码持久的多。任何在一个长期运行的系统上工作过的人都可以证明这一点。

好的数据结构和表结构比任何应用程序代码"活"的时间都长。一个应用程序完全重写而不用修改数据库的情况并不少见。

### 3.2 名称是合约

数据库对象通过它们的名称引用，因此对象名称是合约的一部分。在某种程度上，您可以将数据库表和列名视为数据模型的API。

一旦它们被设置，更改它们可能会中断依赖的应用程序。这就是为什么在第一次使用时需要正确命名数据库对象的原因。

### 3.3 开发者上下文切换

数据模型具有一致的命名约定意味着开发人员将需要花费更少的时间查找表、视图和列的名称。当你知道`person_id`必须是`person`表的`id字段的外键`时，编写和调试SQL就变的非常容易了。

## 4. 命名约定

### 4.1 避免引用

如果必须引用标识符，那么你就应该重新命名它了。引用标识符是非常痛苦的。手写带有引用标识符的SQL是令人沮丧的， 手写带有引用标识符的动态SQL是更令人沮丧的。

这也意味着你不应该在标识符名称中包括空格。

例：你应该避免使用`"FirstName"`或者` "All Employees"`这样的名称。

### 4.2 使用小写字母

标识符应该全部使用小写字母。包括表名称，视图名称，列名和数据库其他的所有名称。混合大小写标识符名称意味着标识符的每次使用都需要用双引号引用(我们已经说过不允许使用双引号了)。

例： 使用`first_name` 而不是`"First_Name"`

### 4.3 数据类型不是名称

数据库对象名称，特别是列名，它应该是描述字段或对象的名词。应该避免使用像`text` 或者 `timestamp`这种表示数据类型的单词。后者尤其糟糕，因为它提供了零上下文。

### 4.4 使用下划线分割单词

如果对象名称由多个单词构成则应该使用下划线分割(ie.[snake_case](https://en.wikipedia.org/wiki/Snake_case))

例子：应该使用`word_count` 或 `team_member_id`, 而不是`wordcount`或`wordCount`。

### 4.5 使用完整单词而不是缩写

对象名应该是完整的英语单词。通常要避免使用缩写，尤其是如果它们只是删除元音的类型。大多数SQL数据库都支持至少30个字符的名称，这对于几个英语单词来说已经足够了。PostgreSQL支持最多63个字符的标识符。

例:  使用`middle_name` 而非 `middle_nm`。

### 4.6 使用常见的缩写

对于一些长单词，缩写比单词本身更常见。["Internationalization" and "localization"](https://en.wikipedia.org/wiki/I18n) 是最常出现的两个单词，分别是**i18n**和**l10n**，这种情况下应使用缩写。

如果你有疑问，可以用完整的英语单词试试， 然后你就会发现缩写形式的优势是显而易见的。

### 4.7 避免使用保留字

你应该避免使用数据库的任何保留字。它们并不太多，所以不用花什么努力去选一个不同的单词。根据上下文环境，保留字可能需要引用（**quoting**），这意味着有时你会写**“user”**，有时只写**user**。

避免保留词的另一个好处是，不太智能的编辑器语法高亮不会错误地高亮它们。

例子： 避免使用像`user`, `lock` 或 `table`这样的单词。

**这是[PostgreSQL](http://www.postgresql.org/docs/9.3/static/sql-keywords-appendix.html)、[MySQL](http://dev.mysql.com/doc/refman/5.7/en/reserved-words.html)、[Oracle](http://docs.oracle.com/cd/E16655_01/server.121/e17209/ap_keywd.htm#SQLRF022) 和 [MSSQ](http://technet.microsoft.com/en-us/library/ms189822.aspx) 数据库的保留词列表**。

## 5. 奇异关系

**保存数据的表，视图和其他关系应该具有单数名称，而不是复数。**

这意味着我们的表和视图应该被命名为`team` 而不是`teams`。

我将给出一些实际的原因，而不是用[**关系代数**](https://en.wikipedia.org/wiki/Relational_algebra)来解释为什么这是正确的。

**他们是一致的**：一个表里只有一条数据那是可能的，那它还是复数吗？

**他们是明确的**：只使用单数名称就意味着你不需要决定如何复数化名词

*Ex: Does a "Person" object go into a "Persons" relation or a "People" one? How about an "[Octopus](https://en.wikipedia.org/wiki/Octopus#Etymology_and_pluralization)" object? Octopuses? Octopi? Octopodes?*

**Straightforward 4GL Translation**： 单数名称允许您直接将4GL对象转换为数据库关系。您可能需要删除一些下划线，并切换到驼峰大小写，但名称转换始终是直接的。

例：team_member 可以明确的转换成Java中的TearmMember类或Python中的team_member变量。

## 6. 关键字段

### 6.1 主键

**单列主键字段名称应该命名为id**。它应该是简单明了的。这意味着在编写SQL时，不需要记住要关联的字段的名称。

```sql
CREATE TABLE person (
  id bigint PRIMARY KEY,
  full_name text NOT NULL,
  birth_date date NOT NULL
);
```

一些指南建议将表名放在主键字段名的前面。对比**person_id**和**id**，额外的前缀是多余的。在比较复杂SQL语句中的所有字段名(多表联合)都应该显式的指定。将前缀作为命名空间是一个糟糕的想法。

### 6.2 外键

**外键字段的名称应该是被引用表名和字段名称的组合**。对于单个列外键名称(到目前为止最常见的情况)，类似于`foo_id`。

```sql
CREATE TABLE team_member (
  team_id bigint NOT NULL REFERENCES team(id),
  person_id bigint NOT NULL REFERENCES person(id),
  CONSTRAINT team_member_pkey PRIMARY KEY (team_id, person_id)
);
```

## 7. 前缀后缀

### 7.1 关系类型前缀

一些老的教程建议我们命名表时添加**TB_**前缀，视图添加**VW_**前缀，存储过程添加**SP_**前缀。这样做是为了让编程者在阅读一些未知的SQL时能够通过名称立即判断出对象的类型，但这是一个糟糕的想法。

对象的名称不应该包括对象类型在内。这样以后就可以修改它了。用表替换的视图来维护视图的原始数据(例如:您可以从中查询)。在这样的更改之后，依赖的系统可以不用修改。

我曾经见过很多这样的系统，在某种程度上，会将视图当成一个表来用。然后当你向视图插入数据时，就可能得到一些意想不到的问题。PostgreSQL甚至还有一个非常强大的特性，允许您在视图上定义DML规则（例如：你可以插入/更新/删除它们)。

添加对象类型前缀增加了额外的混乱。

### 7.2 应用程序名称前缀

其他的一些老的建议就是给数据库对象添加统一的前缀。例如， 我们的APP叫“FooBar”, 然后就可能会有这种表`Foobar_Users`, `Foobar_Teams` 等等。同样，这也是一个糟糕的想法。

所有现代数据库都支持某种形式的命名空间。例如，在PostgreSQL中你能通过创建模式来对数据库对象进行分组。如果多个应用程序共享同一个数据库，并且希望防止它们互相攻击，那么可以使用模式。这正是他们的作用!

但大多数人甚至不需要它们。将数据库与单个逻辑数据模型一起使用要比使用多个单独的数据模型常见得多。因此不需要模式。如果你确实需要它们，这应该是相当明显的。

这个规则的例外是，如果您正在开发数据库无关的代码库，比如框架或插件。支持多个名称空间方法非常复杂，因此许多框架都依赖于应用程序名称前缀。

然而，大多数人开发的是应用程序，而不是插件或框架，他们的应用程序将单独驻留在单一类型的数据库中。因此，没有理由向所有数据库对象添加应用程序名称前缀

### 7.3 数据类型后缀

一些指南，通常是比较老的，建议你在列名后面添加数据类型后缀。例如，text类型的name列名为name_tx。甚至会有大量的列表将数据类型转换为后缀、text-> tx、date-> dt等。

这是个不好的想法!

字段数据类型可以更改。date可以成为timestamp，int可以成为bigint或numberic。

## 8. 显式命名

一些创建数据库对象的命令不需要你指定一个名称。一个对象的名称要不是随机生成（ex:fk239nxvknvsdvi）就是通过公式生成的（ex: foobar_ix_1）。除非你明确地知道如何生成一个名称，并且您对它很满意，否则您应该显式地指定名称。

这还包括[ORMs](https://en.wikipedia.org/wiki/Object-relational_mapping)生成的名称。许多ORM默认创建索引和约束，并生成冗长的名称。在短期内节省的几分钟时间，不值得你痛苦地回忆`fkas9dfnksdfnks`在长期内指的是什么。

### 8.1 索引

索引应该显式地命名，并包括表名和需要增加索引的列名(s)。增加列名可以让我们更容易的阅读SQL执行计划。如果一个索引被命名为`foobar_ix1`,那么你需要查找该索引覆盖的列，以了解它是否被正确使用。

```sql
CREATE TABLE person (
  id          bigserial PRIMARY KEY,
  email       text NOT NULL,
  first_name  text NOT NULL,
  last_name   text NOT NULL,
  CONSTRAINT person_ck_email_lower_case CHECK (email = LOWER(email))
);

CREATE INDEX person_ix_first_name_last_name ON person (first_name, last_name);
```

这样使得SQL执行计划非常易懂。我们能够清晰的看到`person_ix_first_name_last_name`索引被使用：

```sql
=# EXPLAIN SELECT * FROM person WHERE first_name = 'alice' AND last_name = 'smith';

                                          QUERY PLAN                                          
----------------------------------------------------------------------------------------------
 Index Scan using person_ix_first_name_last_name on person  (cost=0.15..8.17 rows=1 width=72)
   Index Cond: ((first_name = 'alice'::text) AND (last_name = 'smith'::text))
(2 rows)
```

### 8.2 约束

与索引类似，约束应该提供描述性名称。对于检查约束尤其如此。这让诊断错误变的容易得多，因为检查约束名称会告诉你原因。

```sql
CREATE TABLE team (
  id          bigserial PRIMARY KEY,
  name        text NOT NULL
);

CREATE TABLE team_member (
  team_id     bigint REFERENCES team(id),
  person_id   bigint REFERENCES person(id),
  CONSTRAINT team_member_pkey PRIMARY KEY (team_id, person_id)
);
```

注意，PostgreSQL在为外键约束提供描述性名称方面做得很好。

```sql
=# \d team_member
   Table "public.team_member"
  Column   |  Type  | Modifiers 
-----------+--------+-----------
 team_id   | bigint | not null
 person_id | bigint | not null
Indexes:
    "team_member_pkey" PRIMARY KEY, btree (team_id, person_id)
Foreign-key constraints:
    "team_member_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id)
    "team_member_team_id_fkey" FOREIGN KEY (team_id) REFERENCES team(id)
```

如果我们尝试插入一个违反这些约束之一的数据，通过约束的名称我们就能知道失败的原因：

```sql
=> INSERT INTO team_member(team_id, person_id) VALUES (1234, 5678);
ERROR:  insert or update on table "team_member" violates foreign key constraint "team_member_team_id_fkey"
DETAIL:  Key (team_id)=(1234) is not present in table "team".
```

类似地，如果我们尝试在上面创建的person表中插入不是小写的电子邮件地址，我们会得到一个违反约束的错误，它会告诉我们到底什么出错了:

```sql
-- This insert will work:
=> INSERT INTO person (email, first_name, last_name) VALUES ('alice@example.com', 'Alice', 'Anderson');
INSERT 0 1

-- This insert will not work:
=> INSERT INTO person (email, first_name, last_name) VALUES ('bob@EXAMPLE.com', 'Bob', 'Barker');
ERROR:  new row for relation "person" violates check constraint "person_ck_email_lower_case"
DETAIL:  Failing row contains (2, bob@EXAMPLE.com, Bob, Barker).
```

## 9. 写在最后

如果你正在开始一个新的项目，那么我建议你遵循这里列出的约定。如果你是在现有项目中工作，那么你需要更加小心地处理您创建的任何新对象。

惟一比糟糕的命名约定更糟糕的是多重命名约定。如果您现有的项目已经有了命名其数据库对象的标准方法，那么请继续使用它。

你有什么要补充的吗? 有什么方法可以改进其中的一些指导方针，或者只是觉得其中的一些观点很糟糕? [让我知道](sehrope@jackdb.com)!


