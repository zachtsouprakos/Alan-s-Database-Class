#Selects ordnum and totalUSD from orders
Select ordnum, totalusd 
from orders ;

#Selects names and cities from agents where the name is equal to Smith
SELECT name, city, 
FROM agents
WHERE name = 'Smith' ;

#Selects Pid, name, and priceUSD from products where quantity is greater than 20800
SELECT pid, name, priceUSD
FROM products
WHERE quantity > 20800 ;

#Selects names and cities from customers where city is equal to Dallas
SELECT name, city 
FROM customers
WHERE city = 'Dallas' ;

#used '<>' to set city not equal to New York and Tokyo
SELECT name 
FROM agents 
WHERE city <> 'New York' AND city <> 'Tokyo' ;

#Used '>=' to set priceUSD to be greater than or equal to 1
SELECT *
FROM products
WHERE <> 'Dallas' AND city <> 'Duluth' AND priceUSD >= 1 ;

#Used like for jan and mar due to its data type
SELECT * 
FROM orders
WHERE mon like 'jan' OR mon like 'mar' ;

#Selects all data from orders where month is 'feb' and totalUSD is less than 500
SELECT * 
FROM orders
WHERE mon like 'feb' AND totalusd < 500 ;

#Selects all data from customers where cid is 'c005'
SELECT *
FROM customers
WHERE cid like 'c005' ;



