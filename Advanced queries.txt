-- Q1. Select all columns and all rows from one table
Select * from Customer; 

-- Q2. Select five columns and all rows from one table
SELECT SHIPPING_ID, SHIPPING_DATE, TRACKING_NUMBER, SHIPPING_COST, SHIPPING_TYPE
FROM SHIPPING;

---Q3.Select all columns from all rows from one view
-- create a view called or_summary
CREATE VIEW or_summary AS
-- select columns from purchase_order and customer tables and join them on customer_id
SELECT po.ORDER_ID, po.ORDER_STATUS, po.TOTAL_PRICE, po.ORDER_DATE, po.DELIVERY_DATE, c.FIRST_NAME, c.LAST_NAME, c.EMAIL, c.PHONE_NUMBER, c.ADDRESS, c.CITY, c.STATE, c.ZIPCODE
FROM PURCHASE_ORDER po
JOIN CUSTOMER c ON po.CUSTOMER_ID = c.CUSTOMER_ID;

-- select all columns and rows from the or_summary view
SELECT * FROM or_summary;

-- Q4. Using a join on 2 tables, select all columns and all rows

Select * from CUSTOMER C
FULL OUTER JOIN PURCHASE_ORDER P
ON c.customer_Id = p.customer_Id;


-- Q5. Select and order data retrieved from one table
Select * FROM PURCHASE_ORDER
ORDER BY TOTAL_PRICE;

-- Q6. Using a join on 3 tables, select 5 columns from the 3 tables.Use syntax that would limit the output to 10 rows 
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    po.order_id,    
    p.name AS productname
FROM
         customer c
    JOIN purchase_order po ON c.customer_id = po.customer_id
    JOIN product        p ON po.order_id = p.order_id
FETCH FIRST 10 ROWS ONLY

-- Q7: Select distinct rows using joins on 3 tables (5 points)

Select distinct (c.customer_id) from PURCHASE_ORDER p
inner join customer c 
on p.customer_id = c.customer_Id
inner join product pd
    on pd.order_id = p.order_id;

-- Q8: Use GROUP BY and HAVING in a select statement using one or more tables

SELECT c.first_name, c.last_name, COUNT(o.order_id) AS num_orders
FROM customer c
JOIN purchase_order o ON c.customer_id = o.customer_id 
GROUP BY c.first_name, c.last_name
HAVING COUNT(o.order_id) >= 1;

--- This query will return the first name, last name, and number of orders for customers who have made one or more orders.

-- Q9. Use IN clause to select data from one or more tables
Select * from PRODUCT
Where DESCRIPTION IN ('Multipurpose','All-In-One');
---This query selects all rows from the PRODUCT table where the DESCRIPTION column contains either "Multipurpose" or "All-In-One".

-- Q10. Select length of one column from one table (use LENGTH function)

SELECT LENGTH(Email) As Email_ID_length FROM Customer;

-- Q11. Delete one record from one table. Use select statements to demonstrate the table contents before and after the DELETE statement.  
--Make sure you use ROLLBACK afterwards so that the data will not be physically removed

-- Show the table contents before the DELETE statement
SELECT * FROM PAYMENT;
-- Perform the DELETE statement
DELETE FROM PAYMENT 
WHERE PAYMENT_ID = 107;
-- Show the table contents after the DELETE statement
SELECT * FROM PAYMENT;
-- Rollback the changes to restore the deleted record
ROLLBACK;

-- Q12.Update one record from one table. Use select statements to demonstrate the table contents before and after the UPDATE
--statement. Make sure you use ROLLBACK afterwards so that the data will not be physically removed

-- Showing the PURCHASE_ORDER table contents before the update
SELECT * FROM PURCHASE_ORDER;

-- Updating the order status for order with ID = 1001
UPDATE PURCHASE_ORDER SET ORDER_STATUS = 'Shipped' WHERE ORDER_ID = 1001;

-- Show the PURCHASE_ORDER table contents after the update
SELECT * FROM PURCHASE_ORDER;

-- Rollback the changes so that the data will not be physically removed
ROLLBACK;

---13) find all customers who made a payment with a credit card:

SELECT DISTINCT c.First_name, c.Last_name
FROM Customer c
JOIN Purchase_Order po ON c.Customer_id = po.CUSTOMER_ID
JOIN Payment p ON p.ORDER_ID = po.ORDER_ID
WHERE p.PAYMENT_METHOD = 'Credit Card';


---14) select all products whose price is higher than the average price of all products in the Product table:
SELECT * FROM Product
WHERE PRICE > (
  SELECT AVG(PRICE)
  FROM Product
);

---15)retrieve all customers who made a purchase within the last month, along with their contact and address information.

SELECT c.Customer_id, c.First_name, c.Last_name, c.EMAIL, c.PHONE_NUMBER, c.ADDRESS, c.CITY, c.STATE, c.ZIPCODE
FROM Customer c
JOIN PURCHASE_ORDER po ON po.CUSTOMER_ID = c.Customer_id
WHERE po.ORDER_DATE BETWEEN ADD_MONTHS(SYSDATE, -1) AND SYSDATE
GROUP BY c.Customer_id, c.First_name, c.Last_name, c.EMAIL, c.PHONE_NUMBER, c.ADDRESS, c.CITY, c.STATE, c.ZIPCODE;

---16)Get the details of all the orders that were shipped via "Express ":

SELECT *
FROM PURCHASE_ORDER
JOIN SHIPPING ON SHIPPING.ORDER_ID = PURCHASE_ORDER.ORDER_ID
WHERE SHIPPING.SHIPPING_TYPE = 'Express';

---17)retrieve the top 3 products by total revenue generated.


SELECT pr.PRODUCT_ID, pr.NAME, 
       (SELECT SUM(p.PAYMENT_AMOUNT)
        FROM PURCHASE_ORDER po
        JOIN Payment p ON p.ORDER_ID = po.ORDER_ID
        WHERE pr.ORDER_ID = po.ORDER_ID) AS total_revenue
FROM Product pr
ORDER BY total_revenue DESC
FETCH FIRST 3 ROWS ONLY;
----This subquery calculates the sum of payment amounts for each product by joining to the Payment table in a nested query within the main query.
----The ORDER BY and FETCH FIRST clauses are used to return the top 3 products by revenue.

---18) What is the total revenue generated by each category of products in the last quarter?

SELECT p.CATEGORY, 
       SUM(pm.PAYMENT_AMOUNT) AS total_revenue -- Calculates the total revenue for each product category
FROM PURCHASE_ORDER po -- Joins the purchase_order table
JOIN Payment pm ON pm.ORDER_ID = po.ORDER_ID -- Joins the payment table using order_id as the common column
JOIN Product p ON p.ORDER_ID = po.ORDER_ID -- Joins the product table using order_id as the common column
WHERE po.ORDER_DATE BETWEEN ADD_MONTHS(SYSDATE, -3) AND SYSDATE -- Filters orders in the last quarter using SYSDATE (current date)
GROUP BY p.CATEGORY -- Groups the results by product category
ORDER BY total_revenue DESC; -- Orders the results by total revenue in descending order



---19)Retrieve the total revenue generated by each city in the last month

SELECT c.CITY, SUM(pm.PAYMENT_AMOUNT) AS total_revenue
FROM Customer c
JOIN Purchase_Order po ON po.CUSTOMER_ID = c.CUSTOMER_ID
JOIN Payment pm ON pm.ORDER_ID = po.ORDER_ID
WHERE po.ORDER_DATE BETWEEN ADD_MONTHS(SYSDATE, -1) AND SYSDATE
GROUP BY c.CITY
ORDER BY total_revenue DESC;
---This query retrieves the total revenue generated from each city in the past month. 
---It does this by joining the Customer, Purchase_Order, and Payment tables and filtering the results to only include orders from the past month using the BETWEEN clause and ADD_MONTHS function. 
---Finally, the results are grouped by city and sorted in descending order by total revenue.


---20) provide a list of shipping types and their total shipping costs for the last month, 
----and only show those shipping types that have a total shipping cost greater than the average total shipping cost for all shipping types during the same period,
----sorted in descending order by total shipping cost?"

-- This query selects the shipping type and the total shipping cost for each type
SELECT s.SHIPPING_TYPE, SUM(s.SHIPPING_COST) AS total_shipping_cost
-- This query filters only the shipping records that occurred in the last month
FROM SHIPPING s
WHERE s.SHIPPING_DATE BETWEEN ADD_MONTHS(SYSDATE, -1) AND SYSDATE
-- This query groups the shipping records by shipping type
GROUP BY s.SHIPPING_TYPE
-- This query filters only the shipping types that have a total shipping cost greater than the average of all shipping types in the last month
HAVING SUM(s.SHIPPING_COST) > (SELECT AVG(total_shipping_cost) FROM (
    SELECT SUM(sh.SHIPPING_COST) AS total_shipping_cost
    FROM SHIPPING sh
    WHERE sh.SHIPPING_DATE BETWEEN ADD_MONTHS(SYSDATE, -1) AND SYSDATE
    GROUP BY sh.SHIPPING_TYPE))
-- This query orders the shipping types by total shipping cost in descending order
ORDER BY total_shipping_cost DESC;

