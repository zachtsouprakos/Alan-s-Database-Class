-- Zachary Tsouprakos, Lab 5

-- #1 This statement selects the city from the agent who places an order for customer c002
SELECT city
FROM orders o, agents a 
WHERE o.aid = a.aid
and o.cid = 'c002' ;

--#2 This statement selects the product ID from any agent where the customers city is Dallas
SELECT o.pid
FROM orders o, customers c
WHERE o.cid = c.cid
AND c.city = 'Dallas'
order by o.pid dESC ;

--#3 Selects the customer who did not place an order
SELECT DISTINCT c.name
FROM customers c, orders o
WHERE c.cid NOT IN (SELECT cid 
                    from orders  
                  ) 
;

--#4 Selects the customers name from orders where there is a CID in customers but not orders
SELECT c.name
FROM customers c FULL OUTER JOIN orders o ON c.cid = o.cid
WHERE o.cid is NULL ;

--#5 Selects the customers and agents name that are from the same city and placed at least one order with that agent
SELECT DISTINCT c.name, a.name
FROM orders o INNER JOIN agents a ON o.aid = a.aid
              INNER JOIN customers c ON o.cid = c.cid
WHERE a.city = c.city ;

--#6 This statement selects the name and city of agents who live in the same city
SELECT c.name, a.name, c.city, a.city
FROM customers c INNER JOIN agents a ON c.city = a.city ;


-- #7 This statement selects the customers name and city from the same city that makes the fewest products
-- #7 with subqueries that Jimmy helped me with explaining COUNT(pid)
SELECT DISTINCT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city
                FROM products
                GROUP BY city
                ORDER BY COUNT(pid) ASC 
                LIMIT 1
                )
 ;
 


 