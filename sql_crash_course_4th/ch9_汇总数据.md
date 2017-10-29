# 汇总数据

## 聚集函数
我们经常需要汇总数据而不是实际检索出来。
常见的例子有：

1. 确定表的行数
1. 获取表中行组的和
1. 找出表列的最大，最小，平均值

**上述例子都需要对表中的数据汇总而不是实际数据本身。**

### **聚集函数（aggregate function）运行在行组上，计算和返回单个值的函数**

| 函　　数  | 说　　明           |
|---------|------------------|
| AVG()   | 返回某列的平均值 |
| COUNT() | 返回某列的行数   |
| MAX()   | 返回某列的最大值 |
| MIN()   | 返回某列的最小值 |
| SUM()   | 返回某列值之和   |

#### 1. AVG()函数

```sql
SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';
```

>AVG 忽略列值为NULL 的行

>AVG()只能用来确定特定数值列的平均值，而且列名必须作为函数参数给出。为了获得多个列的平均值，必须使用多个AVG()函数

#### 2.COUNT() 函数

**确定表中行的数目或符合特定条件的行的数目**

两种使用方式:

1. 使用COUNT（*）对表中行的数目进行计数，不管表列中包含的是空值还是非空值
1. 使用COUNT（column）对特定列中具有值的行进行计数，忽略NULL 值

只对具有电子邮件地址的客户计数：

```sql
SELECT COUNT(cust_email) AS num_cust
FROM Customers;
```

####  MAX()函数

MAX()返回指定列中的最大值。MAX()要求指定列名

Products表中最贵物品的价格:

```sql
SELECT MAX(prod_price) AS max_price
FROM Products;
```
>MAX 忽略列值为NULL 的行

>MAX()一般用来找出最大的数值或日期值，但许多（并非所有）DBMS允许将它用来返回任意列中的最大值。在用于文本数据时，MAX()返回按该列排序后的最后一行

####  MIN()函数
与MAX()相反

#### SUM()函数

原始数据如下:
```sql
SELECT *
FROM OrderItems
WHERE order_num = 20005;
```

```
order_num	order_item	prod_id	quantity	item_price
20005	1	ANV01     	10	                5.99
20005	2	ANV02     	3	                9.99
20005	3	TNT2      	5	                10.00
20005	4	FB        	1	                10.00
```

订单中所有物品数量之和:

```sql
SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;
```

```
items_ordered
19
```

总的订单金额:

```sql
SELECT SUM(item_price*quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005;
```

```
total_price
149.87
```

>SUM()函数忽略列值为NULL的行。

## 聚集不同值
以上5个聚集函数都可以如下使用：
- 对所有行执行计算，指定ALL参数或不指定参数（因为ALL是默认行为）。
- 只包含不同的值，指定DISTINCT参数。

>**ALL是默认值**

>Microsoft Access在聚集函数中不支持DISTINCT,Access得到类似的结果，需要使用子查询把DISTINCT数据返回到外部SELECT COUNT(*)语句

各个不同的价格的平均值
```sql 
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';
```

NOTICE：
 1. DISTINCT 只能用于指定列名的COUNT(column)，不能用于COUNT(*)
 1. DISTINCT 用于MAX MIN 无意义

##  组合聚集函数
Products表中物品的数目，产品价格的最高值、最低值以及平均值:

```sql
SELECT  COUNT(*) AS num_items ,
        MIN(prod_price) AS price_min ,
        MAX(prod_price) AS price_max ,
        AVG(prod_price) AS price_avg
FROM    Products;
```

## 小结

聚集函数用来汇总数据。SQL支持5个聚集函数。这些函数很高效，它们返回结果一般比你在自己的客户端应用程序中计算要快得多