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
WHERE p.priceUSD > (SELECt AVG(priceUSD) as avgpriceUSD
                     FROM products
                    )
ORDER BY NAME DESC ;

-- #3 Displays the customers name, the product ID(pid), and the total USD orders by totalUSD from high to low
SELECT c.name, o.pid, o.totalUSD
FROM customers c inner join orders o on c.cid = o.cid
order by totalUSD DESC ;

--#4 NOT DONE FIX THIS ONE!!!!!!!!!******
SELECT DISTINCT c.name, o.pid
FROM customers c inner join orders o ON c.cid = o.cid
ORDER BY name ASC ;