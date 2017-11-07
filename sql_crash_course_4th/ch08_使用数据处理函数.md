# 数据处理函数

## 函数带来的问题

每一个DBMS都有特定的函数，SQL函数不是可移植的

| 函数                 | 语法                                                                                                                                                       |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 提取字符串的组成部分 | Access使用MID()；<br>DB2、Oracle、PostgreSQL和SQLite使用SUBSTR()；<br>MySQL和SQL Server使用SUBSTRING()                                                         |
| 数据类型转换         | Access和Oracle使用多个函数，每种类型的转换有一个函数；<br>DB2和PostgreSQL使用CAST()；<br>MariaDB、MySQL和SQL Server使用CONVERT()                               |
| 取当前日期           | Access使用NOW()；<br>DB2和PostgreSQL使用CURRENT_DATE；<br>MariaDB和MySQL使用CURDATE()；<br>Oracle使用SYSDATE；<br>SQL Server使用GETDATE()；<br>SQLite使用DATE() |

## 使用函数

大多数SQL 实现支持以下类型的函数
- 用于处理文本串（如删除或填充值，转换值为大写或小写）的文本函数
- 用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）的数值函数
- 用于处理日期和时间值并从这些值中提取特定成分（例如返回两个日期之差，检查日期有效性等）的日期和时间函数
- 返回DBMS 正使用的特殊信息（如返回用户登录信息）的系统函数


### 常用的文本处理函数

| 函　　数                                | 说　　明                |
|---------------------------------------|-----------------------|
| LEFT()（或使用子字符串函数）            | 返回字符串左边的字符  |
| LENGTH()（ 也使用DATALENGTH()或LEN() ） | 返回字符串的长度      |
| LOWER()（ Access使用LCASE() ）          | 将字符串转换为小写    |
| LTRIM()                               | 去掉字符串左边的空格  |
| RIGHT()（或使用子字符串函数）           | 返回字符串右边的字符  |
| RTRIM()                               | 去掉字符串右边的空格  |
| SOUNDEX()                             | 返回字符串的SOUNDEX值 |
| UPPER() ( Access使用UCASE() )         | 将字符串转换为大写    |


>SOUNDEX 考虑了类似的发音字符和音节，使得能对串进行发音比较而不是字母比较


> Microsoft Access和PostgreSQL不支持SOUNDEX()

```sql
SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');
```

### 日期处理函数

日期和时间采用相应的数据类型存储在表中，每种DBMS都有自己的特殊形式。日期和时间值以特殊的格式存储，以便能快速和有效地排序或过滤，并且节省物理存储空间。

例如,从orders表中检索2012年的所有订单

SQLServer

```sql
SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2012;
```

Access:

```sql
SELECT order_num
FROM Orders
WHERE DATEPART('yyyy', order_date) = 2012;
```

PostgreSQL:

```sql
SELECT order_num
FROM Orders
WHERE DATE_PART('year', order_date) = 2012;
```

Oracle没有DATEPART()函数，不过有几个可用来完成相同检索的日期处理函数:

- to_char()函数用来提取日期的成分，to_number()用来将提取出的成分转换为数值

    ```sql
    SELECT order_num
    FROM Orders
    WHERE to_number(to_char(order_date, 'YYYY')) = 2012
    ```
- 使用BETWEEN操作符：

    ```sql
    SELECT order_num
    FROM Orders
    WHERE order_date BETWEEN to_date('01-01-2012')
    AND to_date('12-31-2012');
    ```

MySQL和MariaDB可使用名为YEAR()的函数从日期中提取年份：

```sql
SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2012;
```

SQLite：

```sql
SELECT order_num
FROM Orders
WHERE strftime('%Y', order_date) = 2012;
```

### 常用的数值处理函数

| 函　　数 | 说　　明             |
|--------|--------------------|
| ABS()  | 返回一个数的绝对值 |
| COS()  | 返回一个角度的余弦 |
| EXP()  | 返回一个数的指数值 |
| PI()   | 返回圆周率         |
| SIN()  | 返回一个角度的正弦 |
| SQRT() | 返回一个数的平方根 |
| TAN()  | 返回一个角度的正切 |

主要DBMS的函数中，数值函数是最一致、最统一的函数