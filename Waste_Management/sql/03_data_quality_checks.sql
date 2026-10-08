-- ============================================================
-- 03_data_quality_checks.sql
-- Validates the loaded data.
-- Run order: 3
-- Expected row counts: DimDate 350, DimStation 19,
--                      DimTruck 71, FactTrips 106,400
-- ============================================================

-- 1. Row counts per table
SELECT 'DimDate'    AS TableName, COUNT(*) AS RowsCount FROM DimDate
UNION ALL
SELECT 'DimStation' AS TableName, COUNT(*) AS RowsCount FROM DimStation
UNION ALL
SELECT 'DimTruck'   AS TableName, COUNT(*) AS RowsCount FROM DimTruck
UNION ALL
SELECT 'FactTrips'  AS TableName, COUNT(*) AS RowsCount FROM FactTrips;

-- 2. NULL check on the fact table (COUNT(col) skips NULLs,
--    so every count should equal TotalRows)
SELECT
    COUNT(*)              AS TotalRows,
    COUNT(Tripid)         AS TripidCount,
    COUNT(Dateid)         AS DateidCount,
    COUNT(Stationid)      AS StationidCount,
    COUNT(Truckid)        AS TruckidCount,
    COUNT(Wastecollected) AS WasteCount
FROM FactTrips;

-- 3. Duplicate keys (both queries should return no rows)
SELECT Tripid, COUNT(*) AS DuplicateCount
FROM FactTrips
GROUP BY Tripid
HAVING COUNT(*) > 1;

SELECT dateid, COUNT(*) AS DuplicateCount
FROM DimDate
GROUP BY dateid
HAVING COUNT(*) > 1;

-- 4. Orphan foreign keys: fact rows with no matching dimension row
--    (all three queries should return no rows)
SELECT f.Dateid
FROM FactTrips f
LEFT JOIN DimDate d
    ON f.Dateid = d.dateid
WHERE d.dateid IS NULL;

SELECT f.Stationid
FROM FactTrips f
LEFT JOIN DimStation s
    ON f.Stationid = s.Stationid
WHERE s.Stationid IS NULL;

SELECT f.Truckid
FROM FactTrips f
LEFT JOIN DimTruck t
    ON f.Truckid = t.Truckid
WHERE t.Truckid IS NULL;

-- 5. Sample of the joined data (sanity check on the joins)
SELECT TOP 20
    f.Tripid,
    d.[date],
    s.City,
    t.TruckType,
    f.Wastecollected
FROM FactTrips f
JOIN DimDate d
    ON f.Dateid = d.dateid
JOIN DimStation s
    ON f.Stationid = s.Stationid
JOIN DimTruck t
    ON f.Truckid = t.Truckid;

-- 6. Basic statistics on the measure
SELECT
    MIN(Wastecollected) AS MinWaste,
    MAX(Wastecollected) AS MaxWaste,
    AVG(Wastecollected) AS AvgWaste,
    SUM(Wastecollected) AS TotalWaste
FROM FactTrips;
