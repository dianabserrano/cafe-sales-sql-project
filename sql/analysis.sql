-- Revenue per product
SELECT Item, SUM(`Total Spent`) AS revenue,
COUNT(*) AS transactions
FROM cafe_sales_clean
GROUP BY Item
ORDER BY revenue DESC;

-- most used payment method
SELECT `Payment Method`, COUNT(*) AS transactions
FROM cafe_sales_clean
GROUP BY `Payment Method`
ORDER BY transactions DESC;

-- sales by location
SELECT SUM(`Total Spent`) AS revenue, location
FROM cafe_sales_clean
GROUP BY Location
ORDER BY revenue DESC;