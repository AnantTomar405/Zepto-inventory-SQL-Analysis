# Zepto-inventory-SQL-Analysis
SQL-based data analysis project on zepto inventory dataset using postgreSQL and pgAdmin END-to-END SQL data analysis project using real Zepto inventory data, including data import, cleaning, querying and business insight generation.

## DATASET
the dataset includes:
- product category
- product name
- MRP
- discount percentage
- available Quantity
- Discounted selling price
- weights (grams)
- stock status

## TOOLS USED
- PostgreSQL
- pgADMIN 4
- SQL

## KEY ANALYSIS PERFORMED
- Category-wise product distribution
- Highest discounted products
- Most expensive products
- out-of-stock product analysis
- Inventory availablity analysis
- Price and discount trends

## SAMPLE QUERY
SELECT category,
COUNT(*) AS total_products
FROM zepto_inventrory
GROUP BY category
ORDER BY total_products DESC;

## LEARNING OUTCOMES
- Database creation amd management
- Importing CSV Data into postgreSQL
- Writing SQL queries For business analysis
- data Exploration Using real world Datasets

# AUTHOR
Anant tomar
(Aspiring Data Analyst)

