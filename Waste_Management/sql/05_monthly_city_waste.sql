-- ============================================================
-- 05_monthly_city_waste.sql
-- Builds an aggregated (summary) table: total waste per
-- city per month. Useful for reporting / dashboards.
-- Run order: 5
-- ============================================================

IF OBJECT_ID('MonthlyCityWaste', 'U') IS NULL
BEGIN
    CREATE TABLE MonthlyCityWaste
    (
        [Year] INT,
        [Month] INT,
        City VARCHAR(100),
        TotalWaste DECIMAL(18,2)
    );
END;
GO

-- Clear old data so the script can be re-run without duplicating rows
TRUNCATE TABLE MonthlyCityWaste;
GO

INSERT INTO MonthlyCityWaste
(
    [Year],
    [Month],
    City,
    TotalWaste
)
SELECT
    d.[Year],
    d.[Month],
    s.City,
    SUM(f.Wastecollected)
FROM FactTrips f
JOIN DimDate d
    ON f.Dateid = d.dateid
JOIN DimStation s
    ON f.Stationid = s.Stationid
GROUP BY
    d.[Year],
    d.[Month],
    s.City;
GO

SELECT * FROM MonthlyCityWaste
ORDER BY [Year], [Month], City;
