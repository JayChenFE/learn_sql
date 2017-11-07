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

> 实际生产环境中一般不使用外键,表之间有逻辑外键但是没有物理外键

## 索引

## 触发器

