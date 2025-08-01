# COVID-19 Data Analysis Project

This project provides a comprehensive analysis of COVID-19 data, exploring infection rates, mortality statistics, and vaccination progress across countries and continents. The SQL queries analyze pandemic trends and create visualizations-ready datasets for further exploration.
Key Analyses Performed.

## Global COVID-19 Statistics

- Total cases and deaths worldwide

- Death percentage calculation across all reported cases

- Daily trends in infections and fatalities

## Country-Level Analysis

- Highest infection rates relative to population

- Total death counts by country

- Case and death trends in specific countries (with United States as primary example)

## Continental Breakdown

- Death counts by continent

- Comparative analysis of continental impacts

- Exclusion of non-geographic groupings (income levels, EU aggregates)

## Vaccination Progress Tracking

- Daily vaccination numbers by country

- Rolling vaccination totals calculation

- Percentage of population vaccinated over time

## Technical Implementation
- Data Sources

    - COVID.Deaths table: Contains case and mortality statistics

    - COVID.Vaccinations table: Tracks immunization progress

## Advanced SQL Techniques

- Window Functions: Used to calculate rolling vaccination totals

- Common Table Expressions (CTEs): Implemented for complex calculations

- Temporary Tables: Created for intermediate result storage

- Views: Established for persistent visualization-ready datasets

## Key Metrics Calculated

- Death percentage (Total deaths / Total cases)

- Infection rate (Total cases / Population)

- Vaccination coverage (Rolling vaccinations / Population)

## Insights Generated
- Infection Patterns

- Identification of countries with highest infection rates relative to population

- Time-series analysis of infection growth

## Mortality Analysis

- Countries with highest absolute death counts

- Continental comparisons of COVID-19 fatalities

- Case fatality rate calculations

## Vaccination Progress

- Tracking of vaccination campaigns by country

- Calculation of population vaccination percentages

- Daily vaccination trend analysis

## Potential Applications

- Public health policy analysis

- Pandemic response evaluation

- Vaccination program effectiveness tracking

- Comparative studies between countries/regions
