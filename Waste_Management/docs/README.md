# Waste Collection Data Engineering Project (SQL Server)

A small data engineering project that loads CSV files into **SQL Server**, models them as a star schema, validates the data, and runs analytical queries and an aggregation step.

## Dataset

Four CSV files in `data/`:

| File             | Rows    | Description                          |
|------------------|---------|--------------------------------------|
| `FactTrips.csv`  | 106,400 | Waste-collection trips (fact table)  |
| `DimDate.csv`    | 350     | Calendar dimension                   |
| `DimStation.csv` | 19      | Stations and their cities            |
| `DimTruck.csv`   | 71      | Trucks and their types               |

See [docs/data_dictionary.md](docs/data_dictionary.md) for column details and table relationships.

## Tech Stack

- SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL

## Project Structure

```
.
├── README.md
├── data/                          # Source CSV files
├── sql/
│   ├── 01_create_tables.sql       # Star schema (tables, keys, constraints)
│   ├── 02_load_data.sql           # BULK INSERT of the CSV files
│   ├── 03_data_quality_checks.sql # Row counts, NULLs, duplicates, orphan keys
│   ├── 04_analysis_queries.sql    # Waste by city, truck type, month
│   └── 05_monthly_city_waste.sql  # Aggregated summary table
└── docs/
    ├── data_dictionary.md
    ├── transformation_steps.md
    ├── erd.png
    └── images/
```

## How to Run

1. Create an empty database in SQL Server and select it.
2. Run `sql/01_create_tables.sql`.
3. Open `sql/02_load_data.sql` and **change the CSV file paths** to where the files are on your machine, then run it.
4. Run `03_data_quality_checks.sql`, `04_analysis_queries.sql` and `05_monthly_city_waste.sql` in order.

## Documentation

- [Data Dictionary](docs/data_dictionary.md)
- [Transformation Steps](docs/transformation_steps.md)
