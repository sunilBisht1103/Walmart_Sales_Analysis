# 🛒 Walmart Sales Analytics (SQL + Python Project)

![Project Pipeline](https://github.com/sunilBisht1103/Walmart_Sales_Analysis/blob/e98361693f8e43f4de0916f5421c90e1a3f309b6/walmart_image.png)



This project delivers advanced analytics on Walmart's transactional sales data using **SQL** and **Python**. It extends beyond basic analysis by incorporating advanced SQL techniques, Python, time-series analysis, anomaly detection, profitability optimization, and customer segmentation.

---

## 📌 Project Highlights

- **Advanced SQL Queries:**  
  Rolling averages, ranking, anomaly detection, profitability heatmaps, customer segmentation, price elasticity, and more.
  
- **ETL Pipeline (Python):**  
  Automated extraction, transformation, and loading (ETL) of raw transactional data into a relational database.

---

## 📂 Project Structure
```plaintext
walmart_advanced_analysis/
│
├── data/ # Raw and processed data files
│ ├── raw/ # Original CSV / SQL dumps
│ └── processed/ # Cleaned & aggregated datasets
│
├── sql/ # SQL scripts
│ ├── 00_schema.sql # Table creation, indexes
│ ├── 01_basic_queries.sql # Basic summary queries
│ ├── 02_advanced_queries.sql # Advanced analytics queries
│ └── views/ # (Optional) materialized views
│
├── src/ # Python ETL modules
│ ├── db.py # DB connection utilities
│ ├── extract.py # Load raw data
│ ├── transform.py # Clean & transform data
│ └── load.py # Load data into DB
│
├── notebooks/ # Jupyter Notebooks for analysis
│ ├── eda.ipynb # Exploratory data analysis
│ └── advanced_analysis.ipynb # Advanced visual analytics
│
├── reports/ # Auto-generated reports & figures
│ ├── figures/
│ └── summary_report.md
│
├── tests/ # Tests for DB & SQL queries
│ ├── test_db.py
│ └── test_queries.sql
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

Install Python Dependencies:
```python
pip install -r requirements.txt
Set up PostgreSQL Database (or SQLite):

psql -U youruser -d walmart_analytics -f sql/00_schema.sql
Run ETL Pipeline:

python -m src.extract
python -m src.transform
python -m src.load
```
Run SQL Queries:

Basic: sql/01_basic_queries.sql

Advanced: sql/02_advanced_queries.sql

Explore Jupyter Notebooks:

bash
Copy
Edit
jupyter notebook notebooks/

🚀 Sample Queries Included:
7-day Rolling Averages

Spike Detection (Z-Score Method)

Profitability Heatmaps (Branch × Category)

Customer Lifetime Value (CLV) Segments

Hourly Sales Distribution (%)

Monthly Sales Growth (YoY Comparison)

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
🌟 Contributions Welcome!

Feel free to fork this repo, add enhancements, or submit pull requests to improve or extend the analysis.
