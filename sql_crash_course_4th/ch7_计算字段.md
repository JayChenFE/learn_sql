# 计算字段

存储在表中的数据都不是应用程序所需要的。我们需要直接从数据库中检索出转换、计算或格式化过的数据，而不是检索出数据，然后再在客户端应用程序中重新格式化。
在数据库服务器上完成这些操作比在客户端中完成要快得多。

拼接(concatenate)

Acess，SQL Server 和Sybase 使用+号。DB2，Oracle，PostgreSQL 中使用||

RTRIM()函数去掉值右边的所有空格

以下sql是等价的

- Acess，SQL Server 和Sybase:

``` sql
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;
```

- DB2，Oracle，PostgreSQL:

```sql
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
AS vend_title
FROM Vendors
ORDER BY vend_name;
```

- MySQL和MariaDB:

```sql
SELECT Concat(vend_name, ' (', vend_country, ')')
AS vend_title
FROM Vendors
ORDER BY vend_name;
```

别名(一般最好使用)也称为导出列(derived column)

