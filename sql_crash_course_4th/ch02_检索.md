# 检索不同的值

```sql

SELECT  DISTINCT vend_id
FROM    [dbo].[products];
```

> **警告：不能部分使用DISTINCT**<br>
DISTINCT关键字作用于所有的列，不仅仅是跟在其后的那一列。例如，你指定SELECT DISTINCT vend_id, prod_price，除非指定的两列完
全相同，否则所有的行都会被检索出来。