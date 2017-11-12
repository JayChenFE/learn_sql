# 高级SQL特性

## 约束

**引用完整性（referential integrity）:**

正确地进行关系数据库设计，需要一种方法保证只在表中插入合法数据。<br>例如，应该保证`OrderItems`中引用的任何订单Id都存在于`Orders`中。<br>类似地，在`Orders`表中引用的任意顾客必须存在于`Customers`表中。

### 主键

> 主键值不能重用。如果从表中删除某一行，其主键值不分配给新行。



例子: 给表的`vend_id`列定义添加关键字`PRIMARY KEY`，使其成为主键

```sql
CREATE TABLE Vendors
    (
      vend_id CHAR(10) NOT NULL
                       PRIMARY KEY ,
      vend_name CHAR(50) NOT NULL ,
      vend_address CHAR(50) NULL ,
      vend_city CHAR(50) NULL ,
      vend_state CHAR(5) NULL ,
      vend_zip CHAR(10) NULL ,
      vend_country CHAR(50) NULL
    );
```

`CONSTRAINT`语法可以达到相同的效果。此语法也可以用于`CREATE TABLE`和`ALTER TABLE`语句:

```sql
ALTER TABLE Vendors
ADD CONSTRAINT PRIMARY KEY (vend_id);
```

> SQLite不允许使用ALTER TABLE定义键，要求在初始的CREATE TABLE语句中定义它们。

**约束（constraint）**是管理如何插入或处理数据库数据的规则。

## 外键

表定义使用了`REFERENCES`关键字，它表示`cust_id`中的任何值都必须是`Customers`表的`cust_id`中的值。

```sql
CREATE TABLE Orders
    (
      order_num INTEGER NOT NULL
                        PRIMARY KEY ,
      order_date DATETIME NOT NULL ,
      cust_id CHAR(10) NOT NULL
                       REFERENCES Customers ( cust_id )
    );
```

相同的工作也可以在`ALTER TABLE`语句中用`CONSTRAINT`语法来完成：

```sql
ALTER TABLE Orders
ADD CONSTRAINT
FOREIGN KEY (cust_id) REFERENCES Customers (cust_id)
```

> <span style='color:red'>**实际生产环境中一般不使用外键,表之间有逻辑外键但是没有物理外键**</span>

### 唯一约束

唯一约束用来保证一列（或一组列）中的数据是唯一的

**唯一约束 VS 主键:**

- 表可包含多个唯一约束，但每个表只允许一个主键。
- 唯一约束列可包含NULL值。
- 唯一约束列可修改或更新。
- 唯一约束列的值可重复使用。
- 与主键不一样，唯一约束不能用来定义外键。

> 唯一约束既可以用`UNIQUE`关键字在表定义中定义，也可以用单独的`CONSTRAINT`定义。

### 检查约束

检查约束用来保证一列（或一组列）中的数据满足一组指定的条件:

- 检查最小或最大值。例如，防止0个物品的订单（即使0是合法的数）。
- 指定范围。例如，保证发货日期大于等于今天的日期，但不超过今天起一年后的日期。
- 只允许特定的值。例如，在性别字段中只允许M或F。

例1:对`OrderItems`表施加了检查约束，它保证所有物品的数量大于0：

```sql
CREATE TABLE OrderItems
    (
      order_num INTEGER NOT NULL ,
      order_item INTEGER NOT NULL ,
      prod_id CHAR(10) NOT NULL ,
      quantity INTEGER NOT NULL
                       CHECK ( quantity > 0 ) ,
      item_price MONEY NOT NULL
    );
```

例2: 检查名为gender的列只包含M或F

```sql
ADD CONSTRAINT CHECK (gender LIKE '[MF]')
```



### 索引

索引用来排序数据以加快搜索和排序操作的速度。

> 主键数据总是排序的

开始创建索引前，应该记住以下内容：

- 索引改善检索操作的性能，但降低了数据插入、修改和删除的性能。
- 索引数据可能要占用大量的存储空间。
- 并非所有数据都适合做索引。取值不多的数据（如州）不如具有更多可能值的数据（如姓或名），能通过索引得到那么多的好处。
- 索引用于数据过滤和数据排序。如果你经常以某种特定的顺序排序数据，则该数据可能适合做索引。
- 可以在索引中定义多个列（例如，州加上城市）。这样的索引仅在以州加城市的顺序排序时有用。如果想按城市排序，则这种索引没有用处。

#### 创建索引

在Products表的产品名列上创建一个简单的索引：

```sql
CREATE INDEX prod_name_ind
ON PRODUCTS (prod_name);
```

> 最好定期检查索引，并根据需要对索引进行调整。

## 触发器

触发器是特殊的存储过程，它在特定的数据库活动发生时自动执行。<br>触发器可以与特定表上的`INSERT`、`UPDATE`和`DELETE`操作（或组合）相关联。



与存储过程不一样（存储过程只是简单的存储SQL语句），触发器与单个的表相关联。与`Orders`表上的`INSERT`操作相关联的触发器只`在Orders`表中插入行时执行。



触发器的一些常见用途:

- 保证数据一致。例如，在`INSERT`或`UPDATE`操作中将所有州名转换为大写。
- 基于某个表的变动在其他表上执行活动。例如，每当更新或删除一行时将审计跟踪记录写入某个日志表。
- 进行额外的验证并根据需要回退数据。例如保证某个顾客的可用资金不超限定，如果已经超出，则阻塞插入。
- 计算计算列的值或更新时间戳。

例子:创建一个触发器，它对所有`INSERT`和`UPDAT`E操作，将`Customers`表中的`cust_state`列转换为大写

`SQL Server`版本:

```sql
CREATE TRIGGER customer_state ON Customers
    FOR INSERT, UPDATE
AS
    UPDATE  Customers
    SET     cust_state = UPPER(cust_state)
    WHERE   Customers.cust_id = inserted.cust_id;

```

`Oracle`和`PostgreSQL`的版本：

```sql
CREATE TRIGGER customer_state
AFTER INSERT OR UPDATE
FOR EACH ROW
BEGIN
UPDATE Customers
SET cust_state = Upper(cust_state)
WHERE Customers.cust_id = :OLD.cust_id
END;
```

> 一般来说，约束的处理比触发器快，因此在可能的时候，应该尽量使用约束。

