ALTER TABLE Telecom_Cleaned
ADD RevenueSegment VARCHAR(20);


UPDATE Telecom_Cleaned
SET RevenueSegment = 
    CASE 
        WHEN MonthlyCharges > 80 THEN 'High'
        WHEN MonthlyCharges BETWEEN 40 AND 80 THEN 'Moderate'
        ELSE 'Regular'
    END;

SELECT customerID, MonthlyCharges, RevenueSegment
FROM Telecom_Cleaned
ORDER BY RevenueSegment;

SELECT *
FROM Telecom
