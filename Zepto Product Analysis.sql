
-- Zepto Products Case Study

CREATE DATABASE IF NOT EXISTS zepto;
USE zepto;


DROP TABLE IF EXISTS products;


CREATE TABLE products (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN, 
    quantity INTEGER
);

INSERT INTO products (category, name, mrp, discountPercent, availableQuantity, discountedSellingPrice, weightInGms, outOfStock, quantity)
VALUES 
('Dairy', 'Milk', 29.00, 1.00, 100, 28.71, 1000, FALSE, 1),
('Snacks', 'Chips', 50.00, 10.00, 200, 45.00, 200, FALSE, 1),
('Beverages', 'Coca Cola', 60.00, 5.00, 150, 57.00, 500, FALSE, 1),
('Personal Care', 'Shampoo', 120.00, 15.00, 80, 102.00, 250, FALSE, 1),
('Grocery', 'Rice 5kg', 500.00, 8.00, 50, 460.00, 5000, FALSE, 1),
('Bakery', 'Bread', 40.00, 0.00, 90, 40.00, 400, TRUE, 1),
('Fruits', 'Apple 1kg', 150.00, 12.00, 70, 132.00, 1000, FALSE, 1);
-- Q1. How many rows (products) are in table?
-- Ans: 7 products.
SELECT COUNT(*) FROM products;

-- Q2. Show a sample of the products.
-- Ans: Shows all 7 rows (Milk, Chips, Coca Cola, Shampoo, Rice 5kg, Bread, Apple 1kg).
SELECT * FROM products LIMIT 10;

-- Q3. Are there any NULL values in important columns?
-- Ans: No rows returned → No NULL values.
SELECT * FROM products
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- Q4. What different product categories exist?
-- Ans: Bakery, Beverages, Dairy, Fruits, Grocery, Personal Care, Snacks.
SELECT DISTINCT category FROM products ORDER BY category;

-- Q5. How many products are in stock vs out of stock?
-- Ans: In Stock = 6, Out of Stock = 1 (Bread).

SELECT outOfStock, COUNT(sku_id) FROM products GROUP BY outOfStock;

-- Q6. Are there any duplicate product names?
-- Ans: No duplicates found.
SELECT name, COUNT(sku_id) AS NumberOfSKUs
FROM products
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;



-- Q7. Top 10 products by discount percentage.
-- Ans: Shampoo(15), Apple(12), Chips(10), Rice 5kg(8), Coca Cola(5), Milk(1), Bread(0).

SELECT name, mrp, discountPercent
FROM products
ORDER BY discountPercent DESC
LIMIT 10;

-- Q8. Which products are out of stock but have MRP > 300?
-- Ans: None (Bread is out of stock but MRP=40).
SELECT name, mrp
FROM products
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;

-- Q9. What is the estimated revenue per category?
-- Ans: 
-- Dairy = 2871
-- Snacks = 9000
-- Beverages = 8550
-- Personal Care = 8160
-- Grocery = 23000
-- Bakery = 3600
-- Fruits = 9240
-- Highest = Grocery (23000), Lowest = Dairy (2871).

SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM products
GROUP BY category
ORDER BY total_revenue DESC;
