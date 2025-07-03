--Creating Database

CREATE DATABASE TelecomDB;

--Imported the .csv file to the Database

--Printing the Table

USE TelecomDB;
GO

SELECT * FROM Telecom;

/*
In the Data Cleaning Process, We are going to Focus on the below Columns:

TotalCharges:- Cleaning & Conversion: Often stored as text; convert to numeric for aggregations.
MonthlyCharges:- Revenue Analysis: Used for revenue segmentation, KPIs, and churn correlation.
tenure:- Customer Loyalty: Used to create tenure groups or cohorts.
Contract:- Churn Insight: Important for understanding customer retention patterns.
Churn:- Target Variable: Used to create churn flag and calculate churn rates.
PaymentMethod:- Categorical Segmentation: Used in revenue and preference analysis.
SeniorCitizen:- Demographic Analysis: Converted to readable labels for filtering.
gender:- Demographic Cleaning: Standardized for consistency in visualizations.
OnlineSecurity:- Service Feature Analysis: Helps in feature-based churn analysis.
StreamingTV:- Service Usage: Helps in usage-based customer segmentation.
customerID:- De-duplication: Used to identify and remove duplicate records.
Partner, Dependents:- Family/Demographic Insight: Useful for segmentation and profiling.
*/

--1. Modifying the Column Names to Capitalising the first Digit
EXEC sp_rename 'Telecom.tenure', 'Tenure', 'COLUMN';
EXEC sp_rename 'Telecom.customerID', 'CustomerID', 'COLUMN';
EXEC sp_rename 'Telecom.gender', 'Gender', 'COLUMN';

--2. Checking for Null Values in the Column "TotalCharges"

SELECT COUNT(*) AS Null_TotalCharges
FROM Telecom	
WHERE TotalCharges IS NULL;

--Total 11 observations are Popped out from the Table where the TotalCharges are Null
--Removing the Rows where the TotalCharges are Null

DELETE FROM Telecom	
WHERE TotalCharges IS NULL

--3. Checking Duplicate CustomerID's if any
SELECT customerID, COUNT(*) AS Count
FROM Telecom
GROUP BY customerID
HAVING COUNT(*)>1;

-- Removing the Duplicate CustomerID's if any

WITH CTE AS (
	SELECT*,
		ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY CustomerID) AS rn
		FROM Telecom
		)
DELETE FROM CTE WHERE RN>1;
	

--4. Assigning Flag to the Customers based on MonthlyCharges by creating new column

ALTER TABLE Telecom
ADD RevenueSegment VARCHAR(20);

UPDATE Telecom
SET RevenueSegment = 
CASE
		WHEN MonthlyCharges > 80 THEN 'High'
		WHEN MonthlyCharges BETWEEN 40 AND 80 THEN 'Moderate'
		ELSE 'Regular'
	END;


--5. Grouping Tenure into Bins
ALTER TABLE Telecom
ADD TenureGroup VARCHAR(20)

UPDATE Telecom
SET TenureGroup = 

	CASE
		WHEN tenure BETWEEN 0 AND 12 THEN '0-1 Years'
		WHEN tenure BETWEEN 13 AND 24 THEN '1-2 Years'
		WHEN tenure BETWEEN 25 AND 48 THEN '2-4 Years'
		ELSE '4+ Years'
	END;

--6. Removing the Column Tenure
ALTER TABLE Telecom
DROP COLUMN Tenure;

--7. Removing Unwanted spaces

UPDATE Telecom	
SET gender = LTRIM(RTRIM(gender)),
	PaymentMethod = LTRIM(RTRIM(PaymentMethod));

--8. Identifying Value Spread in Columns
SELECT DISTINCT Contract FROM Telecom;
SELECT DISTINCT InternetService FROM Telecom;

--9. Calculating the Average Monthly Spends

SELECT
	AVG(MonthlyCharges) AS AvgMonthlySpend,
	AVG(TotalCharges) AS AvgTotalSpend

INTO AvgSpendSummery
FROM Telecom

--AvgMonthlySpend:- 64.7982082120116	
--AvgTotalSpend:- 2283.30044138554

--10. Finding Churn Rate by Contract Type

ALTER TABLE Telecom
ADD ChurnRate VARCHAR(10);

UPDATE Telecom
SET ChurnRate = 
    CASE 
        WHEN Churn = 1 THEN 'Yes'
        ELSE 'No'
    END;

SELECT 
	Contract,
	COUNT(*) AS TotalCustomers,
	SUM(CAST(Churn AS INT)) AS ChurnedCustomers,
	ROUND(
		(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(*))*100,2
		) AS ChurnRatePercentage

--Using "INTO ChurnRateSummary" to create a new table

INTO ChurnRateSummary
FROM Telecom
GROUP BY Contract;

--11. Monthly Revenue By Payment Method

SELECT PaymentMethod,
	SUM(MonthlyCharges) AS TotalMonthlyRevenue
FROM Telecom
GROUP BY PaymentMethod

--12. Deleting the Rows with Null Data

DELETE FROM	Telecom	
WHERE
	MultipleLines IS NULL
	OR OnlineBackup IS NULL
	OR OnlineBackup	IS NULL
	OR DeviceProtection IS NULL
	OR TechSupport IS NULL
	OR StreamingTV IS NULL
	OR StreamingMovies IS NULL;

--13. Preparing a Summery View
SELECT
	customerID,
	gender,
	CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Non-Senior' END AS SeniorStatus,
	Partner,
	Dependents,
	TenureGroup,
	MonthlyCharges,
	TotalCharges,
	Contract,
	PaymentMethod,
	CASE WHEN Churn = 1 THEN 1 ELSE 0 END AS ChurnFlag

INTO Telecom_Cleaned
FROM Telecom
WHERE TotalCharges IS NOT NULL;

SELECT *
FROM Telecom
SELECT *
FROM Telecom_Cleaned
