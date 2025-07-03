# Telecom-Churn-Analysis-Project
Performed churn analysis using SQL for data cleaning and Power BI for visualization. Created an interactive dashboard with KPIs and insights on revenue, tenure, contract types, and churn behavior to help telecom companies improve retention and decision-making. 


📌 Project Objective
The primary objective of this project is to perform an end-to-end Telecom Customer Churn Analysis by:

Extracting and cleaning raw customer data using SQL Server Management Studio (SSMS)

Transforming data for analytical modeling

Connecting to Power BI for interactive dashboarding

Uncovering actionable insights around churn rate, customer behavior, and revenue trends

The goal is to help the telecom business identify churn drivers, segment customers, and improve retention through data-driven decisions.

🛠️ Tools & Technologies Used
Tool	Purpose
SQL Server Management Studio (SSMS)	Data cleaning, transformation, schema validation
Power BI Desktop	Data visualization, dashboard creation
Microsoft Excel (optional)	Export/import tables
GitHub	Version control and project publishing

🧠 Skills Applied
SQL Data Cleaning & Transformation

Advanced SQL Queries (CTE, CASE, GROUP BY)

Data Type Conversions & Null Handling

Power BI Report & Dashboard Design

Data Modeling (relationships, slicers, KPIs)

Analytical Thinking & Data Storytelling

🗃️ Dataset Description
The project uses a raw Telecom dataset with the following key tables created/cleaned in SQL:

1. Telecom
Raw customer data including:

customerID, MonthlyCharges, TotalCharges, Contract, PaymentMethod, Churn, etc.

2. Telecom_Cleaned
Cleaned version of the Telecom table after:

Null handling

Revenue segmentation

Tenure binning

Churn flag creation

Gender normalization

3. Monthly Revenue Summary
Aggregated table showing monthly revenue by Payment Method

4. Average Spend Summary
Table with average MonthlyCharges and TotalCharges across all customers

5. Churn Rate Summary
Churn rate by Contract Type

⚙️ Key SQL Operations Performed
Handled Nulls & Trimmed Spaces

Converted TotalCharges from VARCHAR to FLOAT

Removed Duplicate CustomerIDs

Created ChurnFlag (Yes → 1, No → 0)

Segmented Revenue (High / Moderate / Regular)

Grouped Tenure into bins

Normalized categorical columns like Gender

Created a new Telecom_Cleaned materialized view

Summarized churn rate by contract and payment type

📊 Power BI Dashboard Overview
✅ Key KPIs
Total Customers

Average Monthly Charges

Churn Rate

Total Revenue

✅ Visuals Included
Visual	Insight
Churn Rate by Contract Type	Highest churn in month-to-month contracts
Revenue by Payment Method	Most revenue from Auto-pay methods
Churn by Tenure Group	Churn is highest in first year of service
Revenue Segment Pie Chart	Distribution of High vs Moderate revenue users
Churn by Gender	Slight variance between male and female churn
Customer Count by Contract	Majority of customers on monthly plans

✅ Interactivity
Slicer by Payment Method

Dynamic filters across charts

Formatted tooltips, consistent colors, and layout design

📌 Summary of Insights
📉 33% Churn Rate, primarily from short-tenure and month-to-month contracts

💳 Electronic Check users show the highest churn among payment methods

💰 High Revenue customers are fewer but valuable

🕒 Tenure Group 0–1 year has the most vulnerable customer segment

🎯 Opportunities exist in targeting better contracts and securing long-term clients

✅ Conclusion
This project successfully demonstrates the end-to-end analytics lifecycle — from raw data transformation in SQL to generating powerful business insights through Power BI. The findings can assist telecom companies in:

Improving customer retention strategies

Reducing churn via contract/promotion restructuring

Prioritizing high-revenue segments

