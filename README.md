# 🛒 Walmart Sales Analytics Project(SQL + Python) 

![Project Pipeline](https://github.com/sunilBisht1103/Walmart_Sales_Analysis/blob/e98361693f8e43f4de0916f5421c90e1a3f309b6/walmart_image.png)



This project delivers analytics on Walmart's transactional sales data using **SQL** and **Python**. It extends beyond basic analysis by incorporating advanced SQL techniques, Python, time-series analysis, anomaly detection, profitability optimization, and customer segmentation.

---

## Project Highlights

- **Advanced SQL Queries:**  
  Rolling averages, ranking, anomaly detection, price elasticity, and more.
  
- **ETL Pipeline (Python):**  
  Automated extraction, transformation, and loading (ETL) of raw transactional data into a relational database.

---

## Project Structure
```plaintext
Walmart_Sales_Analysis/
│
├── Data/ # Raw and processed data files
│ ├── raw_Data/ # Original CSV / SQL dumps
│ └── processed/ # Cleaned & aggregated datasets
│
├── SQL_Scripts/ # SQL scripts
|
├── Src/ # Python ETL modules
│ ├── analysis.ipynb # Exploratory data analysis
├── Visuals/ # generated Figures & images
│ ├── figures
│ └── images
├── requirements.txt # Python dependencies
└── README.md # Project documentation
```
------


## Key Features

- **Revenue & Profit Rank of Branches** 
- **Time-of-Day Sales Impact(Rolling Average by Hour)**
- **Top Product Categories** by Profit and Sales
- **Revenue Percentiles (Identifying VIP Transactions)**
- **Multi-Metric Ranking of Branches** Analysis
- **Product Pricing Optimization (Price Sensitivity Check)**
- **Monthly sales prediction Analysis**

---

## Technologies Used

| Tool            | Purpose                             |
|-----------------|------------------------------------|
| **MYSql**       | Database & SQL Analytics            |
| **Python**      | ETL Automation, Data Processing     |
| **SQLAlchemy**  | Database Connectivity (Python ORM)  |
| **Pandas**      | Data Manipulation & Cleaning        |
| **Jupyter**     | Interactive Analysis                |

---

## Setup Instructions

1. **Clone the repository:**
```bash
git clone https://github.com/sunilBisht1103/Walmart_Sales_Analysis.git
cd walmart_advanced_analysis
```

2. **Set Up Kaggle API**
   - **API Setup**: Obtain your Kaggle API token from [Kaggle](https://www.kaggle.com/) by navigating to your profile settings and downloading the JSON file.
   - **Configure Kaggle**: 
      - Place the downloaded `kaggle.json` file in your local `.kaggle` folder.
      - Use the command `kaggle datasets download -d <dataset-path>` to pull datasets directly into your project.
3. **Download Walmart Sales Data**
   - **Data Source**: Use the Kaggle API to download the Walmart sales datasets from Kaggle.
   - **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)
   - **Storage**: Save the data in the `data/` folder for easy reference and access.

4. **Install Python Dependencies:**
```python
pip install -r requirements.txt
```
  **Loading Data**: Read the data into a Pandas DataFrame for initial analysis and transformations.
  
5. **Explore the Data**
   - **Goal**: Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
   - **Analysis**: Use functions like `.describe()`, and `.head()` to get a quick overview of the data structure and statistics.
   - 
6. **Data Cleaning**
   - **Remove Duplicates**: Identify and remove duplicate entries to avoid skewed results.
   - **Handle Missing Values**: Drop rows or columns with missing values if they are insignificant; fill values where essential.
   - **Fix Data Types**: Ensure all columns have consistent data types (e.g., dates as `datetime`, prices as `float`).
   - **Currency Formatting**: Use `.replace()` to handle and format currency values for analysis.
   
7. **Load Data into MySQL**
   - **Set Up Connections**: Connect to MySQL using `sqlalchemy` and load the cleaned data into database.
   - **Table Creation**: Set up tables in MySQL using Python SQLAlchemy to automate table creation and data insertion.
   - **Verification**: Run initial SQL queries to confirm that the data has been loaded accurately.
   - 
8. **Data Analysis**
     SQL Analysis:
   - **Business Problem-Solving**: Write and execute SQL queries to answer critical business questions, such as:
     - Revenue trends across branches and categories.
     - Identifying best-selling product categories.
     - Analyzing peak sales periods and customer buying patterns.
    Python Analysis:
    -Predictive Analytics (Sales Forecast & Customer Churn Prediction)

 9. **Documentation**: Keep clear notes of each query's objective, approach, and results.

---

## Results and Insights

This section will include your analysis findings:

**Sales Insights**

-Revenue & Profit Rank of Branches
```sql
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
```
Insight: Quickly identify the best & worst performing branches in both sales & profitability.

-Category Contribution % (to Total Sales & Profit)
```sql
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
  FROM walmart_sales
)
SELECT 
  c.category,
  c.total_sales,
  ROUND((c.total_sales / t.overall_sales) * 100, 2) AS sales_percentage,
  c.total_profit,
  ROUND((c.total_profit / t.overall_profit) * 100, 2) AS profit_percentage
FROM category_summary c, totals t
ORDER BY sales_percentage DESC;
```
Insight: Helps with product strategy & inventory planning — focus on high-contribution categories.

**Pricing**

-Product Pricing Optimization (Price Sensitivity Check)
```sql
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
```
Insight: Reveals how pricing strategy impacts units sold, revenue, and customer satisfaction.

**Customer Behavior**

-Revenue Percentiles (Identifying VIP Transactions)
```sql
WITH percentiles AS (
  SELECT 
    invoice_id,
    total,
    NTILE(10) OVER (ORDER BY total DESC) AS revenue_decile
  FROM walmart
)
SELECT *
FROM percentiles
WHERE revenue_decile = 1;
```
Insight: Focus on top 10% of high-spend customers for targeted marketing (loyalty programs, premium services).

-Time-of-Day Sales Impact (Rolling Average by Hour)
```sql
WITH hourly_sales AS (
  SELECT 
    HOUR(TIME(time)) AS hour,
    SUM(total) AS total_sales
  FROM walmart
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
```
Insight: Understand sustained peak hours instead of isolated spikes for better staffing & promotion planning.

**Strategic Recommendations Based on These Analyses:**
```plaintext
Focus Campaigns: Target top-decile customers and high-profit categories.

Branch Optimization: Shift resources to low-performing branches based on composite scores.

Staffing & Operations: Adjust staffing for peak hours based on moving average sales.

Pricing Strategy: Optimize high-demand price bands with favorable ratings.
```

**Sales Forecast Prediction**


![Project Pipeline](https://github.com/sunilBisht1103/Walmart_Sales_Analysis/blob/89ef28ff814d9ab814c56a290ecf4de8afd5dc36/Visuals/Figures/Sales_Forecast.png)

```plaintext
Here’s how to turn that downward forecast around and drive growth across your Walmart stores:

1. Boost Sales with Strategic Promotions & Events
Capitalize on seasonal moments: Launch early back-to-school events 
Use flash sales and limited-time offers: Create urgency and foot traffic

2. Reinforce Everyday Low Prices (EDLP)
Maintain consistent low pricing—even under cost pressure—to build loyalty and gain share 
Implement price intelligence tools (e.g., Savings Checker, repricing) to match local competition

3. Leverage Tech & Data
Adopt AI for personalized recommendations, inventory optimization, and digital twins for store layout testing 
Use analytics: basket analysis, segmentation, demand forecasting—also weather-sensitive SKU planning .

4. Elevate In‑Store Experience
Optimize store layout, visual merchandising, and sensory elements (music/scent) to increase dwell time and basket size 
Improve checkout flow: deploy self-checkout, mobile POS, queue busting, and Scan & Go tech

5. Expand Omnichannel & Bundling
Strengthen “bricks & clicks” model—online orders with in-store pick-up drive extra in-store purchases (~70% bump) 
Offer bundles or kits to increase AOV and control slow-moving inventory 

6. Tailor Products Locally & Diversify
Customize assortments by branch: local preferences and seasonal demand boost relevance .
Expand offerings (e.g., B2B bulk supplies, private-label ranges) to tap varied revenue streams 
```
**Churn Risk Detection (Customers with Low Ratings & Visits)**
```plaintext
1.Activate Pre‑Churn Interventions
-Personalized outreach: Send discounts, tailored recommendations, or engage via their preferred channel (email, SMS, app).

-Improve onboarding and service: Contact customers with issues (low ratings) to fix problems and boost satisfaction.

-Loyalty and value reinforcement: Offer perks, tiered rewards.

2.Implement Win‑Back & Reactivation Campaigns
For those already churned or flagged high-risk:

-Timed outreach: Send incentives or exclusive offers at right intervals—too early or too late reduces effectiveness.

-Segmented messaging: Use reasons for churn (e.g., price vs. experience) to craft relevant campaigns.
```
## Future Enhancements

Possible extensions to this project:
- Integration with a dashboard tool (e.g., Power BI or Tableau) for interactive visualization.
- Additional data sources to enhance analysis depth.
- Automation of the data pipeline for real-time data ingestion and analysis.
---

## License

This project is licensed under the MIT License. 

---

## Credits

This project is inspired by open Walmart sales datasets and expands on ideas from prior public projects, with a focus on advanced SQL analytics and scalable pipeline design.

---

## Contact

For collaboration, feel free to connect via GitHub or email: sunilbisht1131995@gmail.com

---

## Contributions Welcome!

Feel free to fork this repo, add enhancements, or submit pull requests to improve or extend the analysis.
