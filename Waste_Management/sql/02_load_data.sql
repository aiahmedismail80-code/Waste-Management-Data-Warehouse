-- ============================================================
-- 02_load_data.sql
-- Loads the CSV files into the tables.
-- Run order: 2 (after 01_create_tables.sql)
--
-- IMPORTANT: change the file paths below to the folder where
-- the CSV files are on YOUR machine (SQL Server must be able
-- to read that path).
-- Dimensions are loaded first, the fact table last (foreign keys).
-- ============================================================

BULK INSERT DimDate
FROM 'C:\Users\Name\Downloads\DimDate.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

BULK INSERT DimTruck
FROM 'C:\Users\Name\Downloads\DimTruck.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

BULK INSERT DimStation
FROM 'C:\Users\Name\Downloads\DimStation.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

BULK INSERT FactTrips
FROM 'C:\Users\Name\Downloads\FactTrips.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO
