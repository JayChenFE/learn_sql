## 分类

- 简单CASE 表达式（simple case expression）

  ```sql
  -- 简单CASE 表达式
  CASE sex
  WHEN '1' THEN '男'
  WHEN '2' THEN '女'
  ELSE '其他' END
  ```

- 搜索CASE 表达式（searched case expression）

  ```sql
  -- 搜索CASE 表达式
  CASE WHEN sex = '1' THEN '男'
  WHEN sex = '2' THEN '女'
  ELSE '其他' END
  ```

  ​

简单CASE 写法简单，但能实现的事情比较有限。简单CASE 表达式能写的条件，搜索CASE 表达式也能写，所以基本上采用搜索CASE 表达式的写法。

注意:

1. 统一各分支返回的数据类型

2. 不要忘了写END

3. 养成写ELSE 子句的习惯

   最好明确地写上ELSE 子句（即便是在结果可以为NULL 的情况下）这样从代码上就可以清楚地看到这种条件下会生成NULL，而且将来代码有修改时也能减少失误。



## 示例

**新手用WHERE 子句进行条件分支，高手用SELECT 子句进行条件分支。**