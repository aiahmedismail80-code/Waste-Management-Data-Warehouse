-- ============================================================
-- 04_analysis_queries.sql
-- Analytical queries on the star schema.
-- Run order: 4
-- ============================================================

-- 1. Total waste collected per city
SELECT
    s.City,
    SUM(f.Wastecollected) AS TotalWaste
FROM FactTrips f
JOIN DimStation s
    ON f.Stationid = s.Stationid
GROUP BY s.City
ORDER BY TotalWaste DESC;

-- 2. Trips and waste per truck type
SELECT
    t.TruckType,
    COUNT(*)              AS NumberOfTrips,
    SUM(f.Wastecollected) AS TotalWaste,
    AVG(f.Wastecollected) AS AverageWaste
FROM FactTrips f
JOIN DimTruck t
    ON f.Truckid = t.Truckid
GROUP BY t.TruckType
ORDER BY TotalWaste DESC;

-- 3. Monthly waste trend
SELECT
    d.[Year],
    d.[Month],
    d.Monthname,
    SUM(f.Wastecollected) AS TotalWaste
FROM FactTrips f
JOIN DimDate d
    ON f.Dateid = d.dateid
GROUP BY
    d.[Year],
    d.[Month],
    d.Monthname
ORDER BY
    d.[Year],
    d.[Month];
