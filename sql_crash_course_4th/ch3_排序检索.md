# 排序检索

## 1. 排序数据

>**子句(clause)**<br>
SQL语句由子句构成，有些子句是必需的，有些则是可选的。一个子句通常由一个关键字加上所提供的数据组成。子句的例子有我们在前一课看到的SELECT语句的FROM子句。

```sql
SELECT prod_name
FROM Products
ORDER BY prod_name;
```

![](http://ww1.sinaimg.cn/large/006RLzNagy1fktpkhwtv5j30c705mmx9.jpg)

>**ORDER BY子句的位置**
在指定一条ORDER BY子句时，应该保证它是SELECT语句中最后一条子句。如果它不是最后的子句，将会出现错误消息。

## 2. 按多个列排序

## 3. 按列位置排序

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3;
```

等价于

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name;
```

## 4. 指定排序方向

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC;
```

### 多个列排序

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name;
```



DESC关键字只应用到直接位于其前面的列名。

在上例中，只对prod_price列指定DESC，对prod_name列不指定。因此，prod_price列以降序排
序，而prod_name列（在每个价格内）仍然按标准的升序排序。
警