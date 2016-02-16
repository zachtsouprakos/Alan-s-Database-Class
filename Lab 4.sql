-- Lab 4 --

-- #1 Selecting cities from agents who booked an order for customer c002
SELECT city 
FROM agents 
WHERE aid in (SELECT aid
	          FROM orders
	          WHERE cid = 'c002'
	         );
-- #2 Ordered pid from high to low where agents did not equal c002 or c003
SELECT pid 
FROM orders  
WHERE aid in (SELECT aid
              FROM orders 
              WHERE cid in (SELECT cid
                            FROM customers
                            WHERE city = 'Dallas'
                           )
              );
ORDER BY pid desc ;
-- #3 Selected the ids and names of customers who did not place an order throuygh agent a01
SELECT name, city
FROM customers
WHERE cid NOT in (SELECT cid
              FROM orders
              WHERE aid like 'a01'
             );
-- #4 Selected cid and names fo customers who ordered both product P01 AND p07
SELECT cid
FROM customers
WHERE cid in (SELECT cid
              FROM orders
	          WHERE pid in (SELECT pid
	                        FROM products
	                        WHERE pid in ('p01', 'p07')
	                       )   
	         );  
-- #5 Selected the pids of products ont ordered by any customers who have placed any order through agent a07
SELECT pid
FROM orders
WHERE cid NOT in (SELECT cid
                  FROM orders
                  WHERE aid like 'a07'
                 )
ORDER BY pid desc ;
-- #6 Selected name, city, and discount for all customers who placed orders with agents in London or New York
SELECT name, city, discount 
FROM customers
WHERE cid in (SELECT cid 
	      FROM orders
	      WHERE aid in (SELECT aid
	                    FROM agents
	                    WHERE city IN ('London', 'New York')
	                   )
	         );
-- #7 Selected all data from customers who have the same discount as custsomers in Dallas or London
SELECT * 
FROM customers
WHERE discount in (SELECT discount 
		           FROM customers
		           WHERE city in ('Dallas', 'London')
		          );

