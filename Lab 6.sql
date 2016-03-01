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

--#4 This statement uses coalesce to return a null value as 0 where customer 'Weyland' did not place an order
SELECT c.name, COALESCE(o.totalUSD,0)TOTALUSD
FROM customers c FULL OUTER JOIN orders o ON c.cid=o.cid
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
--#7 
/* 
LEFT OUTER JOIN compares two tables. In this outer join, the table that is on the left is compared
to the table on the right of the outer join statement, given what two columns are being compared.
EX: SELECT c.name, COALESCE(o.totalUSD,0)TOTALUSD
    FROM customers c LEFT OUTER JOIN orders o ON c.cid=o.cid
    ORDER BY name ;
In this example, the customers table would be compared to the orders table where the cid column have
equal values in both tables. Without the coalesce statement, a null will be returned in the orders 
column for every place there is not a matching cid in orders.

A RIGHT OUTER JOIN does the same thing, just opposite. This statement compares the right table to the 
left and returns a null for non-corresponding values.
EX: SELECT c.name, COALESCE(o.totalUSD,0)TOTALUSD
    FROM customers c RIGHT OUTER JOIN orders o ON c.cid=o.cid
    ORDER BY name ;
This example would compare orders to customers, where every time there is a non-corresponding value in 
customers a null will be placed in the specific place(given that there is not a COALESCE statement).
*/



