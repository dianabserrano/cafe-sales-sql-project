# Cafe Sales Data Cleaning & Analysis (SQL Project)

## Project Overview

This project focuses on cleaning and analyzing a retail coffee shop sales dataset using SQL.
The dataset initially contained several common data quality issues such as missing values and inconsistent entries.
The goal of the project was to transform the raw dataset into a clean, reliable dataset ready for analysis, and then perform exploratory queries to generate business insights.

## Dataset Description

The dataset was obtained from [Kaggle](https://www.kaggle.com/).
It contains information about individual coffee shop transactions, including:
- Transaction ID
- Item purchased
- Quantity
- Price per unit
- Total amount spent
- Payment method
- Store location
- Transaction date

The raw dataset initially contained over 10,000 records with several data quality problems.

## Tools used
- MySQL Workbench

## Data Cleaning Stages

### 1. Handle invalid and missing values
Values such as "UNKNOWN" and "ERROR" were replaced with NULL to standardize missing data.

To handle NULLs, different strategies were applied depending on the column. First, I performed profiling showing how many NULL values ​​there are in each column with the following query:

```sql
SELECT
COUNT(*) total_rows,
SUM(Item IS NULL) null_item,
SUM(Quantity IS NULL) null_quantity,
SUM(`Price Per Unit` IS NULL) null_price,
SUM(`Payment Method` IS NULL) null_paymentmethod,
SUM(Location IS NULL) null_location,
SUM(`Transaction date` IS NULL) null_date
FROM dirty_cafe_sales;
```


Therefore, I performed the following strategy:
| Column | Description |
|--------|-------------|
| Item | Rows removed (critical field, and represent 9.5% of the dataset). |
| Payment Method |	It was replaced with "Unknown". Deleting the rows was not advisable, as we would lose 31% of the dataset.|
|Location |	Replaced with "Unknown". Similar to 'Payment Method'. |
|Transaction Date|	Rows removed (only 4.5% of the dataset). |
|Total Spent | It was validated to ensure: `Total Spent = Quantity * Price Per Unit`.|

### 2. Search for duplicates
Duplicate Transaction ID values were detected using `GROUP BY`.

### 3. Trim whitespaces
Whitespaces issues were resolved using the `TRIM()` function.

## Exploratory Data Analysis
After cleaning the dataset, several exploratoy queries were performed

### Top revenue-generating products
```sql
SELECT Item, SUM(`Total Spent`) AS revenue,
COUNT(*) AS transactions
FROM cafe_sales_clean
GROUP BY Item
ORDER BY revenue DESC;
```
### Average Order Value
How much does a customer spend per transaction.
```sql
SELECT AVG(`Total Spent`) as avg_order_value
FROM cafe_sales_clean;
```
### Sales by day of week
```sql
SELECT DAYNAME(`Transaction Date`) as day,
SUM(`Total Spent`) AS revenue
FROM cafe_sales_clean
GROUP BY day
ORDER BY revenue DESC;
```

## Example insights
Some insights obtained from the cleaned dataset include:

- Certain products, such as Salad, Sandwich and Smoothie, generate significantly higher revenue than others.
- From the sales by day, we can find behavioral patterns, for example, the peak days, being Monday, Sunday and Friday the days with the highest revenue.
- The average order value is useful for business decisions, and helps understand pricing strategy.

## Conclusion
This project demonstrates a typical data preparation workflow used in real-world analytics projects. By cleaning and validating raw transactional data, the dataset becomes suitable for further analysis and business decision-making.
