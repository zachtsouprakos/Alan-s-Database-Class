-- #1 Selected the customers name and city from the same city that produced the most products
SELECT DISTINCT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city
                FROM products
                GROUP BY city
                ORDER BY COUNT(pid) DESC 
                LIMIT 1
                )
 ;

 -- #2 This statement selects the name of the product that has a greater 'priceUSD' than the avg of priceUSD
SELECT name 
FROM products p
WHERE p.priceUSD > (SELECt AVG(priceUSD) AS avgpriceUSD
                     FROM products
                    )
ORDER BY NAME DESC ;

-- #3 Displays the customers name, the product ID(pid), and the total USD orders by totalUSD from high to low
SELECT c.name, o.pid, o.totalUSD
FROM customers c INNER JOIN orders o ON c.cid = o.cid
order by totalUSD DESC ;

--#4 This statement does not use coalesce but returns users name and totalUSD
SELECT DISTINCT c.name, o.totalUSD
FROM customers c INNER JOIN orders o ON c.cid = o.cid
ORDER BY name ;

--#5 This statement selects the customers name, product name, and agents, where the customer placed an order 
-- through an agent from Tokyo and the product is for that specific order
SELECT c.name, p.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
              INNER JOIN products p ON o.pid = p.pid
              INNER JOIN agents a ON o.aid = a.aid
WHERE a.city = 'Tokyo' ;

--#6Created a view of the correct prices. Then compared this view to the unchecked prices using a subquery with an except
-- statement. Alex Millet and I collaborated to come to this conclusion... it is pretty awesome.
CREATE OR replace view PRICECHECK
AS
SELECT ((p.priceusd*o.qty)-(((c.discount/100)*p.priceusd)*o.qty)) AS priceCHECK, o.ordnum
FROM orders o INNER join customers c ON o.cid = c.cid
              INNER join products p ON o.pid = p.pid

SELECT ordnum, priceCHECK
FROM PRICECHECK
WHERE priceCHECK IN (SELECT priceCHECK
                  FROM PRICECHECK 
                  EXCEPT
                  SELECT totalusd
                  FROM orders
                 ) ;



