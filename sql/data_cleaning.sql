SELECT * 
FROM dirty_cafe_sales
LIMIT 10;

-- Search for duplicates by `Transaction ID`.
SELECT `Transaction ID`, COUNT(*) AS count
FROM dirty_cafe_sales
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;

-- Removing blank spaces
UPDATE dirty_cafe_sales
SET item = TRIM(item);

-- Replacing "UNKNOWN" and "ERROR" by NULL.
UPDATE dirty_cafe_sales
SET item = NULL
WHERE item NOT IN ('Coffee', 'Cake', 'Cookie', 'Salad', 'Smoothie', 'Sandwich', 'Juice', 'Tea');

UPDATE dirty_cafe_sales
SET `total spent` = NULL
WHERE `total spent` IN ('UNKNOWN', 'ERROR', '');

UPDATE dirty_cafe_sales
SET `Transaction Date` = NULL
WHERE `Transaction Date` IN ('UNKNOWN', 'ERROR', '');

-- Correcting Data types
ALTER TABLE dirty_cafe_sales
MODIFY COLUMN `Transaction Date` DATE;

ALTER TABLE dirty_cafe_sales
MODIFY Quantity INT,
MODIFY `Price Per Unit` DECIMAL(10,2),
MODIFY `Total Spent` DECIMAL(10,2);

-- Handling nulls:
-- Checking for mathematical inconsistencies in the column "Total spent"
UPDATE dirty_cafe_sales
SET `Total Spent` = Quantity * `Price Per Unit`
WHERE `Total Spent` IS NULL;

-- Counting how many NULL values ​​there are in the remaining columns with nulls
SELECT
COUNT(*) total_rows,
SUM(Item IS NULL) null_item,
SUM(Quantity IS NULL) null_quantity,
SUM(`Price Per Unit` IS NULL) null_price,
SUM(`Payment Method` IS NULL) null_paymentmethod,
SUM(Location IS NULL) null_location,
SUM(`Transaction date` IS NULL) null_date
FROM dirty_cafe_sales;

SELECT *
FROM dirty_cafe_sales;

-- Since there are many missing values in Paymnet Method, we don't delete the rows, 
-- but instead create the "Unknown" category.
UPDATE dirty_cafe_sales
SET `Payment Method` = 'Unknown'
WHERE `Payment Method` IS NULL;

-- Same as before
UPDATE dirty_cafe_sales
SET Location = 'Unknown'
WHERE Location IS NULL;

-- As "item" is a critical value, we delete the rows with NULL values. 
DELETE FROM dirty_cafe_sales
WHERE Item IS NULL;

-- There aren't many missing values, so we remove the rows again.
DELETE FROM dirty_cafe_sales
WHERE `Transaction Date` IS NULL;

CREATE TABLE cafe_sales_clean AS
SELECT *
FROM dirty_cafe_sales;

SELECT *
FROM cafe_sales_clean;