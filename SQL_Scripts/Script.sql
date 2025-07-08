--1. Revenue & Profit Rank of Branches (Window Functions) Find which branch ranks highest in sales and profit.

WITH branch_summary AS (
  SELECT 
    branch,
    city,
    SUM(total) AS total_sales,
    SUM(profit_margin) AS total_profit
  FROM walmart
  GROUP BY branch, city
)
SELECT *,
  RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
  RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM branch_summary;

--2. Category Contribution % (to Total Sales & Profit) Shows each category’s percentage contribution toward total sales & profit.

WITH category_summary AS (
  SELECT 
    category,
    SUM(total) AS total_sales,
    SUM(profit_margin) AS total_profit
  FROM walmart
  GROUP BY category
),
totals AS (
  SELECT 
    SUM(total) AS overall_sales,
    SUM(profit_margin) AS overall_profit
  FROM walmart
)
SELECT 
  c.category,
  c.total_sales,
  ROUND((c.total_sales / t.overall_sales) * 100, 2) AS sales_percentage,
  c.total_profit,
  ROUND((c.total_profit / t.overall_profit) * 100, 2) AS profit_percentage
FROM category_summary c, totals t
ORDER BY sales_percentage DESC;

--3. Revenue Percentiles (Identifying VIP Transactions) Identify transactions in the top 10% revenue percentile (High-Value Customers).

WITH percentiles AS (
  SELECT 
    invoice_id,
    total,
    NTILE(10) OVER (ORDER BY total DESC) AS revenue_decile
  FROM walmart_sales
)
SELECT *
FROM percentiles
WHERE revenue_decile = 1;

--4.Time-of-Day Sales Impact (Rolling Average by Hour) Smooth out hourly sales using moving average to detect trends.

WITH hourly_sales AS (
  SELECT 
    HOUR(TIME(time)) AS hour,
    SUM(total) AS total_sales
  FROM walmart_sales
  GROUP BY hour
),
rolling_avg AS (
  SELECT 
    hour,
    total_sales,
    ROUND(AVG(total_sales) OVER (ORDER BY hour ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS moving_avg_sales
  FROM hourly_sales
)
SELECT *
FROM rolling_avg
ORDER BY hour;



5. Dynamic Sales Targets (Sales % Achieved)
Compare each branch’s sales against average branch target dynamically.

WITH branch_sales AS (
  SELECT 
    branch,
    SUM(total) AS total_sales
  FROM walmart
  GROUP BY branch
),
avg_target AS (
  SELECT ROUND(AVG(total_sales), 2) AS avg_sales_target
  FROM branch_sales
)
SELECT 
  b.branch,
  b.total_sales,
  a.avg_sales_target,
  ROUND((b.total_sales / a.avg_sales_target) * 100, 2) AS target_achievement_percentage
FROM branch_sales b, avg_target a
ORDER BY target_achievement_percentage DESC;

--6. Multi-Metric Ranking of Branches (Composite Index) Create a custom ranking based on multiple metrics (Sales + Profit + Customer Rating).

WITH branch_metrics AS (
  SELECT 
    branch,
    SUM(total) AS total_sales,
    SUM(profit_margin) AS total_profit,
    ROUND(AVG(rating), 2) AS avg_rating
  FROM walmart_sales
  GROUP BY branch
),
ranked AS (
  SELECT *,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
    RANK() OVER (ORDER BY avg_rating DESC) AS rating_rank
  FROM branch_metrics
)
SELECT branch,
       total_sales,
       total_profit,
       avg_rating,
       sales_rank,
       profit_rank,
       rating_rank,
       (sales_rank + profit_rank + rating_rank) AS composite_score
FROM ranked
ORDER BY composite_score ASC;

--7. Product Pricing Optimization (Price Sensitivity Check) Analyze sales performance across unit price bands:

SELECT 
  CASE 
    WHEN unit_price < 50 THEN 'Low Price'
    WHEN unit_price BETWEEN 50 AND 100 THEN 'Mid Price'
    ELSE 'High Price'
  END AS price_band,
  SUM(quantity) AS total_units_sold,
  SUM(total) AS total_revenue,
  ROUND(AVG(rating), 2) AS avg_rating
FROM walmart_sales
GROUP BY price_band
ORDER BY total_revenue DESC;
