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
