# Pharmacy Data Analysis

## Project Overview
This project simulates a real-world pharmacy database system. It includes the creation of normalized relational tables (`category`, `supplier`, `medicine`, `purchase`, `sale`), data insertion, and a series of business-oriented Oracle SQL queries to extract valuable insights regarding inventory levels, supplier performance, and sales tracking.

## Database Schema
The database consists of five primary relational tables:
- **CATEGORY**: Categorizes pharmaceutical products.
- **SUPPLIER**: Contains supplier contact and location details.
- **MEDICINE**: Stores product details, pricing, stock quantities, and category references.
- **PURCHASE**: Logs all restock operations and incoming shipments from suppliers.
- **SALE**: Tracks outgoing sales transactions, quantities, and prices.

## Analytical Queries & Solutions
The SQL script addresses the following business analytics tasks:
1. Calculate the total number of distinct medicines currently registered in the inventory.
2. Determine the total purchase expenditure from 'AzFarm LLC' within the last 30 days.
3. Identify the supplier who provided the highest product volume in the last 90 days.
4. Calculate the total sales transaction count and revenue generated over the past 7 days.
5. Retrieve the most expensive product in the inventory.
6. Find medicines where total purchased quantities exceed total sold quantities, leaving active remaining stock.
7. Determine which category holds the highest number of products.
8. Calculate the average selling price for each individual medicine based on sales history.
9. Count the number of distinct active suppliers who delivered products in the last month.
10. Identify medicines that had zero sales transactions recorded over the past month.

## Tech Stack & Tools
- Oracle SQL / PL/SQL
- Advanced SQL Techniques: Joins, Aggregations, Grouping, Subqueries, and Date Functions (`sysdate`)

## How to Use
1. Set up your Oracle database environment using the schema structure.
2. Execute the SQL queries sequentially to retrieve the analytical insights.
