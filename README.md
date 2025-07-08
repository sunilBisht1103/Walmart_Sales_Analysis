# 🛒 Walmart Sales Analytics (SQL + Python Project)

![Project Pipeline](https://github.com/sunilBisht1103/Walmart_Sales_Analysis/blob/e98361693f8e43f4de0916f5421c90e1a3f309b6/walmart_image.png)



This project delivers advanced analytics on Walmart's transactional sales data using **SQL** and **Python**. It extends beyond basic analysis by incorporating advanced SQL techniques, Python, time-series analysis, anomaly detection, profitability optimization, and customer segmentation.

---

## 📌 Project Highlights

- **Advanced SQL Queries:**  
  Rolling averages, ranking, anomaly detection, price elasticity, and more.
  
- **ETL Pipeline (Python):**  
  Automated extraction, transformation, and loading (ETL) of raw transactional data into a relational database.

---

## 📂 Project Structure
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
├
├── Visuals/ # generated Figures & images
│ ├── figures
│ └── images
│
├── .gitignore # Files to ignore in Git
├── requirements.txt # Python dependencies
└── README.md # Project documentation
```
------


## 📊 Key Features & Insights

- 📈 **Time-Series Sales Trends** with Moving Averages
- 🕒 **Hourly Sales Patterns** and Contribution Shares
- 📌 **Top Product Categories** by Profit and Sales (Ranked per Branch)
- 🚨 **Anomaly Detection** for Sales Spikes/Dips
- 💳 **Payment Method Profitability** by City
- 🔗 **Price-Quantity Correlation** Analysis
- 👥 **Customer Segmentation** by Spending
- 🔥 **Monthly Growth Rate Analysis**

---

## ✅ Technologies Used

| Tool            | Purpose                             |
|-----------------|------------------------------------|
| **MYSql**       | Database & SQL Analytics            |
| **Python**      | ETL Automation, Data Processing     |
| **SQLAlchemy**  | Database Connectivity (Python ORM)  |
| **Pandas**      | Data Manipulation & Cleaning        |
| **Jupyter**     | Interactive Analysis                |

---

## ⚙️ Setup Instructions

1. **Clone the repository:**
```bash
git clone https://github.com/sunilBisht1103/Walmart_Sales_Analysis.git
cd walmart_advanced_analysis

```
2. **Set Up Kaggle API
   - **API Setup**: Obtain your Kaggle API token from [Kaggle](https://www.kaggle.com/) by navigating to your profile settings and downloading the JSON file.
   - **Configure Kaggle**: 
      - Place the downloaded `kaggle.json` file in your local `.kaggle` folder.
      - Use the command `kaggle datasets download -d <dataset-path>` to pull datasets directly into your project.
3. Download Walmart Sales Data
   - **Data Source**: Use the Kaggle API to download the Walmart sales datasets from Kaggle.
   - **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)
   - **Storage**: Save the data in the `data/` folder for easy reference and access.

4.Install Python Dependencies:
```python
pip install -r requirements.txt
```
  **Loading Data**: Read the data into a Pandas DataFrame for initial analysis and transformations.
  
5. Explore the Data
   - **Goal**: Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
   - **Analysis**: Use functions like `.info()`, `.describe()`, and `.head()` to get a quick overview of the data structure and statistics.
6. Data Cleaning
   - **Remove Duplicates**: Identify and remove duplicate entries to avoid skewed results.
   - **Handle Missing Values**: Drop rows or columns with missing values if they are insignificant; fill values where essential.
   - **Fix Data Types**: Ensure all columns have consistent data types (e.g., dates as `datetime`, prices as `float`).
   - **Currency Formatting**: Use `.replace()` to handle and format currency values for analysis.
   - **Validation**: Check for any remaining inconsistencies and verify the cleaned data.
7. Load Data into MySQL and PostgreSQL
   - **Set Up Connections**: Connect to MySQL and PostgreSQL using `sqlalchemy` and load the cleaned data into each database.
   - **Table Creation**: Set up tables in both MySQL and PostgreSQL using Python SQLAlchemy to automate table creation and data insertion.
   - **Verification**: Run initial SQL queries to confirm that the data has been loaded accurately.
8. SQL Analysis: Complex Queries and Business Problem Solving
   - **Business Problem-Solving**: Write and execute complex SQL queries to answer critical business questions, such as:
     - Revenue trends across branches and categories.
     - Identifying best-selling product categories.
     - Sales performance by time, city, and payment method.
     - Analyzing peak sales periods and customer buying patterns.
     - Profit margin analysis by branch and category.
   - **Documentation**: Keep clear notes of each query's objective, approach, and results.


🚀 Sample Queries Included:
7-day Rolling Averages

Spike Detection (Z-Score Method)

Profitability Heatmaps (Branch × Category)

Customer Lifetime Value (CLV) Segments

Hourly Sales Distribution (%)

Monthly Sales Growth (YoY Comparison)

---

## Future Enhancements

Possible extensions to this project:
- Integration with a dashboard tool (e.g., Power BI or Tableau) for interactive visualization.
- Additional data sources to enhance analysis depth.
- Automation of the data pipeline for real-time data ingestion and analysis.
---

## License

This project is licensed under the MIT License. 

---

## 🙌 Credits

This project is inspired by open Walmart sales datasets and expands on ideas from prior public projects, with a focus on advanced SQL analytics and scalable pipeline design.

---

## 📬 Contact

For collaboration, feel free to connect via GitHub or email: sunilbisht1131995@gmail.com

---

## 🌟 Contributions Welcome!

Feel free to fork this repo, add enhancements, or submit pull requests to improve or extend the analysis.
