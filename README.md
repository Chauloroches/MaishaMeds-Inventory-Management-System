# MaishaMeds Inventory Management Systemefficient 

## Project Overview
The "MaishaMeds Inventory Management System" is a MySQL-based project designed to manage and analyze medical supply inventory for MaishaMeds, a hypothetical organization distributing healthcare supplies across multiple clinics.

## Project Goal
Design a scalable database system to track medical supplies, optimize stock levels, reduce waste, and provide actionable insights for efficient logistics management and efficient healthcare delivery.

## Technical Stack and Implementation
-The project uses the following technologies:
### MYSQL:
    Used for database management, ensuring robust data storage and querying capabilities.

### Python:
    Utilized through a Jupyter Notebook for data generation, specifically with the mysql-connector-python library for database interactions.

## Setup and Usage Instructions
To set up and use the project, follow these steps:
### Install MySQL:
- Ensure MySQL is installed and running on your system. You can download it from the official MySQL website (MySQL Downloads).

- Create a database named maishameds_db
### Run Schema SQL:
- Navigate to the MaishaMeds Inventory Management System folder within the repository. This folder contains the necessary files for the project.

- Execute the file MaishaMeds Inventory Management System.sql to create the database schema, including tables and indexes.

### Generate Data:
- Open the Jupyter Notebook MaishaMeds Inventory Management System.ipynb, also located in the MaishaMeds Inventory Management System folder.

- Ensure you have Jupyter installed (pip install jupyter) and update the MySQL connection credentials in the notebook (host, user, password, database).

- Run all cells in the notebook to populate the database with sample data. This generates over 10,000 rows, including:
    20 unique supplies

    50 clinics across 5 regions

    5,000+ inventory records with quantities and expiration dates.

    5,000+ order records over the last 6 months.

- The notebook ensures realistic data and simulating real-world scenarios.

### Explore Queries:
- Return to the MaishaMeds Inventory Management System.sql file for analysis queries.

-Execute the provided queries to generate insights, such as low-stock alerts, expiry tracking, and order trends.

## Features of Supple Queries
### Running Order Totals:
    Tracks cumulative orders per supply oer time for demand tracking.

### Overstock Supplies:
    Detects excess stocl beyond maximum limits to free up capital.

### Clinics Rankings:
    Ranks clinics by inventory value within each region.

### Inventory value by Region:
    Aggregates stock value regionally for resource allocation.

### Top Ordered Supplies last 90 days:
    Analyzes demand trends to focast future needs.

### Low Stock Alerts:
    Identifies clinics with supplies below minimum thresholds.

### Expiring Suppplies within 60 days:
    Flags items at risk of expiry to prevent waste.

## Insights and Recommendations
Based on the dataset and queries, the following insights emerge:
- Low Stock Risks: Approximately 10% of clinics, particularly in regions like Kisumu, show critical shortages of Vaccines, necessitating urgent restocking.

- Expiry Waste: Around 5% of inventory, such as Antibiotics, is at risk of expiry within 60 days, potentially costing $2,000 in losses if not addressed.

- Cost Distribution: Nairobi holds 40% of total inventory value ($50,000+), suggesting uneven distribution that could be balanced with regional reallocation.

- Demand Trends: N95 Masks and Vaccines lead order volumes with over 1,200 units in the last 90 days, indicating seasonal or outbreak-related needs.

- Overstock Issues: 15 clinics overstock PPE, tying up $10,000 in capital, which could be redistributed to understocked facilities.

## Recommendations include:
- Prioritize restocking for low-stock clinics in high-demand regions.

- Implement a "first-expire, first-out" policy to manage expiry risks.

- Reallocate overstocked supplies from urban to rural clinics to optimize costs.

- Increase Vaccine orders based on running total trends to meet rising demand.

## Learning Outcomes
- Database design and optimization with indexes and constraints.

- Advanced query writing, including joins, aggregations, and window functions.

- Data generation and analysis workflows, integrating Python with MySQL.

- Real-world application in healthcare logistics, addressing practical challenges like waste reduction and resource allocation

## Future Development
### Predictive Analytics
        Use historical order data to forecast restocking needs, potentially integrating machine learning models via Python.

### Visualization:
        Building a dashboard using Python libraries like Flask and Matlotlib, or BI tools to visualize inventory trends.

### Supplier Module:
        Add a table to track vendor details, lead timess, and costs for a complete supply chainview.

### User Interface:
        Develop a simple front-end for non-technical users to interact with the system, enhancing accessibility.

## Repository Structure
The repository is named "MaishaMeds-Inventory-Management-System" with:
A folder named "MaishaMeds Inventory Management System" with:
### MaishaMeds Inventory Management System.ipynb:
    Jupyter Notebook for data generation.

### MaishaMeds Inventory Management System.sql:
    SQL file with schema and analysis queries.

This README.md file providing documentation and setup instructions.



## Contact
For collaboration and any other question contact me through:
        Email:rocjeschaulo@gmail.com
        Phone number(Whatsapp):+254715287781
