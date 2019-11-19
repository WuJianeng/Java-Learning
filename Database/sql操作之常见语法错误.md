## SQL常见语法错误之更正

错误案例

```sql
SELECT maker
FROM(	SELECT maker, COUNT(maker) AS num
    	FROM ((SELECT maker, Porduct.model AS model, speed
            	FROM Product, PC
            	WHERE Product.model = PC.model AND speed > 3.0)
                	UNION
            	(SELECT maker,Product.model AS model, speed
            	FROM Product, Laptop
            	WHERE Product.model = Laptop.model AND speed > 3.0))
    	GROUP BY maker)
WHERE num >= 2;
```



#### 1	关系/属性名称写错

```sql
SELECT maker, Porduct.model AS model, speed ==> SELECT maker, Product.model AS model
```

#### 2	`FROM`中子查询结果需起别名

```sql
FROM (	(SELECT maker, Porduct.model AS model, speed
		FROM Product, PC
		WHERE Product.model = PC.model AND speed > 3.0)
		UNION
		(SELECT maker,Product.model AS model, speed
		FROM Product, Laptop
		WHERE Product.model = Laptop.model AND speed > 3.0)
     )AS R #from后面括起来之后直接命名
```

