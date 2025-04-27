# FIFA 21 Player Data Warehouse Project

## Project Overview
In this project, I designed and built a data warehouse to support the analysis of FIFA 21 player data for a sports analytics company. Starting from messy raw data sourced from Kaggle, I applied data cleaning, transformation, and data warehouse best practices to enable efficient analytical querying focused on player performance, clubs, nationalities, and positions.

## Dataset Summary and Issues Identified

The FIFA 21 dataset contains approximately 18,979 rows and 76 columns. It captures detailed information on player attributes, including:
- Personal information: name, age, nationality
- Club details and contract information
- Position and performance stats (pace, shooting, etc.)
- Physical attributes: height, weight
- Financial metrics: wages, market value

**Data Quality Issues Identified:**
- Missing values across key fields
- Inconsistent formats (e.g., height in feet/inches and cm)
- Financial figures in mixed formats with currency symbols (e.g., "€100K", "€1.5M")
- Weight recorded as strings with "lbs"
- Redundant/unstructured text (e.g., player long names, contract descriptions)
- Incorrect data types (numeric fields stored as objects)

## Data Transformations Applied

The dataset was cleaned and transformed through the following steps:
- **Missing Value Imputation:**  
  Numerical columns filled with median values; categorical columns filled with "Unknown".
  
- **Height Conversion:**  
  Heights converted from feet/inches to centimeters.
  
- **Weight Cleaning:**  
  Weight values stripped of "lbs" and converted to numeric types.
  
- **Monetary Value Conversion:**  
  Wage, Value, and Release Clause columns standardized into numeric values (thousands/millions).
  
- **Contract Date Standardization:**  
  Contract dates formatted consistently as 'YYYY-MM-DD'.
  
- **Position Grouping:**  
  Created a new "Player Role" column grouping positions into "Forward", "Midfielder", "Defender", or "Goalkeeper".
  
- **Redundant Column Removal:**  
  Dropped unnecessary columns like 'LongName' and 'ID'.

## Star Schema Design

**Fact Table: `PlayerPerformance`**
- PlayerID (FK from PlayerDim)
- TimeID (FK from TimeDim)
- ClubID (FK from ClubDim)
- NationalityID (FK from NationalityDim)
- PositionID (FK from PositionDim)
- OverallRating
- Wages

**Dimension Tables:**
- **PlayerDim**
  - PlayerID
  - Name
  - Age
  - Height_cm
  - Weight_kg

- **TimeDim**
  - TimeID
  - Year
  - Month

- **ClubDim**
  - ClubID
  - ClubName
  - League

- **NationalityDim**
  - NationalityID
  - Country

- **PositionDim**
  - PositionID
  - Position
  - Role (Forward, Midfielder, etc.)

**Star Schema Layout:**
- Central Fact Table: `PlayerPerformance`
- Connected Dimension Tables: `PlayerDim`, `TimeDim`, `ClubDim`, `NationalityDim`, and `PositionDim`

## Justification of Schema Design

The star schema supports fast analytical queries by separating measurable metrics (fact table) from descriptive attributes (dimension tables).  
This structure enhances performance, simplifies query design, and ensures scalability. Analytical queries like "average wages by club" or "average ratings by position and nationality" are easy to execute.

## OLAP Capabilities Enabled

- **Aggregation:**  
  Summarizing metrics such as average wages or total players by club or nationality.
  
- **Slicing:**  
  Filtering data by nationality, age group, or performance criteria.

- **Roll-up:**  
  Grouping data across multiple dimensions (e.g., by nationality and position).

- **Drill-down:**  
  Exploring detailed breakdowns of player performance trends over time (e.g., yearly analysis).

## Potential Improvement to the Data Warehouse

**Suggested Enhancement:**  
Introduce a new **League Dimension** to categorize players based on the football leagues they participate in (e.g., Premier League, La Liga, Serie A).

**Benefit:**  
It would enable deeper analysis such as comparing player wages and performance across different leagues, leading to richer and more granular insights.
