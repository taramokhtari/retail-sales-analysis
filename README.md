# Retail Sales Analysis

## Project Overview

This project focuses on analyzing retail sales data to identify business trends, evaluate profitability, understand customer purchasing behavior, and generate actionable business insights.

The analysis is performed using Python and popular data analysis libraries, with an emphasis on data exploration, visualization, and business-oriented interpretation.

## Objectives

- Analyze overall sales and profitability.
- Identify monthly and yearly sales trends.
- Evaluate the impact of discounts on profit.
- Compare sales and profitability across product categories and subcategories.
- Analyze regional and customer segment performance.
- Identify the most and least profitable products and customers.
- Develop data-driven business recommendations.

## Dataset

**Dataset:** Sample Superstore

The dataset contains 9,994 retail order records and 21 columns, including:

- Order Date and Ship Date
- Customer and Order Information
- Product Category and Subcategory
- Sales, Quantity, Discount, and Profit
- Region and Shipping Information

The dataset covers transactions from 2014 to 2017.

**Note:** The dataset is not included in this repository. Place `Sample - Superstore.csv` inside the `data/` directory before running the notebook.

## Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
- VS Code
- Git & GitHub

## Project Structure

```text
retail-sales-project/
│
├── data/
│   └── Sample - Superstore.csv
│
├── notebooks/
│   └── 01_sales_data_exploration.ipynb
│
├── requirements.txt
├── README.md
└── .gitignore
```

## Analysis Performed

### 1. Data Exploration & Cleaning

- Examined dataset dimensions and data types.
- Checked for missing values and duplicate records.
- Converted date columns to appropriate datetime formats.
- Investigated negative profit values and high-discount transactions.
- Explored statistical summaries of numerical variables.

### 2. Sales & Profitability Analysis

- Evaluated total sales, total profit, and order volume.
- Compared sales and profit across product categories.
- Analyzed product subcategory performance.
- Calculated profit margins.
- Investigated the relationship between discounts and profitability.

### 3. Time-Based Analysis

- Analyzed monthly sales and profit trends.
- Compared annual business performance from 2014 to 2017.
- Calculated year-over-year growth rates.
- Evaluated average order value (AOV).

### 4. Regional & Customer Analysis

- Compared performance across geographical regions.
- Analyzed profitability by region and product category.
- Evaluated customer segment performance.
- Identified top-performing and loss-making customers.

### 5. Product & Shipping Analysis

- Identified the most profitable products.
- Investigated products generating significant losses.
- Compared shipping methods based on sales, profit, and order volume.

## Key Findings

### Discount Impact

- Transactions with discounts of 30% or higher showed negative average profitability.
- The 70% discount level generated the largest cumulative loss.
- High discounts were strongly associated with lower profitability.

### Product Performance

- Tables generated the largest cumulative loss among product subcategories.
- Bookcases and Supplies also showed negative cumulative profits.
- Copiers generated the highest cumulative profit among subcategories.
- Canon imageCLASS 2200 was among the strongest products in terms of sales and profit.
- Some high-sales products still generated losses.

### Regional Performance

- The West region achieved the highest overall sales and profit.
- The Central region had the lowest profit margin.
- Furniture in the Central region showed a negative profit margin.

### Customer Insights

- Consumer customers generated the highest total sales and profit.
- Home Office customers had the highest average order value and profit margin.
- High customer sales did not always translate into high profitability.

### Annual Performance

- Sales and order volume generally increased between 2014 and 2017.
- 2017 recorded the highest annual sales and profit.
- Profit growth in 2017 was slower than order growth, indicating the importance of monitoring profitability alongside sales expansion.

## Business Recommendations

1. **Review Discount Strategies:** Reassess high-discount transactions and introduce more profitability-focused discount policies.

2. **Investigate Loss-Making Products:** Review pricing, costs, and discount structures for underperforming products, especially in the Tables subcategory.

3. **Improve Regional Profitability:** Investigate the causes of low profitability in the Central region, particularly in Furniture.

4. **Focus on Profitable Products:** Use product-level profitability analysis to support inventory and sales decisions.

5. **Monitor Customer Value:** Evaluate customers based on profit contribution rather than sales volume alone.

6. **Track Profitability Alongside Growth:** Monitor profit margins, order volume, and average order value to ensure that sales growth translates into sustainable business performance.

## How to Run

### 1. Clone the Repository

```bash
git clone https://github.com/taramokhtari/retail-sales-analysis.git
cd retail-sales-analysis
```

### 2. Create a Virtual Environment

```bash
python -m venv .venv
```

### 3. Activate the Environment

**Linux / macOS:**

```bash
source .venv/bin/activate
```

**Windows:**

```bash
.venv\Scripts\activate
```

### 4. Install Dependencies

```bash
pip install -r requirements.txt
```

### 5. Add the Dataset

Create a `data/` directory and place the following file inside it:

```text
Sample - Superstore.csv
```

### 6. Run the Notebook

Open the following notebook in Jupyter Notebook or VS Code:

```text
notebooks/01_sales_data_exploration.ipynb
```

Run the cells sequentially to reproduce the analysis.

## Limitations

- The analysis identifies statistical relationships and patterns but does not establish causation.
- The dataset represents a limited historical period (2014–2017).
- Further analysis with additional operational and cost information could provide deeper business insights.

## Author

**Tara Mokhtari**

GitHub: [taramokhtari](https://github.com/taramokhtari)

---

*This project was developed as part of a practical learning portfolio in Python-based data analysis and business intelligence.*