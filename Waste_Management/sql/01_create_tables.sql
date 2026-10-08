-- ============================================================
-- 01_create_tables.sql
-- Creates the star schema: 3 dimension tables + 1 fact table
-- Run order: 1
-- ============================================================

CREATE TABLE DimDate
(
    dateid INT NOT NULL,
    [date] DATE NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    QuarterName VARCHAR(20) NOT NULL,
    [Month] INT NOT NULL,
    Monthname VARCHAR(20) NOT NULL,
    [Day] INT NOT NULL,
    Weekday INT NOT NULL,
    WeekdayName VARCHAR(20) NOT NULL,

    CONSTRAINT PK_DimDate
        PRIMARY KEY (dateid)
);
GO

CREATE TABLE DimStation
(
    Stationid INT NOT NULL,
    City VARCHAR(100) NOT NULL,

    CONSTRAINT PK_DimStation
        PRIMARY KEY (Stationid)
);
GO

CREATE TABLE DimTruck
(
    Truckid INT NOT NULL,
    TruckType VARCHAR(50) NOT NULL,

    CONSTRAINT PK_DimTruck
        PRIMARY KEY (Truckid)
);
GO

CREATE TABLE FactTrips
(
    Tripid INT NOT NULL,
    Dateid INT NOT NULL,
    Stationid INT NOT NULL,
    Truckid INT NOT NULL,
    Wastecollected DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_FactTrips
        PRIMARY KEY (Tripid),

    CONSTRAINT FK_FactTrips_Date
        FOREIGN KEY (Dateid)
        REFERENCES DimDate(dateid),

    CONSTRAINT FK_FactTrips_Station
        FOREIGN KEY (Stationid)
        REFERENCES DimStation(Stationid),

    CONSTRAINT FK_FactTrips_Truck
        FOREIGN KEY (Truckid)
        REFERENCES DimTruck(Truckid)
);
GO
