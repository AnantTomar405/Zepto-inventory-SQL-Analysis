drop table if exists zepto_inventory;

create table zepto_inventory (
Category VARCHAR(102),
name VARCHAR(250) NOT NULL,
mrp NUMERIC(10,2),
discount_Percent NUMERIC (5,2),
available_Quantity INTEGER,
discounted_Selling_Price NUMERIC(10,2),
weights_In_Gms INTEGER,
out_Of_Stock BOOLEAN,
quantity INTEGER
);

--data exploration

--count of rows
select count(*) from zepto_inventory;

--sample data
select * from zepto_inventory
limit 10;

--null values
select*from zepto_inventory
where name is null 
or
category is null
or
mrp is null
or
discountpercent is null
or
availablequantity is null
or
discountedsellingprice is null
or
weightsingms is null
or
outofstock is null
or
quantity is null

--different product categories
SELECT DISTINCT category
FROM zepto_inventory
ORDER BY category;

--products in stock vs out of stock
SELECT outofstock, COUNT(category)
FROM zepto_inventory
GROUP BY outofstock;

--product name present multiple times
SELECT name, COUNT(category) as "number of category"
FROM zepto_inventory
GROUP BY NAME
HAVING count(category) > 1
ORDER BY COUNT(category) DESC;

--DATA CLEANING

--PRODUCT WITH PRICE 0

SELECT * FROM zepto_inventory
WHERE mrp =0 or discountedsellingprice=0;

DELETE FROM zepto_inventory 
WHERE mrp=0;

--convert paise to rupees(currency conversion)

UPDATE zepto_inventory
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

SELECT mrp, discountedsellingprice FROM zepto_inventory


--BUSINESS INSIGHT QUERIES--

--Q1 find the top 10 best value products based on the discounted percentage.
SELECT DISTINCT name, mrp, discountpercent
FROM zepto_inventory
ORDER BY discountpercent desc
LIMIT 10;

--Q2 what are products with high MRP but out of stock?
SELECT DISTINCT name,mrp
FROM zepto_inventory
WHERE outofstock = TRUE and mrp>300
ORDER by mrp DESC

--Q3 Calculate estimated revenue for each category,
SELECT category,
SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto_inventory
GROUP BY category
ORDER BY total_revenue;

--Q4 find all product where MRP is greater than 500 and discount is less that 10%

SELECT DISTINCT name, mrp, discountpercent
FROM zepto_inventory
WHERE mrp > 500 and discountpercent < 10
ORDER by mrp desc, discountpercent DESC;

--Q5 identify the top 5 categories offering the highest average discount percentage.
SELECT category,
(AVG (discountpercent),2) AS avg_discount
FROM zepto_inventory
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--Q6 find the price per gram for the products above 100gms and sort by best values,
SELECT DISTINCT name, weightsinGms, discountedsellingprice,
ROUND(discountedsellingprice/weightsingms,2) AS price_per_Gram
FROM zepto_inventory
WHERE weightsingms >= 100
ORDER BY price_per_gram;

--07 group the product into categories like low, medium, bulk .
SELECT DISTINCT name, weightsingms,
CASE WHEN weightsingms < 1000 THEN 'low'
    WHEN weightsingms <5000 THEN 'medium'
   ELSE 'bulk'
   END AS weight_category
   FROM zepto_inventory;
   
--Q8 what is the total inventory weight per category.
SELECT category,
SUM(weightsingms * availablequantity) AS total_weight
FROM zepto_inventory
GROUP BY category
ORDER BY total_weight;

